#!/bin/bash



# Get disk usage  percentage

usage=$(df -h / | awk 'NR==2{print $5}')

# Removing the % symbol
usage_without_percentage=${usage%\%}


# Checking disk threshold

if [ "$usage_without_percentage" -ge 80  ]; then
	echo "⚠ WARNING: Disk usage is above 80%"
else
	echo "✅ Disk usage is healthy"
fi
