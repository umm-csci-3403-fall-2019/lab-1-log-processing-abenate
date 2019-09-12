

# use awk to extract the date, time, username and ip from all files inside $1/var/log... append to a txt file called failed_login_data
awk 'match($0, /(.+ [0-9]{2}):.* Failed .* (for|user) (\S*[0-9]*) from (.*) port/, groups) {print groups[1] " " groups[3] " " groups[4] }' $1/var/log/* >> $1/failed_login_data.txt

