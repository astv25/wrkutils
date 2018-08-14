@echo off
title Shell Elevation Tool
REM Variables below not used; for usage reference
set targetprog=%1
set targetparam=%2
REM Clean up in case of a previous dirty exit
if EXIST eleatedapp.vbs del /q elevatedapp.vbs
echo Set objShell = CreateObject("Shell.Application") >elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>elevatedapp.vbs
echo objShell.ShellExecute "%1", "%2", "", "runas" >>elevatedapp.vbs
start "" /WAIT /MIN elevatedapp.vbs
::timeout /t 1 /nobreak > nul Technically not needed due to /WAIT being used above
DEL /q elevatedapp.vbs
exit