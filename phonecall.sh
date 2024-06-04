#!/bin/bash

if [ $# -ne 2 ]
then
	echo "인수 오류"
	exit 1
fi

name=$1
number=$2

if ! echo "$number" | grep -qE '^[0-9]+$'
then
	echo "$number 값이 숫자가 아닙니다"
	exit 1
fi

PHONEBOOK="phonebook.txt"

info=$(grep -w "$name" "$PHONEBOOK")

if [ -n "$info" ]
then
	existing_number=$(echo "$info" | awk '{print $2}')
	while read -r existing_number
	do
		existing_number=$(echo "$existing_number" | tr -d '-')
		if [ "$existing_number" = "$number" ]
		then
			echo "이미 있는 정보 : $info"
			exit 0
		fi
	done <<< "$existing_number"
fi

if [ "${#number}" -eq 10 ]
then
    fir=$(echo $number | cut -c1-2)
    sec=$(echo $number | cut -c3-6)
    thr=$(echo $number | cut -c7-10)
elif [ "${#number}" -eq 11 ]
then
    fir=$(echo $number | cut -c1-3)
    sec=$(echo $number | cut -c4-7)
    thr=$(echo $number | cut -c8-11)
fi

declare -A area_number
area_number=(["02"]="서울" ["031"]="경기도" ["032"]="인천" ["033"]="강원도" ["041"]="충청남도" ["042"]="대전" ["043"]="충청북도" ["044"]="세종" ["051"]="부산")

if [[ -z "${area_number[$fir]}" ]]
then
    echo "해당 번호의 지역 이름을 찾을 수 없습니다."
    exit 2
else
    echo "번호 저장 : $name $fir-$sec-$thr ${area_number[$fir]}"
    echo "$name $fir-$sec-$thr ${area_number[$fir]}" >> "$PHONEBOOK"
    LC_COLLATE=ko_KR.utf8 sort -b $PHONEBOOK -o $PHONEBOOK
    exit 0
fi

