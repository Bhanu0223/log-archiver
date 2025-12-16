#!/bin/bash

# Usage: ./archive_logs.sh /path/to/logs DAYS

LOG_DIR="$1"
DAYS="$2"
ARCHIVE_DIR="./archives"

if [ -z "$LOG_DIR" ] || [ -z "$DAYS" ]; then
  echo "Usage: $0 /path/to/logs DAYS"
  # $0 = the name (or path) of the script being executed

  
  exit 1
fi

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="logs_$TIMESTAMP.tar.gz"

mkdir -p "$ARCHIVE_DIR"

# Archive first
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

if [ $? -ne 0 ]; then
  echo "❌ Archiving failed. Cleanup skipped."
  exit 1
fi

# Delete logs older than X days
find "$LOG_DIR" -type f -mtime +"$DAYS" -name "*.log" -delete

echo "✅ Logs archived and logs older than $DAYS days deleted"
