#!/bin/bash

reg_num='^[0-9]+$'
reg_folder='^[a-zA-Z]{1,7}$'
reg_file='^[a-zA-Z]{1,7}[.][a-z]{1,3}$'
reg_size='^[0-9]*kb$'

function verification {
	if ! [[ -d $1 ]]
	then
		echo "INVALID INPUT: param. 1, incorrect path"
		exit 1
	fi
	if ! [[ $2 =~ $reg_num ]] || [[ $2 -eq 0 ]]
	then
		echo "INVALID INPUT: param. 2, there must be a number not equal to 0"
		exit 1
	fi
	if ! [[ $3 =~ $reg_folder ]]
	then
		echo "INVALID VALUE: param. 3, english alphabet letters should be used in folder names (no more than 7 characters)"
		exit 1;
	fi
	if ! [[ $4 =~ $reg_num ]] || [[ $4 -eq 0 ]]
	then
		echo "INVALID INPUT: param. 4, there must be a number not equal to 0"
		exit 1
	fi
	if ! [[ $5 =~ $reg_file ]]
	then
		echo "INVALID INPUT: param. 5, english alphabet letters should be used in file names (no more than 7 characters for the name, no more than 3 characters for the extension). Example: az.az"
		exit 1;
	fi
	if ! [[ $6 =~ $reg_size ]] || [[ ${6%??} -eq 0 ]] || [[ ${6%??} -gt 100 ]]
	then
		echo "INVALID INPUT: param. 6, incorrect file size (in kilobytes, but not more than 100)"
		exit 1
	fi
}

function memory_check {
	free_space=$(df --output=avail / | tail -1 )
	if [[ $(( $free_space - $1 )) -le 0 ]] || [[ $free_space -le 1048576 ]]
	then
		echo "MEMORY ERROR: There is not enough free disk space"
		exit 1
	fi
}
