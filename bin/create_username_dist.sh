echo $1



cat $1/cscirepo/failed_login_data.txt >> all_failed_login.txt
cat $1/ganesha/failed_login_data.txt >> all_failed_login.txt
cat $1/velcro/failed_login_data.txt >> all_failed_login.txt
cat $1/discovery/failed_login_data.txt >> all_failed_login.txt
cat $1/mylar/failed_login_data.txt >> all_failed_login.txt
cat $1/zeus/failed_login_data.txt >> all_failed_login.txt

awk 'match($0, /[a-zA-Z] .* ([a-z]+) /, groups) {print groups[1]}' all_failed_login.txt | sort | uniq -c > outFileName.txt 

#awk 'match($0, /(.+ [0-9]{2}):.* Failed .* (for|user) (.*) from (.*) port/, groups) {print groups[1] " " groups[3] " " groups[4] }' $1/var/log/* >> $1/failed_login_data.txt

#[a-zA-Z] .* ([\S]+) 