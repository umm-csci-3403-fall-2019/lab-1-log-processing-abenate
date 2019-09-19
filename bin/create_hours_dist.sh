#!/bin/env bash

# For each machine directory (Zeus, Ganesha, etc...)
for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt >> $1/allHour_failed_login.txt    
	# ^ Grab their failed login data and combine into larger file
done


# Extract the hours from the above file, count/sort them, and output to a text file.
awk 'match($0, /[ a-zA-Z]+ [0-9]* ([0-9]*) /, groups) {print groups[1]}' $1/allHour_failed_login.txt| sort | uniq -c > $1/outFileHours.txt 

# Now extract the countries/counts and format so Google-Vis can handle them in HTML
awk 'match ($0, /  *([0-9]*) ([0-9]*)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' $1/outFileHours.txt  > $1/userHour_body.html

#Finally, use wrap_contents to create an appropriate HTML file
./bin/wrap_contents.sh $1/userHour_body.html ./html_components/hours_dist $1/hours_dist.html
