#!/bin/bash

#Gets COVID-19 statistics from https://corona-stats.online
#
# By Martynas J. 2020

# Temp file locations
FULL_TABLE="/tmp/corona.tmp"
COUNTRY_TABLE="/tmp/coronacountry.tmp"

if [ -z $1 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
	echo -e "Script gets COVID-19 statistics from https://corona-stats.online and formats result for further usage.\n\nUsage: corona.sh <Country> <Field>\nNot giving <Field> value returns all Country statistics in one line.\nEntering partial Country name returns all matching results.\n\nField values:\n\t1 - Rank\n\t2 - Country\n\t3 - Total Cases\n\t4 - New Cases\n\t5 - Total Deaths\n\t6 - New Deaths\n\t7 - Recovered\n\t8 - Active\n\t9 - Critical\n\t10 - Cases / 1M pop\n\nExample: corona.sh Lithuania 3 4\nShould give total cases and new cases of COVID-19 in Lithuania"
else
	#Check if current table is older than 1h and update if necessary
	if ! { [[ -f $FULL_TABLE ]] && (( ($(date +%s) - $(stat -c %Y $FULL_TABLE)) < 3600 )); }
	then
		#Get full COVID-19 statistics table, remove color formating, first 2 lines of info, 10 last lines of info
		curl -s https://corona-stats.online?source=2 | sed "s/\x1b\[[0-9;]*m//g" | head -n -10 | sed '1,2d' > $FULL_TABLE
	fi
	#Check if FULL_TABLE is not empty
	if ! [ -s $FULL_TABLE ]
	then
		echo "Error: can't download data. Check internet connection"
		rm -f $FULL_TABLE
		exit 1
	fi
	#Filter table by Country and remove unnecessary characters
	grep $1 $FULL_TABLE | sed "s/\s*//g ; s/║//g ; s/│/;/g" > $COUNTRY_TABLE
	# If only country name or part of country name is given, return all matching results with all statistics
	if [ -z $2 ]
	then
		echo -e "Rank|\tWorld|\t\tTotal|\tNew▲|\tDeaths|\t▲|\tRec|\tActive|\tCrit|\tCases/1Mpop"
		cat $COUNTRY_TABLE | sed 's/;/|\t/g'
	else
		re='^[0-9]+$'
		# for every given argument output specific statistic
		for i in ${@:2}
		do
			#Check if parameter is valid number
			if ! [[ $i =~ $re ]] 
			then
   				echo "Error: $i is not a number. Check --help."
			else 
				if (( $i > 0 )) && (( $i < 11 ))
				then
    				cat $COUNTRY_TABLE | awk -F';' '{print $col}' col=$i
    			else
    				echo "Error: $i is not a valid number. Check --help."
				fi
			fi
		done
	fi
	rm -f $COUNTRY_TABLE
fi