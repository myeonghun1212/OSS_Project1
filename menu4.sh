#!/bin/bash

cat teams.csv | sort -n -k6 -t',' | tail -n +2 | awk -F, '{system("cat players.csv | grep \""$1"\" -a | sort -rn -t, -k7 | head -n 1")}' | awk -F, '{printf("%d %s\n %s %d\n\n", NR, $4, $1 , $7)}'
