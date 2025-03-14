#!/bin/bash


if [ "$#" -lt 3 ]; then
    echo "Error: Please provide at least three filenames."
    exit 1
fi


backup_dir="backup_$(date +'%Y%m%d')"
mkdir -p "$backup_dir"


for file in "$@"; do

    if [ -e "$file" ]; then

        timestamp=$(date +'%Y%m%d')
        cp "$file" "$backup_dir/$file"
        

        mv "$backup_dir/$file" "$backup_dir/${file}_$timestamp"
        
        echo "Backed up: $file to $backup_dir/${file}_$timestamp"
    else
        echo "Warning: File '$file' does not exist. Skipping."
    fi
done


log_file="$backup_dir/backup_log.txt"
echo "Backup Log - $(date)" > "$log_file"
for file in "$@"; do
    if [ -e "$file" ]; then
        echo "$file -> ${file}_$timestamp" >> "$log_file"
    fi
done

echo "Backup process completed. Backup directory: $backup_dir"

