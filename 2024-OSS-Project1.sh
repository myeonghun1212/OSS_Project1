#!/usr/bin/bash

#./2024-OSS-Project1.sh teams.csv players.csv matches.csv

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
			players_file=$2
			# 손흥민 선수의 정보 추출
			son_data=$(grep "Heung-Min Son" $players_file)

			# 필요한 정보 추출
			current_club=$(echo "$son_data" | cut -d ',' -f 4)
			appearances=$(echo "$son_data" | cut -d ',' -f 6)
			goals=$(echo "$son_data" | cut -d ',' -f 7)
			assists=$(echo "$son_data" | cut -d ',' -f 8)

			# 결과 출력
			echo Team: $current_club, Apperance: $appearances, Goal: $goals, Assist: $assists
		fi
	fi


	if [ $choice -eq 2 ]; then
		read -p "What do you want to get the team data of league_position[1~20] : " target
		cat $1 | awk -F',' -v t="$target" '$6==t{printf("%d %s %lf\n", $6,$1, ($2/($2+$3+$4)))}'
	fi

	if [ $choice -eq 3 ]; then
		read -p "Do you want to know Top-3 attendance data and average attendance? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			echo "***Top-3 Attendance Match***"
			echo ""
			cat $3 | sort -nr -t, -k2 | head -n 3 | awk -F, '{printf("%s vs %s (%s)\n%d %s\n\n", $3, $4, $1, $2, $7)}'
		fi
	fi

	if [ $choice -eq 3 ]; then
		read -p "Do you want to get each team's ranking and the highest-scoring player? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			cat $1 | sort -n -k6 -t',' | tail -n +2 | awk -F, -v file=$2 '{system("cat "file" | grep \""$1"\" -a | sort -rn -t, -k7 | head -n 1")}' | awk -F, '{printf("%d %s\n %s %d\n\n", NR, $4, $1 , $7)}'
		fi
	fi

	if [ $choice -eq 7 ]; then
		echo "Bye!"
		break
	fi
done
