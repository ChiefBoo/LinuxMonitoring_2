#!/bin/bash

chmod +x generate.sh

. ./generate.sh

if [ $# -ne 0 ]; then
	echo "ERROR: Must be entered without parameters."
else
	create_log
fi
