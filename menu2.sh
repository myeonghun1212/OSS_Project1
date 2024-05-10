#!/bin/bash

read -p "What do you want to get the team data of league_position[1~20] : " target

cat teams.csv | awk -F, -v t=$target '$6 == t {printf("%d %s %lf", $6,$1, ($2/($2+$3+$4)))}'
