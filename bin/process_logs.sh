#!/bin/bash
here=$(pwd)

mkdir scratch

for VARIABLE in $@;
do
	#cd $here/scratch
	dirString=${VARIABLE/_"secure.tgz"}
	mkdir $here/scratch/$dirString

	#cd $here/log_files
	tar -zxf "./log_files/$VARIABLE" -C $here/scratch/$dirString
	
    #current=$"($here/scratch/$dirString/var/log)"

	bin/process_client_logs.sh $here/scratch/$dirString

done

# cd $here/scratch

# cat cscirepo_secure/var/log/failed_login_data.txt >> failed_login_data.txt 
# cat ganesha_secure/var/log/failed_login_data.txt >> failed_login_data.txt 
# cat velcro_secure/var/log/failed_login_data.txt >> failed_login_data.txt 
# cat discovery_secure/var/log/failed_login_data.txt >> failed_login_data.txt 
# cat mylar_secure/var/log/failed_login_data.txt >> failed_login_data.txt 
# cat zeus_secure/var/log/failed_login_data.txt >> failed_login_data.txt 








