#!/bin/zsh
#inputStr=/Users/zhaopei/data2/work/patch/20170417/EcssEnt-v4.1-153-20170414-R-核放单配载一线入区报关申请单新增一单多车处理逻辑
#outputStr=/Users/zhaopei/data2/work/patch/20170417/155
outputStr=$2
ext=(js jsp xml properties)
fileSuffix=$3

function copy_file_and_compile()
{
	for file in `ls $1`; do
		echo $file
		fileName=${file%.*}
		fileExt=${file##*.}
		echo 文件名是:$fileName \\t $fileExt
		if [ -d $1/$file ]; then
			copy_file_and_compile $1/$file
		else
			for e in $ext; do
				if [ $e = $fileExt ]; then
					if [ ! -e $outputStr ]; then
						mkdir $outputStr
					fi
					cp $1/$file $outputStr/$fileName$fileSuffix.$fileExt
				fi
			done
			if [ "class" = $fileExt ]; then
				jad -sjava -d$outputStr $1/$file
				mv $outputStr/$fileName.java $outputStr/$fileName$fileSuffix.java
			fi
		fi
	done
}

if [ $# != 3 ]; then
	echo 参数个数不正确:例如,exexjad.sh 输入文件夹 输出文件夹 文件后缀
else
	copy_file_and_compile $1
fi
