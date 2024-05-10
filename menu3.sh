#!/bin/bash

cat matches.csv | sort -nr -t, -k2 | head -n 3 | awk -F, '{printf("%s vs %s (%s)\n%d %s\n\n", $3, $4, $1, $2, $7)}'
