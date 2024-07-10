#!/bin/bash

if ! [ -d "../04/logs" ]; then
	echo "No logs. Run ../04/main.sh"
	exit 1
fi

if [[ $# -ne 1 ]]; then
	echo "INVALID INPUT: One parameter is required."
	exit 1
fi

if ! [[ $1 =~ ^[1-4] ]]; then
	echo "Invalid parameter. Please enter 1, 2, 3 or 4." 
    	exit 1;	
fi

if ! [[ -n $(dpkg -l | grep goaccess) ]];
then
	echo "Install goaccess.."
	echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
	wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/goaccess.gpg add -
	sudo apt update
	sudo apt install -y goaccess
fi


case $1 in
	1) conditions="--sort-panel=STATUS_CODES,BY_DATA,ASC";;
	2) conditions="--sort-panel=VISITORS,BY_VISITORS,ASC";;
	3) conditions="--ignore-status=200 --ignore-status=201 --sort-panel=REQUESTS,BY_DATA,ASC";;
	4) conditions="--ignore-status=200 --ignore-status=201 --sort-panel=VISITORS,BY_VISITORS,ASC";;
esac

rm -rf report.html
goaccess ../04/logs/* --log-format=COMBINED -o report.html "$conditions" --date-format=%d/%b/%Y --time-format=%T
