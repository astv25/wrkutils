@echo off
title ATSi Cleanup Utility
:adminCheck
set /p tmp=Checking for administrator rights...<NUL
net session >nul 2>&1
if %errorlevel%==0 (
	echo Admin rights confirmed.
	goto osDetect
) else (
	echo Utility not run with administrator rights, relaunching as administrator...
	goto elevateSelf
)
:elevateSelf
echo Set objShell = CreateObject("Shell.Application") >elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>elevatedapp.vbs
echo objShell.ShellExecute "MultiOSCleanup.bat", "", "", "runas" >>elevatedapp.vbs
start "" /WAIT /MIN elevatedapp.vbs
timeout /t 1 /nobreak > nul
DEL elevatedapp.vbs
exit
:osDetect
echo Detecting operating system...
ver | findstr /i "5\.1" > nul
if %ERRORLEVEL% EQU 0 goto winXP
ver | findstr /i "6\.1" > nul
if %ERRORLEVEL% EQU 0 goto win7
ver | findstr /i "10\.0" > nul
if %ERRORLEVEL% EQU 0 goto win10
goto end
:winXP
echo OS is Windows XP
echo Cleaning...
C:
rd /s /q "C:\recycler\"
del /s /q "C:\winnt\Downloaded Program Files\*"
cd "C:\Documents and Settings\"
for /d %%F in (*) do del /s /q "%F\Local Settings\Temporary Internet Files\*"
for /d %%F in (*) do del /s /q "%F\Local Settings\Temp\*"
cd C:\
del /s /q "%AllUsersProfile%\Application Data\Microsoft\Dr Watson\*"
del /s /q "%Windir%\minidump\*"
del /q %SystemRoot%\MEMORY.dmp
del /s /q "%windir%\kb*.log"
del /s /q "%windir%\setup*.log"
del /s /q "%windir%\setup*.old"
del /s /q "%windir%\setuplog.txt"
del /s /q "%windir%\winnt32.log"
del /s /q "%windir%\set*.tmp"
del /s /q "%windir%\SoftwareDistribution\*"
echo Cleanup complete.
goto end
:win7
echo OS is Windows 7
echo Cleaning...
C:
rd /s /q C:\$RECYCLE.BIN\
del /s /q C:\Windows\Temp\*
sc stop wuauserv
sc stop bits
del /s /q C:\Windows\SoftwareDistribution\*
sc start bits
sc start wuauserv
del /s /q C:\temp\*
cd C:\Users
for /d %%F in (*) do del /s /q "%F\AppData\Local\Temp\*"
for /d %%F in (*) do del /s /q "%F\AppData\Local\Microsoft\Windows\Temporary Internet Files\*"
for /d %%F in (*) do del /s /q "%F\AppData\Local\Google\Chrome\User Data\Default\Cache\*"
del /s /q "%windir%\minidump\*"
del /q %systemroot%\MEMORY.dmp
echo Cleanup complete.
goto end
:win10
echo OS is Windows 10
echo Cleaning...
C:
del /s /q C:\temp\*
del /s /q C:\Windows\Temp\*
del /s /q C:\Windows\SoftwareDistribution\*
del /s /q C:\Windows\minidump\*
del /q C:\Windows\MEMORY.dmp
cd C:\Users
for /d %%F in (*) do del /s /q "%%F\AppData\Local\Temp\*"
for /d %%F in (*) do del /s /q "%%F\AppData\Local\Microsoft\Windows\Temporary Internet Files\*"
for /d %%F in (*) do del /s /q "%%F\AppData\Local\Microsoft\Windows\INetCache\IE\*"
for /d %%F in (*) do del /s /q "%%F\AppData\Local\Google\Chrome\User Data\Default\Cache\*"
echo Cleanup complete.
goto end
:end
goto :eof