#!/bin/bash

echo "================================="
echo "     SYSTEM HEALTH REPORT"
echo "================================="


DATE=$(date +"%d-%m-%Y")
TIME=$(date +"%H:%M:%S")
HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
CPU_IDLE=$(top -bn1 | grep "Cpu" | awk '{print $8}')
CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE"})



print_system_info() {

echo

echo -e "\n\nDate :  $DATE"

echo -e "Time :  $TIME"

echo -e "Hostname :  $HOSTNAME"

echo -e "Current User :  $CURRENT_USER"

}

print_cpu() {
    echo
    echo "-----------------------------"
    echo "CPU"
    echo "-----------------------------"
    echo "CPU Usage : ${CPU_USAGE}%"
}

print_memory() {

    TOTAL_MEMORY=$(free -h | grep  "Mem" | awk '{print $2}')
    USED_MEMORY=$(free -h | grep "Mem" | awk '{print $3}')
    FREE_MEMORY=$(free -h | grep "Mem" | awk '{print $4}')
    AVAILABLE_MEMORY=$(free -h | grep "Mem" | awk '{print $7}')
	echo
	echo "-----------------------------"
	echo "Memory"
	echo "-----------------------------"
	echo "Total Memory : $TOTAL_MEMORY"
	echo "Used Memory: $USED_MEMORY"
	echo "Free Memory  $FREE_MEMORY"
	echo "Available : $AVAILABLE_MEMORY" 


}

print_disk_usage() {

	FILESYSTEM=$(df -h | grep "/$" | awk '{print $6}')
	TOTAL=$(df -h | grep "/$" | awk '{print $2}')
	USED=$(df -h | grep "/$" | awk '{print $3}')
	AVAILABLE=$(df -h | grep "/$" | awk '{print $4}')
	USAGE=$(df -h | grep "/$" | awk '{print $5}')
	echo
	echo "-----------------------------"
	echo "Disk Usage"
	echo "-----------------------------"
	echo "Filesystem :  $FILESYSTEM"
	echo "Total : $TOTAL"
	echo "Used : $USED"
	echo "Availeble : $AVAILABLE"
	echo "USAGE : $USAGE"


}


print_system_info
print_cpu
print_memory
print_disk_usage
