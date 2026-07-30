# Bash Log Analyzer

A command-line log analyzer written in Bash that processes application logs and generates useful statistics for troubleshooting.

## Features

- Accepts log file as a command-line argument
- Counts total log entries
- Counts ERROR, WARNING and INFO messages
- Displays the last 5 errors
- Displays the top 5 most frequent errors
- Validates user input
- Checks whether the log file exists
- Modular implementation using Bash functions

## Technologies

- Bash
- grep
- awk
- wc
- sort
- uniq
- head
- tail

## Usage

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh sample.log
