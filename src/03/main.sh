#!/bin/bash

chmod +x clean.sh

re='^[1-3]$'

source ./clean.sh

if [[ $# -ne 1 ]] || ! [[ $1 =~ $re ]]
then
	echo "INVALID INPUT: Enter one parameter from 1 to 3"
	echo "1. By log file"
	echo "2. By creation date and time"
	echo "3. By name mask (i.e. characters, underlining and date)"
else
	clean_trash $1
fi
