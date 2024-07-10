#!/bin/bash



function check_datetime() {
	re_datetime='^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$'
	while true
	do
		read -p "Enter the $1 times up to the minute (YYYY-MM-DD HH:MM): " datetime
		if ! [[ "$datetime" =~ $re_datetime ]]
		then
			echo "Incorrect date and time format. Try again."
		else
			echo $datetime
			break
		fi		       
	done
}

function clean_log {
	log=$(cat ../02/file.log | awk '{print $4}')
	for i in $log
	do
		if [[ ${i: 0:1} == "/" ]] && [[ -e $i ]]; then
			#echo $i
			rm -rf $i &> /dev/null
		fi
	done
	rm -rf ../02/file.log
	echo "Deletion complete."
}

function clean_datetime {
	date=$(date +%d%m%y)
	list_dir=$(find / -not -wholename "*/bin*" -not -wholename "*/sbin*" -newerct "$1" ! -newerct "$2" -name "*$date*" | grep -Ev "/var|/run|/snap|/proc|/sys|/bin|/sbin|/DO4_LinuxMonitoring_v2.0-1" 2>/dev/null)
	for i in $list_dir
	do
		if [[ -e $i ]]; then
			rm -rf "$i" &> /dev/null
			echo "deleted: $i"
		fi
	done
	echo "Deletion complete."
}

function check_mask {
	re_mask='^[a-zA-Z]{1,}_[0-9]{6}$'
	while true
	do
		read -p "Enter mask name for delete (name_DDMMYY):" mask
		if ! [[ "$mask" =~ $re_mask ]]
		then
			echo "Incorrect mask. Try again."
		else
			echo $mask
			break
		fi
	done
}

function clean_mask {
	date_m=$( echo $1 | cut -d "_" -f2 )
	na=$( echo $1 | cut -d "_" -f1 )
	mask_tmp="*"
	for((i=0;$i<${#na};i++))
	do	
		mask_tmp+="${na:$i:1}*"
	done
	finish_mask=$mask_tmp"_"$date_m"*"
	list_file=$(find / -not -wholename "*/bin*" -not -wholename "*/sbin*" -name $finish_mask | grep -Ev "/var|/run|/snap|/proc|/sys|/bin|/sbin|/DO4_LinuxMonitoring_v2.0-1" 2>/dev/null)
	for i in $list_file
	do
		if [[ -e $i ]]; then
			rm -rf "$i" &> /dev/null
			echo "deleted: $i"
		fi
	done
	echo "Deletion complete."

}

function clean_trash {
	case $1 in
		1)
			if [[ -f ../02/file.log ]]
			then
				clean_log
			else	
				echo "File \"file.log\" not found"
			fi	
			;;
		2)	
			check_datetime "start"
			start_time=$datetime
			check_datetime "end"
			end_time=$datetime
			clean_datetime "$start_time" "$end_time"
			;;
		3)	
			check_mask
			mask_name=$mask
			clean_mask $mask_name			
			;;
		esac
}
