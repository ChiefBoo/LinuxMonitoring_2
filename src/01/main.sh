#!/bin/bash

chmod +x check.sh
chmod +x generate.sh

. ./check.sh
. ./generate.sh


if [ $# -ne 6 ]
then
	echo "INVALID INPUT: incorrect number of parameters (Only 6)"
else
	verification $1 $2 $3 $4 $5 $6
	generation $1 $2 $3 $4 $5 $6
fi
