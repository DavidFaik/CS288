#!/bin/bash

if [ -z "$1" ]; then
    echo "Please enter the name of a file or directory: "
    read filename
else
    filename=$1
fi

if [ -d "$filename" ]; then
    echo "$filename is a directory."
    
    if [ ! -r "$filename" ] || [ ! -x "$filename" ]; then
        echo "Warning: You do not have read and execute permissions on the directory."
    else

        file_count=$(ls -l "$filename" | grep -v '^d' | wc -l)
        subdir_count=$(ls -l "$filename" | grep '^d' | wc -l)
	echo "Number of files: $(($file_count-1))"
        echo "Number of subdirectories: $subdir_count"
        
   
        echo "List of files and subdirectories with their sizes:"
        ls -lh "$filename"
    fi

elif [ -f "$filename" ]; then
    echo "$filename is a file."

    
    if [ ! -r "$filename" ]; then
        echo "Warning: You do not have read permission on the file."
    else
        
        wc_output=$(wc "$filename")
        word_count=$(echo "$wc_output" | awk '{print $1}')
        line_count=$(echo "$wc_output" | awk '{print $2}')
        char_count=$(echo "$wc_output" | awk '{print $3}')
        
        echo "Word count: $word_count"
        echo "Line count: $line_count"
        echo "Character count: $char_count"
        

        if [ $char_count -gt 10000 ]; then
            echo "This file is 'Text Heavy'."
        elif [ $char_count -ge 1000 ]; then
            echo "This file is 'Moderately Sized'."
        else
            echo "This file is 'Light File'."
        fi
    fi

else
    echo "$filename is neither a valid file nor directory."
fi

