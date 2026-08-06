#!/bin/bash

mkdir -p logs reports passwords

# Global Variables

TOTAL_USERS=0
USERS_CREATED=0
USERS_EXIST=0
USERS_FAILED=0
GROUPS_CREATED=0

PASSWORDS_FILE="passwords/generated_passwords.csv"
SUCCESS_FILE_REPORT="reports/success_users.csv"
FAILED_FILE_REPORT="reports/failed_users.csv"


echo "Username,Password" > "$PASSWORDS_FILE"
echo "Username" > "$SUCCESS_FILE_REPORT"
echo "Username" > "$FAILED_FILE_REPORT"

# Read CSV filename from the command-line argument

LOG_FILE="logs/user_creation.log"

FILE="$1"

validate_input() {

	if [ -z "$FILE"  ]; then
		echo "Please provide file for user ID creation"
		exit 1
	fi

	# check if the file exists

	if [ ! -f "$FILE" ]; then
		echo "ERROR : File "$FILE" does not exist "
		exit 1
	fi

}

validate_input

# header function

print_header() {

	echo "=================================="
	echo "User Creation Simulation"
	echo "=================================="
	echo

}

print_header

# log function

log_info() {

	local LEVEL="$1"
	local MESSAGE="$2"
	local TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

	echo "$TIMESTAMP [$LEVEL] $MESSAGE"  >> "$LOG_FILE"


}


# Group Function

create_group() {

	if grep "^${group}:" /etc/group >/dev/null 2>&1; then
                        log_info INFO "Group $group already exists"
                else
                        echo "Creating group : '$group'"
                        if sudo groupadd "$group"; then
                                log_info INFO "Group '$group' created successfully"
				((GROUPS_CREATED++))
                        else
                                log_info ERROR "Failed to create '$group'"
			fi
        fi
}

# User Function


create_user() {


        if id "$username" >/dev/null 2>&1; then

                log_info INFO "User '$username' already exists"
		((USERS_EXIST++))
        else

                if sudo useradd -c "$fullname" -g "$group" "$username"; then

			PASSWORD=$(openssl rand -base64 12)
			echo "$username:$PASSWORD" | sudo chpasswd

			sudo passwd -e "$username" >/dev/null 2>&1
			echo "$username:$PASSWORD" >>  "$PASSWORDS_FILE"

			log_info INFO "User '$username' created successfully"

			echo "$username" >> "$SUCCESS_FILE_REPORT"

			((USERS_CREATED++))
                else
                        log_info ERROR "❌ Failed to create '$username'."

			echo "$username" >> "$FAILED_FILE_REPORT"

			((USERS_FAILED++))
                fi
        fi


}


# Skip header row and process each user

while IFS=',' read -r username fullname group;
do
	((TOTAL_USERS++))
	create_group
	create_user

done < <(tail -n +2 "$FILE")


print_summary() {

	echo
	echo "===================================="
	echo "USER CREATION SUMMARY"
	echo "===================================="

	echo "Users Processed : $TOTAL_USERS"
	echo "Users Created : $USERS_CREATED"
	echo "Already Exists : $USERS_EXIST"
	echo "Users Failed : $USERS_FAILED"
	echo

	echo "Groups Created : $GROUPS_CREATED"
	echo

	echo "Log File : $LOG_FILE"
	echo "===================================="

}

print_summary
