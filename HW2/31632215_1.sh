#!/bin/bash

# 1)
echo "Words with at least three 'a's:"
grep -i '^.*a.*a.*a.*$' dictionary.txt | wc -l

# 2)
echo -e "\nWords with exactly three 'e's, all separated by at least one non-'e' character:"
grep -i '^[^eE]*[eE][^eE]+[eE][^eE]+[eE][^eE]*$' dictionary.txt | wc -l

# 3)
grep -i 'ee' dictionary.txt > words_with_ee.txt

echo -e "\nMost common final three letters of words with adjacent 'e's:"
grep -oE '.{3}$' words_with_ee.txt | sort | uniq -c | sort -nr | head -3

