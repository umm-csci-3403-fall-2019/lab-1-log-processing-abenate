#!/bin/bash

# This dir essentially temporary, as it gets deleted later
# All the work gets done in here.
mkdir scratch

# for each argument passed in (likely a list of files)
for VARIABLE in $@;
do

	# trim secure_tgz off the file name...
	dirString=${VARIABLE/_"secure.tgz"}

	# ... then trim off the parent directory to give us the stem word
	dirString=${dirString#l*/}

	# finally make a directory with the name=dirstring
	mkdir ./scratch/$dirString

	# extract the args into the dir of same name
	tar -zxf "./$VARIABLE" -C ./scratch/$dirString

	# process the client logs
	bin/process_client_logs.sh ./scratch/$dirString

done

# now process the usernames/hours/countries
./bin/create_username_dist.sh ./scratch
./bin/create_hours_dist.sh ./scratch
./bin/create_country_dist.sh ./scratch

#Finally, assemble the HTML document with the report on malicious activity
./bin/assemble_report.sh ./scratch

# Don't forget to delete the directory we did the work in.
 rm -rf scratch








