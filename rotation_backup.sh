#!/bin/bash

# Step 1: Assign the directory to backup and the backup destination
SOURCE_DIR="/home/kali/devops_scripts"
BACKUP_DIR="/home/kali/backup"

# Step 2: Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory $SOURCE_DIR does not exist."
  exit 1
fi

# Step 3: Create a timestamp for the backup folder
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Step 4: Define the backup folder name inside the target directory
BACKUP_FOLDER="$BACKUP_DIR/backup_$TIMESTAMP"

# Step 5: Create the backup folder
mkdir -p "$BACKUP_FOLDER"

# Step 6: Copy all files from the source directory to the backup folder
cp -r "$SOURCE_DIR"/* "$BACKUP_FOLDER" 2>/dev/null

# Step 7: Notify user that the backup is created
echo "Backup created: $BACKUP_FOLDER"

# Step 8: Find all existing backup folders and sort them by modification time
BACKUPS=$(ls -dt "$BACKUP_DIR"/backup_* 2>/dev/null)

# Step 9: Count the number of backup folders
NUM_BACKUPS=$(echo "$BACKUPS" | wc -l)

# Step 10: If there are more than 3 backups, remove the oldest ones
if [ "$NUM_BACKUPS" -gt 3 ]; then
  # Keep only the last 3 backups and delete the rest
  REMOVE_BACKUPS=$(echo "$BACKUPS" | tail -n +4)
  echo "Removing old backups..."
  echo "$REMOVE_BACKUPS" | xargs rm -rf
  echo "Old backups removed."
fi

