#!/bin/bash

here=$(pwd)

mkdir ../scratch

for VARIABLE in $1 $2 $3 $4 $5 $6
do
tar -zxf "$VARIABLE" --directory ../scratch
done




