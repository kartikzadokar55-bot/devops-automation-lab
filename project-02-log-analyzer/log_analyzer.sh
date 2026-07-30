#!/bin/bash

# Log file
LOG_FILE="$1"

if [ -z "$LOG_FILE" ]; then
	echo "Oooops! I think you forget to give filename"
	exit 1
fi


if [ ! -f "$LOG_FILE" ]; then
	echo "Error: file $LOG_FILE does not exist"
	exit 1
fi


# Calculating total lines

TOTAL_LINES=$(wc -l < "$LOG_FILE")


# Counting no of errors in the file

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE")
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")

# Calculate Date and Time
DATE=$(date +"%d-%m-%Y")
TIME=$(date +"%H:%M:%S")


print_header() {

	echo "==================================="

	echo "LOG ANALYZER"

	echo "==================================="
	echo

	echo "Date : $DATE"
	echo

	echo "Time : $TIME"

}

print_statistics() {
	echo
	echo "Total Lines : $TOTAL_LINES"
	echo
	echo "Error : $ERROR_COUNT"
	echo
	echo "Warning : $WARNING_COUNT"
	echo
	echo "Info : $INFO_COUNT"
}

print_last_errors() {

	echo
	echo "==================================="

	echo "Last 5 Errors"

	echo "==================================="
	echo

	if [ "$ERROR_COUNT" -eq 0 ]; then
		echo "No errors found"
	else
		grep "ERROR" "$LOG_FILE" | tail -5
	fi
}

print_top_errors() {

	echo
	echo "==================================="
	echo "Top 5 Frequent Errors"
	echo "==================================="
	echo

	if [ "$ERROR_COUNT" -eq 0  ]; then
		echo "No frequent errors found"
	else
		grep "ERROR" "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

	fi

}


print_header
print_statistics
print_last_errors
print_top_errors
