#!/bin/bash

directory=$1

abs_path=$(realpath "$directory")

temp_file=$(mktemp)

traverse_directory() {
    local dir=$1
    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            traverse_directory "$file"
        elif [ -f "$file" ] && [[ "$file" == *.txt ]]; then
            grep -oE "[A-Za-z][A-Za-z0-9._-]*@[A-Za-z]+\.[A-Za-z]{2,}" "$file" >> "$temp_file"
        fi
    done
}

traverse_directory "$abs_path"

sort -u "$temp_file" > unique_emails.txt

rm "$temp_file"

