#!/bin/bash

function generate_ip {
	ip=""
	while [ -z "$ip" ]; do
		ip=$(printf "%d.%d.%d.%d" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
	done
	echo "$ip"
}

function get_time {
	echo `date -d "$((RANDOM%23)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%H:%M:%S'`
}


response_codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
methods=("GET" "POST" "PUT" "PATCH" "DELETE")

function create_log {
	mkdir logs
	for i in {0..4}; do
		log_file="logs/access_$(($i + 1)).log"
		num_records=$((RANDOM%901+100))
		echo "Generate $num_records records for $log_file.."
		for ((j=0; j <$num_records; j++)); do
			ip=$(generate_ip)
			code=${response_codes[$((RANDOM%${#response_codes[@]}))]}
			method=${methods[$((RANDOM%${#methods[@]}))]}
			date=[$(expr $(date +%_d) - $i)/$(date | awk '{print $3"/"$4}'):$(get_time)" "$(date +%z)]
			#date=$(date +'%d/%b/%Y:%H:%M:%S %z' -d "$(date +'%Y-%m-%d') +$i seconds")
			url="http://example.com/page$((RANDOM%1000+1)).html"
			agent=$(shuf -n1 agents.txt)
			echo "$ip - - $date \"$method $url HTTP/1.1\" $code $((RANDOM%1000)) \"-\" \"$agent\" \"-\"" >> $log_file
		done
		sort -k4 -o "$log_file" "$log_file"
	done
}
