#!/bin/env bash

# For each machine directory (Zeus, Ganesha, etc...)
for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt >> $1/all_country_failed_login.txt    
	# ^ Grab their failed login data and combine into larger file
done

# Sort and count all the IPs. Put into a new file.
awk 'match($0, /.* ([0-9\.]*)/, groups) {print groups[1]}' $1/all_country_failed_login.txt| sort | uniq -c > $1/outFileCountry.txt 

# In order to easily join outFileCountry and country_IP, we swap the first and second columns in each file.
awk '{ t=$1 ; $1=$2; $2=t; print }' $1/outFileCountry.txt > $1/temp1.txt
awk '{ t=$1 ; $1=$2; $2=t; print }' etc/country_IP_map.txt > $1/temp2.txt

# Now finally join the IP/counts with the countries/IP map file. 
# This leaves the country counts fragmented and need to be cleaned later
join -1 1 -2 2 $1/temp1.txt $1/temp2.txt > $1/temp_final.txt

# Now strip out the IPs, leaving the countries and their counts
awk 'match($0, /[0-9.]+ ([0-9]+) ([A-Z]{2})/, groups) {print groups[2] " " groups[1]}' $1/temp_final.txt > $1/temp_final2.txt

# Now add up all the fragmented country counts, so there is one line and one count per country.
awk '{arr[$1]+=$2;} END {for (i in arr) print i, arr[i]}' $1/temp_final2.txt > $1/temp_final3.txt

# Sort the countries alphabetically
sort -k1,2 -k1,1 < $1/temp_final3.txt > $1/temp_final4.txt

# Now extract the countries/counts and format so Google-Vis can handle them in HTML
awk 'match ($0, /([A-Z]{2}) ([0-9]+)/, groups) {print "data.addRow([\x27"groups[1]"\x27, " groups[2]"]);"}' $1/temp_final4.txt  > $1/userCountry_body.html

#Finally, use wrap_contents to create an appropriate HTML file
./bin/wrap_contents.sh $1/userCountry_body.html ./html_components/country_dist $1/country_dist.html

