#!/bin/zsh

if [ $# != 5 ]; then
	echo 参数个数不正确: 例如, compile_and_diff.zsh 第一个输入目录 文件后缀 第二个输入目录 文件后缀 输出目录
	exit 1;
fi

execjad.zsh $1 $5 $2
execjad.zsh $3 $5 $4
diffpatch.zsh $5
