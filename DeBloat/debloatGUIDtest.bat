@echo off
set selfDir=%~dp0
:adminCheck
set /p tmp=Checking for administrator rights...<NUL
net session >nul 2>&1
if %errorlevel%==0 (
	echo Admin rights confirmed
	goto guidTest
) else (
	echo De-Bloat not run with administrator rights, re-launching as administrator...
	goto elevateSelf
)
:elevateSelf
set targetprog=debloatGUIDtest.bat
set targetparam=%2
echo Set objShell = CreateObject("Shell.Application") >elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>elevatedapp.vbs
echo objShell.ShellExecute "debloatGUIDtest.bat", "%2", "", "runas" >>elevatedapp.vbs
start "" /WAIT /MIN elevatedapp.vbs
timeout /t 1 /nobreak > nul
DEL elevatedapp.vbs
exit
:guidTest
echo Checking system GUID list...
if NOT EXIST %TEMP%\wmic_dump_temp.txt <NUL WMIC product get identifyingnumber,name,version /all > "%TEMP%\wmic_dump_temp.txt" 2>NUL
type %TEMP%\wmic_dump_temp.txt > %TEMP%\wmic_guid_dump.txt 2>NUL
del %TEMP%\wmic_dump_temp.txt
echo Part 1:  List programs by GUID
echo Comparing system GUID list against blacklisted entries, please wait...
SETLOCAL ENABLEDELAYEDEXPANSION
	for /f "tokens=1" %%a in (%TEMP%\wmic_guid_dump.txt) do (
		for /f "tokens=1" %%j in (%selfDir%\oem\programs_to_target_by_GUID.txt) do (
			if /i %%j==%%a (
				echo %%a MATCH from target list
				)
			)
		)
ENDLOCAL DISABLEDELAYEDEXPANSION
pause
del %TEMP%\wmic_guid_dump.txt