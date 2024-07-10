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
	let "RANGE = 251 / ${#sym_for_name} + 1"
	for ((i=0;i<${#sym_for_name}-1;i++))
	do
		num1=$( random_number 0 $RANGE )
		for ((j=0;j<$num1; j++))
		do
			name=$name${sym_for_name:i:1}
		done
	done
	num2=$( random_number 3 $RANGE )	
	for ((k=0;k<$num2;k++))
	do
		name=$name${sym_for_name:${#sym_for_name}-1:1}
	done
	echo $name
}

function generation {
	name_folder=$(generate_name $3)
	number_of_folders=0
	file_ext=$5
	size=$(echo $6 | awk -F"kb" '{print $1}')
	while [ "$number_of_folders" -ne $2 ]
	do
		name_folder=$(generate_name $3)_$date
		if [ ! -d "$1/$name_folder" ] 
		then 
			mkdir $1/$name_folder
			echo "$(date +%Y-%m-%d:%H%M:%S) created folder $1/$name_folder" >> file.log
			number_of_folders=$(( $number_of_folders + 1 ))
			memory_check 0
			number_of_files=0
			while [ "$number_of_files" -ne $4 ]
			do
				name_file=$(generate_name ${file_ext%%.*})_$date.${file_ext#*.}
				if [ ! -f "$1/$name_folder/$name_file" ]
				then
					memory_check $size
					number_of_files=$(( $number_of_files + 1 ))	
					fallocate -l "$size"K "$1/$name_folder/$name_file" > /dev/null 2>&1
					echo "$(date +%Y-%m-%d:%H:%M:%S) created file $1/$name_folder/$name_file  ${size}KB" >> file.log
				fi
					
			done
		fi
	done	
}
