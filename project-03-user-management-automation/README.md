# Linux User Management Automation

A production-style Bash automation project that reads user details from a CSV file and automates Linux user and group management.

This project demonstrates practical Linux administration, Bash scripting, logging, reporting, and automation concepts commonly used by System Administrators and DevOps Engineers.

---

## Features

- Read users from a CSV file
- Validate command-line input
- Validate CSV file existence
- Skip CSV header automatically
- Create Linux groups if they do not exist
- Create Linux users
- Assign users to their primary groups
- Generate secure random passwords
- Set temporary passwords automatically
- Force password change on first login
- Maintain detailed execution logs
- Generate success and failure reports
- Generate password report
- Display execution summary

---

## Technologies Used

- Bash
- Linux
- OpenSSL
- useradd
- groupadd
- chpasswd
- passwd
- grep
- tail
- Process Substitution
- CSV Processing

---

## Project Structure

```
linux-user-management-automation/
│
├── user_manager.sh
├── users.csv
├── README.md
│
├── logs/
│   └── user_creation.log
│
├── reports/
│   ├── success_users.csv
│   └── failed_users.csv
│
└── passwords/
    └── generated_passwords.csv
```

---

## CSV Format

Example:

```csv
username,fullname,group
rahul,Rahul Sharma,developers
priya,Priya Singh,testers
amit,Amit Kumar,developers
```

---

## How to Run

Make the script executable:

```bash
chmod +x user_manager.sh
```

Run the script:

```bash
./user_manager.sh users.csv
```

---

## Workflow

```
Read CSV
      │
      ▼
Validate Input
      │
      ▼
Check Group
      │
      ▼
Create Group
      │
      ▼
Check User
      │
      ▼
Create User
      │
      ▼
Generate Password
      │
      ▼
Assign Password
      │
      ▼
Force Password Reset
      │
      ▼
Write Reports
      │
      ▼
Generate Summary
```

---

## Output Files

### Logs

```
logs/user_creation.log
```

Contains timestamped execution logs.

Example:

```
2026-08-06 09:15:12 [INFO] Group 'developers' created successfully.
2026-08-06 09:15:13 [INFO] User 'rahul' created successfully.
```

---

### Password Report

```
passwords/generated_passwords.csv
```

Example:

```csv
Username,Password
rahul,S4r0GY+fycxxL3xo
priya,Q95ivUqEj6XsVH1M
```

---

### Success Report

```
reports/success_users.csv
```

Example:

```csv
Username
rahul
priya
```

---

### Failure Report

```
reports/failed_users.csv
```

Example:

```csv
Username
john
```

---

## Summary

After execution the script displays:

```
====================================
USER CREATION SUMMARY
====================================

Users Processed : 9
Users Created   : 9
Already Exists  : 0
Users Failed    : 0

Groups Created  : 2

Log File : logs/user_creation.log
====================================
```

---

## Bash Concepts Demonstrated

- Variables
- Functions
- Global Variables
- Local Variables
- Command-line Arguments
- Input Validation
- CSV Processing
- IFS
- while read
- Process Substitution
- Exit Status
- Error Handling
- Logging
- File Redirection
- Bash Arithmetic
- Modular Script Design

---

## Future Improvements

- Dry Run Mode (`--dry-run`)
- Delete Users Mode
- Email Notification
- Configuration File Support
- Parallel User Creation
- Password Complexity Options

---

## Author

**Kartik Zadokar**

DevOps | Linux | Bash | Azure | Python

Building production-style DevOps automation projects.
