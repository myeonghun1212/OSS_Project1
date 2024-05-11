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

	if [ $choice -eq 1 ]; then
		read -p "Do you want to get the Heung-Min Son's data? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			players_file=$1
			# 손흥민 선수의 정보 추출
			son_data=$(grep "Heung-Min Son" $players_file)

			# 필요한 정보 추출
			current_club=$(echo "$son_data" | cut -d ',' -f 4)
			appearances=$(echo "$son_data" | cut -d ',' -f 6)
			goals=$(echo "$son_data" | cut -d ',' -f 7)
			assists=$(echo "$son_data" | cut -d ',' -f 8)

			# 결과 출력
			echo $son_data
			echo "Son Heung-Min's data:"
			echo "Current Club: $current_club"
			echo "Appearances: $appearances"
			echo "Goals: $goals"
			echo "Assists: $assists"

		break
	fi

	if [ $choice -eq 7 ]; then
		echo "Bye!"
		break
	fi
done
