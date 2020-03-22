#!/bin/bash

#Gets COVID-19 statistics from https://corona-stats.online

# Temp file locations
FULL_TABLE="/tmp/corona.tmp"
COUNTRY_TABLE="/tmp/coronacountry.tmp"

if [ -z $1 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
	echo -e "Script gets COVID-19 statistics from https://corona-stats.online and formats result for further usage.\n\nUsage: corona.sh <Country> <Field>\nNot giving <Field> value returns all Country statistics in one line.\nEntering partial Country name returns all matching results.\n\n\tField values:\n\t\t1 - Rank\n\t\t2 - Country\n\t\t3 - Total Cases\n\t\t4 - New Cases\n\t\t5 - Total Deaths\n\t\t6 - New Deaths\n\t\t7 - Recovered\n\t\t8 - Active\n\t\t9 - Critical\n\t\t10 - Cases / 1M pop\n\nExample: corona.sh Lithuania 3\nShould give total cases of COVID-19 in Lithuania"
else
	#Check if current table is older than 1h and update if necessary
	if ! { [[ -f $FULL_TABLE ]] && (( ($(date +%s) - $(stat -c %Y $FULL_TABLE)) < 3600 )); }
	then
		#Get full COVID-19 statistics table, remove color formating, first 2 lines of info, 10 last lines of info
		curl -s https://corona-stats.online?source=2 | sed "s/\x1b\[[0-9;]*m//g" | head -n -10 | sed '1,2d' > $FULL_TABLE
	fi
	#Filter table by Country and remove unnecessary characters
	grep $1 $FULL_TABLE | sed "s/\s*//g ; s/║//g ; s/│/;/g" > $COUNTRY_TABLE
	if [ -z $2 ]
	then
		echo -e "Rank\tWorld\t\tTotal\tNew▲\tDeaths\t▲\tRec.\tActive\tCrit.\tCases/1Mpop"
		cat $COUNTRY_TABLE | sed 's/;/-\t/g'
	else 
		#Check if second parameter is valid number
		re='^[0-9]+$'
		if ! [[ $2 =~ $re ]] 
		then
   			echo "Error: $2 is not a number. Check --help." >&2
   			exit 1
		else 
			if (( $2 > 0 )) && (( $2 < 11 ))
			then
    			cat $COUNTRY_TABLE | awk -F';' '{print $col}' col=$2
    		else
    			echo "Error: $2 is not a valid number. Check --help." >&2
    			exit 1
			fi
		fi
	fi
	#rm -f $COUNTRY_TABLE
fi