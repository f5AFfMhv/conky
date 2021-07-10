#!/bin/bash
# Starts up conky instances in quiet mode
#
# By Martynas J. 2021

sleep 3
/usr/bin/conky -q -c ~/.config/conky/sysinfo_conkyrc
/usr/bin/conky -q -c ~/.config/conky/kernlog_conkyrc
/usr/bin/conky -q -c ~/.config/conky/covid_conkyrc
#/usr/bin/conky -q -c ~/.config/conky/gkeep_conkyrc
/usr/bin/conky -q -c ~/.config/conky/aliases_conkyrc
