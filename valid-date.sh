#!/bin/bash

# 입력 인수 개수 확인
if [ "$#" -ne 3 ]; then
	    echo "입력값 오류"
	        exit 1
fi

month=$1
day=$2
year=$3

# 월을 대문자로 변환하고 약어 및 숫자 형태를 풀네임으로 변환
case ${month,,} in
	    jan|january|1)
		    month="Jan" ;;
	    feb|february|2)
		    month="Feb" ;;
	    mar|march|3)
		    month="Mar" ;;
	    apr|april|4) 
		    month="Apr" ;;
	    may|5) 
		    month="May" ;;
	    jun|june|6) 
		    month="Jun" ;;
	    jul|july|7) 
		    month="Jul" ;;
	    aug|august|8) 
		    month="Aug" ;; 
	    sep|september|9) 
		    month="Sep" ;;				        
	    oct|october|10) 
		    month="Oct" ;;	   
	    nov|november|11) 
		    month="Nov" ;;
	    dec|december|12)
		    month="Dec" ;;						  
	    *) 
		    echo "월이 유효하지 않습니다: $month $day $year"; exit 1 ;;
    esac
    # 윤년 판별
    is_leap_year=false
    if (( year % 4 == 0 )); then
	    if (( year % 100 != 0 )) || (( year % 400 == 0 )); then
		    is_leap_year=true
	    fi
    fi

# 각 달의 일 수 설정
declare -A days_in_month
days_in_month=( ["Jan"]=31 ["Feb"]=28 ["Mar"]=31 ["Apr"]=30 ["May"]=31 ["Jun"]=30 ["Jul"]=31 ["Aug"]=31 ["Sep"]=30 ["Oct"]=31 ["Nov"]=30 ["Dec"]=31 )

if $is_leap_year && [ "$month" == "Feb" ]; then
	days_in_month["Feb"]=29
fi

# 입력된 날짜의 유효성 검사
if ! [[ "$day" =~ ^[0-9]+$ ]]; then
	echo "날짜가 유효하지 않습니다: $month $day $year"
	exit 1
fi

if [ "$day" -lt 1 ] || [ "$day" -gt "${days_in_month[$month]}" ]; then
	echo "날짜가 유효하지 않습니다: $month $day $year"
	exit 1
fi
 # 유효한 날짜일 경우 출력
echo "$month $day $year"

