#!/bin/env bash


for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt >> $1/all_country_failed_login.txt    
	# ^ put everything in a file inside of $1
done


awk 'match($0, /.* ([0-9\.]*)/, groups) {print groups[1]}' $1/all_country_failed_login.txt| sort | uniq -c > $1/outFileCountry.txt 
