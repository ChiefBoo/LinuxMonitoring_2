#!/bin/bash

chmod +x monitoring.sh

. ./monitoring.sh

# 1. All entries sorted by response code
# 2. All unique IPs found in the entries
# 3. All requests with errors (response code - 4xx or 5xx)
# 4. All unique IPs found among the erroneus requests

if [ $# -ne 1 ]; then
	echo "INVALID INPUT: One prameter is required."
	exit 1
fi

if ! [ -d "../04/logs" ]; then
	echo " No logs. Run ../04/main.sh"
	exit 1
fi

case $1 in
	1) sort_by_code ;;
	2) unique_ips ;;
	3) error_requests ;;
	4) unique_error_ips ;;
	*) echo "Invalid parameter. Please enter 1, 2, 3, or 4." ;;
esac


