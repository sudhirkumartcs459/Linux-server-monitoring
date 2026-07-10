#!/bin/bash

HOSTNAME=$(hostname)
DATET=$(date "+%Y-%m-%d %H:%M:%S")
CPUUSAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
MEMUSAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')
DISKUSAGE=$(df -h / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ ! -f /opt/usagereport ]; then
    printf "%-25s %-20s %-10s %-10s %-10s\n" \
    "Hostname" "Date&Time" "CPU(%)" "Mem(%)" "Disk(%)" > /opt/usagereport
fi

printf "%-25s %-20s %-10s %-10s %-10s\n" \
"$HOSTNAME" "$DATET" "$CPUUSAGE" "$MEMUSAGE" "$DISKUSAGE" >> /opt/usagereport
