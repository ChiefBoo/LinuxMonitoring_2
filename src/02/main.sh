#!/bin/bash

chmod +x check.sh
chmod +x generate.sh

. ./check.sh
. ./generate.sh
START=$(date +"%Y-%m-%d %H:%M:%S")

if [ $# -ne 3 ]
then
	echo "INVALID INPUT: incorrect number of parameters (Only 3)"
else
	verification $1 $2 $3
	create_trash $1 $2 $3 "$START"
fi
