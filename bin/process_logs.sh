#!/bin/bash
here=$(pwd)

mkdir $here/scratch

for VARIABLE in $1 $2 $3 $4 $5 $6
do
	cd $here/scratch
	dirString=${VARIABLE/.tgz}
	mkdir $dirString

	cd $here/log_files
	tar -zxf "$VARIABLE" -C $here/scratch/$dirString
	
    #current=$"($here/scratch/$dirString/var/log)"

	$here/bin/process_client_logs.sh $here/scratch/$dirString

done







