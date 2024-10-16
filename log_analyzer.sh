#!/bin/bash

# Check if log file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 /home/kali/backup/logs/sample_log.log"
    exit 1
fi

LOG_FILE="$1"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found!"
    exit 1
fi

# Variables for report
DATE=$(date +"%Y-%m-%d")
TOTAL_LINES=$(wc -l < "$LOG_FILE")
ERROR_COUNT=$(grep -E "ERROR|Failed" "$LOG_FILE" | wc -l)
REPORT_FILE="log_report_${DATE}.txt"

# Print Critical events with line numbers
CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

# Get Top 5 Error Messages
declare -A error_messages
while IFS= read -r line; do
    # Extract error message part from line
    msg=$(echo "$line" | grep -oP "(ERROR|Failed).*")
    if [[ -n "$msg" ]]; then
        ((error_messages["$msg"]++))
    fi
done < "$LOG_FILE"

# Sort error messages by occurrence count
TOP_ERRORS=$(for msg in "${!error_messages[@]}"; do
    echo "${error_messages[$msg]} $msg"
done | sort -nr | head -5)

# Create summary report
{
    echo "Date of Analysis: $DATE"
    echo "Log File: $LOG_FILE"
    echo "Total Lines Processed: $TOTAL_LINES"
    echo "Total Errors Found: $ERROR_COUNT"
    echo ""
    echo "Top 5 Error Messages:"
    echo "$TOP_ERRORS"
    echo ""
    echo "Critical Events with Line Numbers:"
    echo "$CRITICAL_EVENTS"
} > "$REPORT_FILE"

# Display the report to the user
cat "$REPORT_FILE"

# Optional Enhancement: Move processed log file to archive directory
ARCHIVE_DIR="/home/kali/log_archive"
mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE" "$ARCHIVE_DIR"

echo "Log file processed and moved to $ARCHIVE_DIR. Report saved as $REPORT_FILE"

