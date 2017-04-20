#!/bin/zsh

diffExt=.txt
diffPrefix=Diff_
fileRegex=_old.

if [ $# != 1 ]; then
	echo 参数个数不正确: 例如, diffpatch.sh 输入目录
	exit 1;
fi

for file in `ls $1 | grep $fileRegex`; do
	fileName=${file%.*}
	fileExt=${file##*.}
	echo "diff -u $file ${file/_old/_new} $1/$diffPrefix${fileName/_old/}.$fileExt$diffExt"
	diff -u $1/$file $1/${file/_old/_new} > $1/$diffPrefix${fileName/_old/}.$fileExt$diffExt
done
