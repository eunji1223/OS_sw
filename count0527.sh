#!/bin/bash

time=$(date | cut -d " " -f5 | cut -d : -f1)
time=$time + 9
=> 이런 식으로 해야할 듯
#hour=$(date +%H)
#hour=$(( hour + 9 ))

if [ $time -lt 9 ]
then
	echo "굿모닝"
	exit 1
elif [ $time -lt 17]
then
	echo "굿애프터눈"
	exit 2
else
	echo "굿이브닝"
	exit 3
fi
