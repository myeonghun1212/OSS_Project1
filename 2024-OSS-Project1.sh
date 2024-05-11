#!/usr/bin/bash

#입력 형태 ./2024-OSS-Project1.sh teams.csv players.csv matches.csv
#에러 메시지 처리
if [ $# -ne 3 ]; then
	echo "usage: ./2024-OSS-Project1.sh file1 file2 file3"
	exit 1
fi

student_id="12234183"
student_name=$(whoami)

# 출력의 좌우 대칭을 맞춤
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
#메뉴표시
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


	#awk로 입력한 league_position이면 수식에 맞춰 값 출력
	if [ $choice -eq 2 ]; then
		read -p "What do you want to get the team data of league_position[1~20] : " target
		cat $1 | awk -F',' -v t="$target" '$6==t{printf("%d %s %lf\n", $6,$1, ($2/($2+$3+$4)))}'
	fi

	#데이터를 attendance 기준 정렬 위에 3개만 꺼낸 다음 awk로 포맷팅
	if [ $choice -eq 3 ]; then
		read -p "Do you want to know Top-3 attendance data and average attendance? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			echo "***Top-3 Attendance Match***"
			echo ""
			cat $3 | sort -nr -t, -k2 | head -n 3 | awk -F, '{printf("%s vs %s (%s)\n%d %s\n\n", $3, $4, $1, $2, $7)}'
		fi
	fi

	#teams 데이터를 leaguepos기준 정렬 후 첫 행 제거한 다음 
	#awk의 system 사용해서 각 행마다 players 로딩 팀 이름 기준으로 찾고 점수 기준 정렬 후 첫 째 행 꺼낸 다음
	#awk 사용해서 포맷팅
	if [ $choice -eq 4 ]; then
		read -p "Do you want to get each team's ranking and the highest-scoring player? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			cat $1 | sort -n -k6 -t',' | tail -n +2 | awk -F, -v file=$2 '{system("cat "file" | grep \""$1"\" -a | sort -rn -t, -k7 | head -n 1")}' | awk -F, '{printf("%d %s\n %s %d\n\n", NR, $4, $1 , $7)}'
		fi
	fi

	#sed 사용해서 , 이후 제거 (시간 이외의 정보 필요없음)
	#sed 사용해서 3글자 숫자2개 숫자4개 - 남은문자를 3/1/2/4 순으로 바꿈
	#sed 사용해서 각 월 문자(Aug)를 숫자(8)로 바꿈
	if [ $choice -eq 5 ]; then
		read -p "Do you want to modify the format of date? (y/n) :" confirm
		if [ $confirm = 'y' ]; then
			sed -E 's/,.*//' $3 | sed 's/\(...\) \([0-9]\{2\}\) \([0-9]\{4\}\) - \(.*\)/\3\/\1\/\2 \4/g' | sed 's/Jan/01/g; s/Feb/02/g; s/Mar/03/g; s/Apr/04/g; s/May/05/g; s/Jun/06/g; s/Jul/07/g; s/Aug/08/g; s/Sep/09/g; s/Oct/10/g; s/Nov/11/g; s/Dec/12/g;' | head -n 11 | tail -n +2
		fi
	fi

	#1. 선택창 출력 방법
	#len에 teams의 전체 길이 저장
	#2열로 출력해야하니까 2로 나눠서 왼쪽에는 1 2 3 4.. 오른쪽에는 왼쪽값에 길이/2를 더한 값에 해당하는 번호를 출력해야함
	#awk로 위에서 구한 인덱스에 맞춰서 이름 꺼내옴
	#출력
	#2. 입력받은 이후 최대 차이 구하기
	#팀 이름 awk로 가져옴 사용자가 입력한 번호와 행번호를 잘 비교
	#awk를 사용해서 matches에서 사용자가 입력한 팀 기준으로 시간,홈팀,원정팀,홈팀점수,원정팀점수,점수차이 형식으로 출력 (새로운 csv 처럼 활용)
	#출력한 양식을 정렬 후 맨 위 한줄 가지고 와서 점수 차이만 저장하면 그게 최대 점수 차이
	#출력한 양식에서 awk로 앞서 구한 최대 점수차이랑 점수 차이가 같은 행 찾아서 출력함 ( 같은 점수차가 여러개 있을 수 있어서 다시 검사 해야함 )
	if [ $choice -eq 6 ]; then
		len=$(cat $1 | wc -l)
		len=$((len-1))
		for i in $(seq 1 $((len / 2))); do
			a=$(awk -F, -v t=$i 'NR==t+1{print $1}' $1)
			diff=$((i+len/2))
			b=$(awk -F, -v t=$diff 'NR==t+1{print $1}' $1)
			echo $i")"$a"	"$diff")"$b
		done
		read -p "Enter your team number :" num
		echo ""
		selected_team=$(awk -F, -v t=$num 'NR==t+1{print $1}' $1)
		max_diff=$(awk -F',' -v team="$selected_team" '$3==team{printf("%s,%s,%s,%d,%d,%d\n", $1, $3, $4, $5, $6, ($5-$6))}' $3 | sort -nr -k6 -t, | head -n 1 | awk -F, '{print $6}')
		awk -F',' -v team="$selected_team" '$3==team{printf("%s,%s,%s,%d,%d,%d\n", $1, $3, $4, $5, $6, ($5-$6))}' $3 | awk -F',' -v md=$max_diff '$6==md{printf("%s\n%s %d vs %d %s\n\n", $1, $2, $4,$5,$3)}' 
	fi

	if [ $choice -eq 7 ]; then
		echo "Bye!"
		break
	fi
done
