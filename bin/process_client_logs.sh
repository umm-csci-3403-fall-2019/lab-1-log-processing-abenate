awk 'match($0, /(.+ [0-9]{2}):.* Failed .* (for|user) (.*) from (.*) port/, groups) {print groups[1] " " groups[3] " " groups[4] }' $1/var/log/* >> $1/failed_login_data.txt

