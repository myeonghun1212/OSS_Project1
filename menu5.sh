#!/bin/bash

sed -E 's/,.*//' matches.csv | sed 's/\(...\) \([0-9]\{2\}\) \([0-9]\{4\}\) - \(.*\)/\3\/\1\/\2 \4/g' | sed 's/Jan/01/g; s/Feb/02/g; s/Mar/03/g; s/Apr/04/g; s/May/05/g; s/Jun/06/g; s/Jul/07/g; s/Aug/08/g; s/Sep/09/g; s/Oct/10/g; s/Nov/11/g; s/Dec/12/g;' | head -n 11 | tail -n +2
