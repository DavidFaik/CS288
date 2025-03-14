#!/bin/bash

display_file() {
    local file="$1"
    local lines=10
    local start=1

    while true; do
        clear
        echo "Displaying lines $start to $((start + lines - 1)) of $file"
        head -n $((start + lines - 1)) "$file" | tail -n $lines

        start=$((start + lines))
        echo -n "Do you want to display more? (yes/no): "
        read choice
        if [[ "$choice" != "yes" ]]; then
            break
        fi
    done
}

search_recent_files() {
    local dir="$1"
    local current_time=$(date +%s)
    local recent_files=()

    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            mod_time=$(stat -c %Y "$file")
            if ((current_time - mod_time <= 86400)); then
                recent_files+=("$file")
            fi
        fi
    done

    if [[ ${#recent_files[@]} -eq 0 ]]; then
        echo "No files modified in the last 24 hours."
        return
    fi

    echo "Recently modified files:"
    select file in "${recent_files[@]}"; do
        if [[ -n "$file" ]]; then
            display_file "$file"
            break
        fi
    done
}

navigate_directory() {
    local dir="$1"
    cd "$dir" || return

    while true; do
        echo "Current directory: $(pwd)"
        echo "Contents:"
        select item in * ".. (Go Up)" "Exit"; do
            if [[ "$item" == "Exit" ]]; then
                exit 0
            elif [[ "$item" == ".. (Go Up)" ]]; then
                cd ..
                break
            elif [[ -f "$item" ]]; then
                display_file "$item"
                break
            elif [[ -d "$item" ]]; then
                navigate_directory "$item"
                break
            else
                echo "Invalid selection, please try again."
            fi
        done
    done
}

main() {
    while true; do
        echo -n "Enter a directory name: "
        read dir
        
        if [[ -d "$dir" ]]; then
            navigate_directory "$dir"
            break
        else
            echo -n "Directory does not exist. Do you want to create it? (yes/no): "
            read choice
            if [[ "$choice" == "yes" ]]; then
                mkdir -p "$dir"
                echo "Directory '$dir' created."
                navigate_directory "$dir"
                break
            fi
        fi
    done
}

main

