@echo off
title HP/CONEXTANT "Flow" Disable Utility
echo This utility will prevent the Flow subcomponent of HP/Conextant audio drivers from running.
echo Flow has been reported to cause issues with freezing, program hangs during alt+tab, and high resource consumption.
echo -------------------------------
echo Tasks to be preformed:
echo *Disable CxAudioSvc
echo *Disable CxUtilSvc
echo *Rename Flow executable
echo *Rename AppFollower executable
echo -------------------------------
pause
:checkAdmin
set /p tmp=Checking for administrator rights...<NUL
net session>nul 2>&1
if %errorlevel%==0 (
	echo Admin rights confirmed.  Proceeding.
	goto killFlow
) else (
	echo No admin rights detected, relaunching as administrator.
	goto elevateSelf
)
:elevateSelf
echo Set objShell = CreateObject("Shell.Application") >elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>elevatedapp.vbs
echo objShell.ShellExecute "KillFlow.bat", "", "", "runas" >>elevatedapp.vbs
start "" /WAIT /MIN elevatedapp.vbs
timeout /t 1 /nobreak > nul
DEL elevatedapp.vbs
exit
:killFlow
echo Stopping services...
sc stop CxAudioSvc
sc config CxAudioSvc start= Disabled
sc stop CxUtilSvc
sc config CxUtilSvc start= Disabled
echo Renaming Flow executables...
if EXIST "C:\Program Files\CONEXTANT\Flow" (
	pushd "C:\Program Files\CONEXTANT\Flow"
	taskkill /f /im Flow.exe
	taskkill /f /im AppFollower.exe
	ren Flow.exe _Flow.exe
	ren AppFollower.exe _AppFollower.exe
) else (
	echo Flow does not appear to be present on this system.
)
exit
