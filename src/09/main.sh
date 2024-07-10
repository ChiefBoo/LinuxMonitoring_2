#!/bin/bash

while true
do
    # Get system metrics
    CPU=$(top -bn 2 -d 0.5 | grep '^%Cpu' | tail -n 1 | awk '{print 100-$8}')
    RAM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    HDD=$(df --output=pcent / | tail -n 1 | cut -d'%' -f1)

    # Output metrics in Prometheus format
    cat <<EOF > /usr/share/nginx/html/metrics.html
# HELP cpu_usage_ratio CPU Usage Ratio
# TYPE cpu_usage_ratio gauge
cpu_usage_ratio $CPU
# HELP ram_usage_ratio RAM Usage Ratio
# TYPE ram_usage_ratio gauge
ram_usage_ratio $RAM
# HELP hdd_usage_ratio HDD Usage Ratio
# TYPE hdd_usage_ratio gauge
hdd_usage_ratio $HDD
EOF

    sleep 3
done
