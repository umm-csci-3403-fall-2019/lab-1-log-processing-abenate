#!/bin/bash

here=$(pwd)

mkdir ../scratch

for VARIABLE in $1 $2 $3 $4 $5 $6
do
	dirString=${VARIABLE/.tgz}
	cd ../scratch
	mkdir $dirString

	cd ../log_files
	tar -zxf "$VARIABLE" --directory ../scratch/$dirString
done




