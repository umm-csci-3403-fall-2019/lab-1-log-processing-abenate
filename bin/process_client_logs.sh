
cd $1/var/log

cat * > bigFile.txt

awk 'match($0, /(.+ [0-9]{2}):.* (for|user) (.*) from (.*) port/, groups) {print groups[1] " " groups[3] " " groups[4] }' bigFile.txt > failed_login_data.txt
