#!/bin/bash

len=$(cat teams.csv | wc -l)
len=$((len-1))
echo "$len"
for i in $(seq 1 $((len / 2))); do
	a=$(awk -F, -v t=$i 'NR==t+1{print $1}' teams.csv)
	diff=$((i+len/2))
	b=$(awk -F, -v t=$diff 'NR==t+1{print $1}' teams.csv)
	echo $i")"$a"	"$diff")"$b
done
read -p "Enter your team number :" num
selected_team=$(awk -F, -v t=$num 'NR==t+1{print $1}' teams.csv)
max_diff=$(awk -F',' -v team="$selected_team" '$3==team{printf("%s,%s,%s,%d,%d,%d\n", $1, $3, $4, $5, $6, ($5-$6))}' matches.csv | sort -nr -k6 -t, | head -n 1 | awk -F, '{print $6}')
awk -F',' -v team="$selected_team" '$3==team{printf("%s,%s,%s,%d,%d,%d\n", $1, $3, $4, $5, $6, ($5-$6))}' matches.csv | awk -F',' -v md=$max_diff '$6==md{printf("%s\n%s %d vs %d %s\n\n", $1, $2, $4,$5,$3)}' 
