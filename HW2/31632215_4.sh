#!/bin/bash


grep -P '.*, [[:alpha:]]+ [[:alpha:]]+,.*' "$1" | while read -r full_line; do

    name=$(echo "$full_line" | sed -E 's/^([^,]+),.*/\1/')
    dob=$(echo "$full_line" | sed -E 's/.*, ([0-9]{4}-[0-9]{2}-[0-9]{2}),.*/\1/')
    

    birth_year=$(echo "$dob" | sed -E 's/([0-9]{4})-.*/\1/')
    

    current_year=2024


    age=$((current_year - birth_year))
    

    echo "$name, $age"
done | sort -t',' -k2,2nr

