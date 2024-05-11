#!/usr/bin/bash

student_id="12345678"
student_name=$(whoami)

total_length=39
name_length=$(echo $student_name | wc -m )
padding_length=$(((total_length - name_length - 9) / 2 - 1))

padding=$(printf "%*s" $padding_length "")

echo "************OSS1 - Project1************"
echo "*        StudentID : $student_id         *"
echo "*$padding Name : $student_name $padding *"
echo "***************************************"

while :
do
	echo "[MENU]"
	echo "1. Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv"
	echo "2. Get the team data to enter a league position in teams.csv"
	echo "3. Get the Top-3 Attendance matches in mateches.csv"
	echo "4. Get the team's league position and team's top scorer in teams.csv & players.csv"
	echo "5. Get the modified format of date_GMT in matches.csv"
	echo "6. Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
	echo "7. Exit"
	read -p "Enter your CHOICE (1~7) :" choice

	if [ $choice -eq 7 ]; then
		echo "Bye!"
		break
	fi
done
