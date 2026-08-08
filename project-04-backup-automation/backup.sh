#!/bin/bash

SOURCE_DIR="$1"
BACKUP_DIR="backups"
LOG_FILE="logs/backup.log"

DIR_NAME=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="${DIR_NAME}_${TIMESTAMP}.tar.gz"

BACKUP_FILE="$BACKUP_DIR/$BACKUP_NAME"

BACKUP_SIZE=""

VERIFICATION_STATUS="SUCCESS"

BACKUPS_DELETED=0

# Validating input

validate_input() {

	if [ -z "$SOURCE_DIR" ]; then
		echo "Usage: $0 <directory>"
		exit 1
	fi

	if [ ! -d "$SOURCE_DIR" ]; then
		echo "Error : Directory '$SOURCE_DIR' does not exist."
		exit 1
	fi

}

# Header function

print_header() {

	echo "==================================="
	echo "BACKUP AUTOMATION SCRIPT"
	echo "==================================="
	echo

}

setup_environment() {

	mkdir -p "$BACKUP_DIR" logs

}

# Log function

log_message() {

	local LEVEL="$1"
	local MESSAGE="$2"
	TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

	echo "$TIMESTAMP [$LEVEL] $MESSAGE" >> "$LOG_FILE"


}


verify_backup() {

        echo
        echo "Verifiying backup..."


        if tar -tzf "$BACKUP_FILE" >/dev/null 2>&1; then

                echo "✓ Backup verification successful."
                log_message INFO "Backup verification successful : '$BACKUP_FILE'"
        else

                echo "✗ Backup verification failed."
                log_message ERROR "Backup verification failed : '$BACKUP_FILE'"
		VERIFICATION_STATUS="FAILED"
                exit 1
        fi
}


create_backup() {

	echo "Creating backup..."
	echo

	log_message INFO "Backup Started for '$SOURCE_DIR'"

	if tar -czf "$BACKUP_FILE" "$SOURCE_DIR"; then

		log_message INFO "Backup created successfully: $BACKUP_FILE"

		BACKUP_SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')

		echo "Backup Size : $BACKUP_SIZE"

		log_message INFO "Backup Size : $BACKUP_SIZE"

	else
		log_message ERROR "Backup failed for '$SOURCE_DIR'"

		echo "Backup Failed."

		exit 1

	fi

}


cleanup_old_backups() {

	echo
	echo "Checking old backups..."
	echo

	local OLD_BACKUPS
	OLD_BACKUPS=$(ls -1t "$BACKUP_DIR"/"$DIR_NAME"_*.tar.gz 2>/dev/null | tail -n +6)

	if [ -z "$OLD_BACKUPS" ]; then
		echo "No old backups to remove."

	else

		while IFS= read -r backup; do
			echo "Old backup found : '$backup'"

			if rm "$backup"; then
				echo "✓ Deleted successfully : '$backup'"
				log_message INFO "Old backup deleted : '$backup'"
				((BACKUPS_DELETED++))
				echo
			else
				echo "File deletion failed : $backup"
				echo
				log_message ERROR "File deletion Failed : '$backup'"
			fi
		done <<< "$OLD_BACKUPS"

	fi

}

print_summary() {

	echo
	echo "==================================="
	echo "BACKUP SUMMARY"
	echo "==================================="
	echo

	echo "Source Directory : '$SOURCE_DIR'"
	echo

	echo "Backup file : '$BACKUP_FILE'"
	echo

	echo "Backup Size : $BACKUP_SIZE"
	echo

	echo "Verification : $VERIFICATION_STATUS"
	echo

	echo "Old Backups :  $BACKUPS_DELETED removed."

	echo

	echo "Log file : '$LOG_FILE'"

	echo "==================================="

}


print_header
validate_input
setup_environment
create_backup
verify_backup
cleanup_old_backups
print_summary
