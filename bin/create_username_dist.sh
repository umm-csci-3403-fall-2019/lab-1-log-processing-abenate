# Here we go through each individual file and append to the all_failed_login.txt

# Grab each subdirectory from $1
for dir in `ls $1`
do
	cat "$1"/"$dir"/failed_login_data.txt >> $1/all_failed_login.txt    
	# ^ put everything in a file inside of $1
done

# Now we extract the names and start sorting/counting
awk 'match($0, /[a-zA-Z] .* ([a-zA-Z0-9]*) /, groups) {print groups[1]}' $1/all_failed_login.txt | sort | uniq -c > $1/outFileName.txt 

# Now we format the names/counts so they can go into the HTML
awk 'match ($0, / *([0-9]*) ([a-zA-Z0-9]*)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' $1/outFileName.txt > $1/username_body.html

# This does the actual wrapping for the html
./bin/wrap_contents.sh $1/username_body.html ./html_components/username_dist $1/username_dist.html
