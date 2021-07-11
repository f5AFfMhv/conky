#!/bin/bash
# Script for gathering weather forecast from api.meteo.lt service
#
# By Martynas J. 2021

# Variables
# Location in Lithuania
LOCATION="vilnius"
# Service URL
API="https://api.meteo.lt"
# Server timeout in seconds
TIMEOUT=5
# How many hours to parse
HOURS=12
# Flag for returning forecast creation time
FORECAST_T=false
# Flag for saving API call response to file
DEBUG=false

# Degree celcius
#DEG=$'\xe2\x84\x83'
DEG="°C"
# Regular expression for matching integers
INTEGERS_RE='^[0-9]+$'
# Color text decorations 
green="\e[0;92m"
red="\e[0;91m"
blue="\e[0;94m"
yellow="\e[0;33m"
reset="\e[0m"

# Help message
HELP="
    Script for gathering weather forecast from api.meteo.lt service\n\n
    ${yellow}USAGE:${reset}\n
        \t $(basename "${BASH_SOURCE[0]}") [OPTIONS]\n\n
    ${yellow}OPTIONS:${reset}\n
        \t ${green}-h, --help${reset}\n   
            \t\tPrint this help message and exit.\n
        \t ${green}-u, --forecast_time${reset}\n
            \t\tReturns date when forecast was last updated.\n
        \t ${green}-d, --debug${reset}\n
            \t\tSaves response from API call to ${blue}debug_out.json${reset}.\n
        \t ${green}-l, --location <location name>${reset}\n
            \t\tLocation in Lithuania.\n
        \t ${green}-t, --hours <number of hours>${reset}\n
            \t\tHow many hours of forecast to return.\n
        \n
    ${yellow}EXAMPLES:${reset}\n
        \t ./$(basename "${BASH_SOURCE[0]}") -u\n
            \t\t${red}2021-07-11 03:00${reset}\n
        \t ./$(basename "${BASH_SOURCE[0]}") --location palanga -t 3\n
            \t\t${red}17:00\t23.7℃\tclear\n\t\t18:00\t23.2℃\tclear\n\t\t19:00\t22.8℃\tclear${reset}\n
"

# Parse input arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -u) FORECAST_T=true ;;
        --forecast_time) FORECAST_T=true ;;
        -d) DEBUG=true;;
        --debug) DEBUG=true ;;
        -l) LOCATION=$2
        shift ;;
        --location) LOCATION=$2
        shift ;;
        -t) HOURS=$2
        shift ;;
        --hours) HOURS=$2
        shift ;;
    *) echo -e $HELP
      exit 0 ;;
esac
shift
done

# API call URL for specified location
URL="https://api.meteo.lt/v1/places/$LOCATION/forecasts/long-term"

# Check if jq installed
if ! command -v jq &> /dev/null; then
    echo "ERROR: jq is not installed"
    exit 1
fi

# Check if meteo.lt is available
if [[ -z $(curl --connect-timeout $TIMEOUT -Is $API) ]]; then
    echo "ERROR: $API unavailable"
    exit 1
fi

# Check if HOURS is a number
if ! [[ $HOURS =~ $INTEGERS_RE ]] ; then
    echo "ERROR: entered invalid number for -t, --hours"
    exit 1
fi

# Get specified city current full forecast
RESPONSE=$(curl -s $URL)

# If debug flag is set, save response content to file
if [[ $DEBUG == true ]]; then
    echo $RESPONSE | jq > debug_out.json
fi

# Check if forecast for specified location was found
if [[ $RESPONSE == '{"error":{"code":404,"message":"Not Found"}}' ]]; then
    echo "ERROR: forecast for $LOCATION not found."
    exit 1
fi

# Parse curl response for forecast update time. Remove double quotes with sed
UPDATE_TIME=$(echo $RESPONSE | jq '.forecastCreationTimeUtc' | sed -e 's/^"//' -e 's/"$//')
# Convert date from UTC to local timezone and change date format
FORMATED_UPDATE_TIME=$(date --date="UTC $UPDATE_TIME" +"%Y-%m-%d %H:%M")
# Parse curl response for specified amount of hours of forecasts.
FULL_FORECAST=$(echo $RESPONSE | jq ".forecastTimestamps[:$HOURS]")


# Return forecast creation date if requested
if [[ $FORECAST_T == true ]]; then
    echo $FORMATED_UPDATE_TIME
    exit 0
fi

# Get information from parsed forecast about timestamp, temperature and weather condition for specified amount of hours
for i in `seq 0 $((--HOURS))`; do
    # Remove double quotes from date, change date format to just HH:MM and convert to local timezone from UTC
    timestamp=$(date --date="UTC $(echo $FULL_FORECAST | jq ".[$i].forecastTimeUtc" | sed -e 's/^"//' -e 's/"$//')" +"%H:%M")
    # If no more timestamps exist, throw an error
    retVal=$?
        if [ $retVal -ne 0 ]; then
        echo "ERROR: no more data"
        exit $retVal
    fi
    # Get temperature value in deg C
    temperature=$(echo $FULL_FORECAST | jq ".[$i].airTemperature")
    # Get weather condition and remove double quotes
    condition=$(echo $FULL_FORECAST | jq ".[$i].conditionCode" | sed -e 's/^"//' -e 's/"$//')
    # Return forecast for this timestamp
    echo -e "$timestamp\t$temperature$DEG\t$condition"
done
