#!/bin/bash

# This will be useful so we don't have to 'cd'
here=$(pwd)

# This should be turned into a temp directory later
mkdir scratch

# for each arg..
for VARIABLE in $@;
do

	# extract the stem word from the filename, and create a dir same name
	dirString=${VARIABLE/_"secure.tgz"}
	mkdir $here/scratch/$dirString

	# extract the args into the dir of same name
	tar -zxf "./log_files/$VARIABLE" -C $here/scratch/$dirString

	# process the client logs
	bin/process_client_logs.sh $here/scratch/$dirString

done

# now process the username/counts
./bin/create_username_dist.sh ./scratch
./bin/create_hours_dist.sh ./scratch
./bin/create_country_dist.sh ./scratch








