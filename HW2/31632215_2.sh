#!/bin/bash

input_file=$1


lines=$(wc -l < "$input_file")
total_lines=$(($lines-1))

scanf_count=$(grep -c "scanf" "$input_file")


printf_count=$(grep -c "printf" "$input_file")


grep "scanf" "$input_file" >> scanf_log.txt


grep "printf" "$input_file" >> printf_log.txt


scanf_percentage=$(awk "BEGIN {printf \"%.2f\", ($scanf_count/$total_lines)*100}")

printf_percentage=$(awk "BEGIN {printf \"%.2f\", ($printf_count/$total_lines)*100}")


echo "Total lines in '$input_file': $total_lines"
echo "Lines containing 'scanf': $scanf_count ($scanf_percentage%)"
echo "Lines containing 'printf': $printf_count ($printf_percentage%)"

