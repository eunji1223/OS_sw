
if [ $# -ne 1 ] 
then 
	echo "인자 갯수 오류"
	exit 1 
fi
:
user=$1
user_chech=false

while true
do
	if who | grep "$user"
	then
		echo "$user 로그인 함!"
		break
	sleep 60
done
