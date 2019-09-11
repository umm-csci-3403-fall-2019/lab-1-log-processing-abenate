echo $1



cat $1/cscirepo/failed_login_data.txt >> all_failed_login.txt
cat $1/ganesha/failed_login_data.txt >> all_failed_login.txt
cat $1/velcro/failed_login_data.txt >> all_failed_login.txt
cat $1/discovery/failed_login_data.txt >> all_failed_login.txt
cat $1/mylar/failed_login_data.txt >> all_failed_login.txt
cat $1/zeus/failed_login_data.txt >> all_failed_login.txt

awk 'match($0, /[a-zA-Z] .* ([a-z]+) /, groups) {print groups[1]}' all_failed_login.txt | sort | uniq -c > outFileName.txt 

awk 'match ($0, / *([0-9]*) ([a-z]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' outFileName.txt > logBody.txt

./bin/wrap_contents.sh logBody.txt ./html_components/username_dist wrapped_logs.html