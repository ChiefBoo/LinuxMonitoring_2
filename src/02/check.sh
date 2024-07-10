#!/bin/bash

reg_num='^[0-9]+$'
reg_folder='^[a-zA-Z]{1,7}$'
reg_file='^[a-zA-Z]{1,7}[.][a-z]{1,3}$'
reg_size='^[0-9]*Mb$'

function verification {
	if ! [[ $1 =~ $reg_folder ]]
	then
		echo "INVALID VALUE: param. 1, english alphabet letters should be used in folder names (no more than 7 characters)"
		exit 1;
	fi
	if ! [[ $2 =~ $reg_file ]]
	then
		echo "INVALID INPUT: param. 2, english alphabet letters should be used in file names (no more than 7 characters for the name, no more than 3 characters for the extension). Example: az.az"
		exit 1;
	fi
	if ! [[ $3 =~ $reg_size ]] || [[ ${3%??} -eq 0 ]] || [[ ${3%??} -gt 100 ]]
	then
		echo "INVALID INPUT: param. 3, incorrect file size (in Mbytes, but not more than 100)"
		exit 1
	fi
}

function memory_check {
	free_space=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
	if [[ $(( $free_space - $1 )) -le 0 ]] || [[ $free_space -le 1024 ]]
	then
		echo "After adding the file available memory will be less than 1 GB"
		END=$(date +"%Y-%m-%d %H:%M:%S")
		TIME=$(( $( date +%s -d "$END" ) - $( date +%s -d "$2" ) ))
		LOG=$( 
			echo -e "start time: $2"; 
			echo -e "finish time: $END";
			echo -e "total time: $TIME" )
		echo "$LOG"
		echo "$LOG" >> file.log
		exit 1
	fi
}
