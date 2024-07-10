#!/bin/bash

date=$(date +%d%m%y)

function random_number {
number=0
while [ "$number" -le $1 ]
do
	number=$RANDOM
	let "number %= $2"
done
echo $number
}

function generate_name {
	name=""
	sym_for_name=$1	
	let "RANGE = 250 / ${#sym_for_name} + 1"
	for ((i=0;i<${#sym_for_name}-1;i++))
	do
		num1=$( random_number 0 $RANGE )
		for ((j=0;j<$num1; j++))
		do
			name=$name${sym_for_name:i:1}
		done
	done
	num2=$( random_number 4 $RANGE )	
	for ((k=0;k<$num2;k++))
	do
		name=$name${sym_for_name:${#sym_for_name}-1:1}
	done
	echo $name
}



function generation {
	number_of_folders=$(( $RANDOM % 10 + 1 ))
	count_folders=0
	file_ext=$2
	size=$(echo $3 | awk -F"Mb" '{print $1}')
	while [ "$count_folders" -ne "$number_of_folders" ]
	do
		name_folder=$(generate_name $1)_$date
		if [ ! -d "$4/$name_folder" ] 
		then 
			mkdir $4/$name_folder > /dev/null 2>&1
			if [ -d "$4/$name_folder" ]
			then
				echo "$(date +%Y-%m-%d:%H%M:%S) created folder $4/$name_folder" >> file.log
				count_folders=$(( $count_folders + 1 ))
				memory_check 0 "$5"
				number_of_files=$(( $RANDOM % 30 + 1 ))
				count_files=0
				while [ "$count_files" -ne "$number_of_files" ]
				do
					name_file=$(generate_name ${file_ext%%.*})_$date.${file_ext#*.}
					if [ ! -f "$4/$name_folder/$name_file" ]
					then
						memory_check $size "$5"
						count_files=$(( $count_files + 1 ))	
						fallocate -l "$size"M "$4/$name_folder/$name_file" > /dev/null 2>&1
						if [ -f "$4/$name_folder/$name_file" ]
						then
							echo "$(date +%Y-%m-%d:%H:%M:%S) created file $4/$name_folder/$name_file  ${size}MB" >> file.log
						fi
					fi
				done
			fi
		fi
	done	
}



function create_trash {
	while true 
	do
		while
			path=$(find / -type d -not -wholename "*/bin*" -not -wholename "*/sbin*" -perm /u+rw | grep -Ev "/var|/run|/snap|/proc|/sys|/bin|/sbin|/DO4_LinuxMonitoring_v2.0-1" | shuf -n1)
			[[ $(find $path -maxdepth 0 -type d -print | wc -l) -ge 100 ]]
		do true; done
		generation $1 $2 $3 $path "$4"		
	done
	
}
