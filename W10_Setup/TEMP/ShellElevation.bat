@echo off
set targetprog=%1
set targetparam=%2
echo Set objShell = CreateObject("Shell.Application") >TEMP\elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>TEMP\elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>TEMP\elevatedapp.vbs
echo objShell.ShellExecute "%1", "%2", "", "runas" >>TEMP\elevatedapp.vbs
start "" /MIN TEMP\elevatedapp.vbs
timeout /t 1 /nobreak > nul
DEL TEMP\elevatedapp.vbs
exit
