#!/bin/env bash

$1

for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt >> $1/allHour_failed_login.txt    
	# ^ put everything in a file inside of $1
done



awk 'match($0, /[ a-zA-Z]+ [0-9]* ([0-9]*) /, groups) {print groups[1]}' $1/allHour_failed_login.txt| sort | uniq -c > $1/outFileHours.txt 

awk 'match ($0, /  *([0-9]*) ([0-9]*)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' $1/outFileHours.txt  > $1/userHour_body.html

./bin/wrap_contents.sh $1/userHour_body.html ./html_components/hours_dist $1/hours_dist.html
