#!/bin/env bash


for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt > $1/all_country_failed_login.txt    
	# ^ put everything in a file inside of $1
done


awk 'match($0, /.* ([0-9\.]*)/, groups) {print groups[1]}' $1/all_country_failed_login.txt| sort | uniq -c > $1/outFileCountry.txt 

awk '{ t=$1 ; $1=$2; $2=t; print }' $1/outFileCountry.txt > $1/temp1.txt
awk '{ t=$1 ; $1=$2; $2=t; print }' etc/country_IP_map.txt > $1/temp2.txt

awk '{ t=$1 ; $1=$2; $2=t; print }' etc/country_IP_map.txt > $1/temp_final.txt

join -1 1 -2 2 $1/temp1.txt $1/temp2.txt > $1/temp_final.txt

awk 'match($0, /[0-9.]+ ([0-9]+) ([A-Z]{2})/, groups) {print groups[2] " " groups[1]}' $1/temp_final.txt > $1/temp_final2.txt

awk '{arr[$1]+=$2;} END {for (i in arr) print i, arr[i]}' $1/temp_final2.txt > $1/temp_final3.txt


awk 'match ($0, /([A-Z]{2}) ([0-9]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' $1/temp_final3.txt  > $1/userCountry_body.html

./bin/wrap_contents.sh $1/userCountry_body.html ./html_components/country_dist $1/country_dist.html

