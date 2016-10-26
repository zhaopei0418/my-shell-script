#!/bin/bash

DATE=`date +%y%m%d`

FILE=archive-$DATE.tar.gz
CONFIG_FILE=/home/zhaopei/files_to_backup
DESTINATION=/home/zhaopei/archive/$FILE

if [ -f $CONFIG_FILE ]
then
	echo
else
	echo
	echo "$CONFIG_FILE 不存在."
	echo "没有找到备份的配置文件"
	echo
	exit
fi

FILE_NO=1

exec < $CONFIG_FILE
read FILE_NAME

while [ $? -eq 0 ]
do
	if [ -f $FILE_NAME -o -d $FILE_NAME ]
	then
		FILE_LIST="$FILE_LIST $FILE_NAME"
	else
		echo
		echo "$FILE_NAME 不存在."
		echo "将不包含这个文件到归档文件"
		echo "配置文件的第$FILE_NO行"
		echo "继续归档其他文件"
		echo
	fi
	FILE_NO=$[$FILE_NO + 1]
	read FILE_NAME
done

tar -zcf $DESTINATION $FILE_LIST 2> /dev/null
