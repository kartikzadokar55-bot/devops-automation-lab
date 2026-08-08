# Automated Backup & Retention System

A Bash-based backup automation tool that creates compressed backups of Linux directories, verifies backup integrity, maintains backup retention, logs operations, and can be scheduled automatically using Cron.

This project was built to practice practical Linux and Bash automation concepts used in DevOps environments.

---

## 📌 Project Overview

Managing backups manually can be repetitive and error-prone.

This project automates the complete backup workflow:

```text
Source Directory
       ↓
Input Validation
       ↓
Create Compressed Backup
       ↓
Calculate Backup Size
       ↓
Verify Backup Integrity
       ↓
Apply Retention Policy
       ↓
Delete Older Backups
       ↓
Write Logs
       ↓
Generate Summary

## 🚀 Features

Validate source directory before starting
Automatically create required directories
Generate timestamped backup filenames
Create .tar.gz compressed backups
Calculate backup size
Verify backup integrity using tar
Maintain source-specific backup retention
Keep the latest 5 backups
Automatically delete older backups
Maintain detailed operation logs
Track deleted backups
Handle command failures
Generate a final backup summary
Support automated execution through Cron

##🛠️ Technologies Used
Bash
Linux
GNU/Linux command-line utilities
tar
awk
du
grep
ls
tail
rm
Cron

## 📂 Project Structure
project-04-backup-automation/
│
├── backup.sh
├── README.md
├── .gitignore
│
├── backups/
│   └── .gitkeep
│
├── logs/
│   └── .gitkeep
│
└── test_data/
    └── sample files

Generated backup archives and logs are excluded from Git using .gitignore.

## ⚙️ How It Works
1. Input Validation

The script accepts the source directory as a command-line argument.

./backup.sh <directory>

Example:

./backup.sh test_data

The script checks whether:

A directory argument was provided
The specified directory exists
2. Backup Creation

The script creates a compressed .tar.gz archive using:

tar -czf

Backup filenames contain the source directory name and timestamp.

Example:

test_data_2026-08-08_09-04-18.tar.gz
3. Backup Verification

After creating the archive, the script verifies that it can be successfully read:

tar -tzf "$BACKUP_FILE"

This helps ensure that the generated archive is usable.

4. Backup Retention

The script implements a retention policy.

The latest 5 backups for the current source directory are retained.

Older backups are automatically removed.

Example:

Backup 1  → KEEP
Backup 2  → KEEP
Backup 3  → KEEP
Backup 4  → KEEP
Backup 5  → KEEP
Backup 6  → DELETE
Backup 7  → DELETE
5. Logging

Backup operations are recorded in:

logs/backup.log

Example:

2026-08-08 09:04:18 [INFO] Backup Started for 'test_data'
2026-08-08 09:04:18 [INFO] Backup created successfully
2026-08-08 09:04:18 [INFO] Backup verification successful

Cron output is separately redirected to:

logs/cron_backup.log

## ⏰ Cron Automation

The backup script can be scheduled using Linux Cron.

Example:

0 23 * * * /usr/bin/bash /path/to/backup.sh /path/to/test_data >> /path/to/logs/cron_backup.log 2>&1

The above schedule runs the backup:

Every day at 11:00 PM.

Check existing Cron jobs:

crontab -l

Edit Cron jobs:

crontab -e
▶️ Running the Script Manually

Make the script executable:

chmod +x backup.sh

Run:

./backup.sh test_data

Or:

/usr/bin/bash backup.sh test_data

## 📊 Example Output

===================================
BACKUP AUTOMATION SCRIPT
===================================

Creating backup...

Backup Size : 4.0K

Verifying backup...
✓ Backup verification successful.

Checking old backups...

Old backup found : 'backups/test_data_2026-08-08_06-14-45.tar.gz'
✓ Deleted successfully

===================================
BACKUP SUMMARY
===================================

Source Directory : 'test_data/'
Backup File      : 'backups/test_data_2026-08-08_09-04-18.tar.gz'
Backup Size      : 4.0K
Verification     : SUCCESS
Old Backups      : 1 removed
Log File         : 'logs/backup.log'

===================================

## 🔐 Error Handling

The script handles common failures including:

Missing source directory
Invalid directory path
Backup creation failure
Backup verification failure
Backup deletion failure

Errors are recorded in the log file for troubleshooting.

## 🧠 Bash Concepts Practiced

This project helped practice:

Variables
Command-line arguments
Functions
Local variables
if/else
while loops
IFS
Process substitution
Command substitution
Exit codes
Pipelines
Input/output redirection
stdout and stderr
Logging
File manipulation
Error handling
Timestamp generation
Cron scheduling

## 📚 DevOps Concepts Practiced

This project demonstrates practical concepts such as:

Linux automation
Backup automation
Data retention
Scheduled jobs
Operational logging
Failure handling
Verification
Automation workflows
Bash scripting for DevOps

## 🔮 Future Improvements

Possible improvements for future versions:

Add configurable retention count
Add email/Slack notifications
Add backup compression options
Add remote backup support
Upload backups to Azure Blob Storage or AWS S3
Add backup encryption
Add disk-space checks
Add configuration file support
Integrate Python for advanced reporting and automation
👨‍💻 Learning Objective

The primary objective of this project is to develop practical Bash scripting and Linux automation skills by building a reusable backup solution similar to tasks commonly encountered in DevOps and system administration environments.

## 📌 Project Status

Completed ✅
