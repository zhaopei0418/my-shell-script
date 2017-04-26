@echo off
echo 循环5秒把复制Data\receive下的txt到send\EListReject\
rem 退单报文后缀为.td,移动并重新命名,.txt,.rfd直接移动
set fileType=*.td
set changeType=*.xml
set moveFileType=*.rfd,*.txt
set inputFile=c:\zhaopei\1
set outputDir=c:\zhaopei\2
set changeExt=c:\zhaopei\3
:w
choice /t 5 /d y /n > nul
call:getDateTime
echo 移动文件类型: %moveFileType%
for /r %inputFile% %%i in (%moveFileType%) do (
	echo 要移动的文件: %%~dpnxi
	move "%%~dpnxi" %outputDir%
) >> move.log
echo 移动重命名文件类型: %fileType% %changeType%
for /f "delims=" %%a in ('dir /b/a %inputFile%\%fileType%') do (
	echo 移动文件: %inputFile%\%%a
	move "%inputFile%\%%a" %changeExt%
	echo 重命名文件: %changeExt%\%%a
	rename "%changeExt%\%%a" %changeType%
	echo 移动文件到最终目录: %outputDir%\%%a
	move "%changeExt%\%changeType%" %outputDir%
) >> move.log
goto w

:getDateTime
	SETLOCAL
		set datevar=%date:~0,4%-%date:~5,2%-%date:~8,2%
		set timevar=%time:~0,2%
		if /i %timevar% LSS 10 (
			set timevar=0%time:~1,1%
		)
		set timevar=%timevar%:%time:~3,2%:%time:~6,2%
		echo 当前时间：%datevar% %timevar% >> move.log
	ENDLOCAL
goto:eof