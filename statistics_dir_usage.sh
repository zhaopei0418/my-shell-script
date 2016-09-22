#!/bin/bash
#
# 检查目录中硬盘占用率前10名
# 需要检查的目录
CHECK_DIRECTORIES="/var/log /home"
#
DATE=$(date '+%Y%m%d')
#
exec > disk_space_$DATE.rpt
#
echo "前10名文件夹磁盘使用率"
echo "循环的目录 $CHECK_DIRECTORIES"
#
for DIR_CHECK in $CHECK_DIRECTORIES
do
	echo ""
	echo "检查的目录是$DIR_CHECK:"
	du -S $DIR_CHECK 2>/dev/null | sort -rn |
		sed '{11,$D; =}' | sed 'N; s/\n/ /' |
		gawk '{print $1 ":" "\t" $2 "\t" $3}'
done
