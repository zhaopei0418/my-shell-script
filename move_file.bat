@echo off
echo ѭ��5��Ѹ���Data\receive�µ�txt��send\EListReject\
rem �˵����ĺ�׺Ϊ.td,�ƶ�����������,.txt,.rfdֱ���ƶ�
set fileType=*.td
set changeType=*.xml
set moveFileType=*.rfd,*.txt
set inputFile=c:\zhaopei\1
set outputDir=c:\zhaopei\2
set changeExt=c:\zhaopei\3
:w
choice /t 5 /d y /n > nul
call:getDateTime
echo �ƶ��ļ�����: %moveFileType%
for /r %inputFile% %%i in (%moveFileType%) do (
	echo Ҫ�ƶ����ļ�: %%~dpnxi
	move "%%~dpnxi" %outputDir%
) >> move.log
echo �ƶ��������ļ�����: %fileType% %changeType%
for /f "delims=" %%a in ('dir /b/a %inputFile%\%fileType%') do (
	echo �ƶ��ļ�: %inputFile%\%%a
	move "%inputFile%\%%a" %changeExt%
	echo �������ļ�: %changeExt%\%%a
	rename "%changeExt%\%%a" %changeType%
	echo �ƶ��ļ�������Ŀ¼: %outputDir%\%%a
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
		echo ��ǰʱ�䣺%datevar% %timevar% >> move.log
	ENDLOCAL
goto:eof