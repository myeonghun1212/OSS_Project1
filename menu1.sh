#!/bin/bash

# players.csv 파일 경로를 변수에 저장
players_file="players.csv"

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
