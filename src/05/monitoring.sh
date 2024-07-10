#!/bin/bash

log_files="../04/logs/*"

function sort_by_code {
	rm -rf sorted_by_code.log
	awk '{ print $0 }' $log_files | sort -k 8 >> sorted_by_code.log
}

function unique_ips {
	rm -rf unique_ips.log
	awk '{ print $1 }' $log_files | uniq | sort >> unique_ips.log
}

function error_requests {
	rm -rf error_requests.log
	awk '$9 ~ /^[45]/ {print}' $log_files >> error_requests.log
}

function unique_error_ips {
	rm -rf unique_error_ips.log
	awk '$9 ~ /^[45]/ {print $1}' $log_files | uniq | sort >> unique_error_ips.log
}
