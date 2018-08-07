@echo off
title ATSi De-Bloat Tool
REM Removes Microsoft and OEM pre-installed applications.
set selfDir=%~dp0
if NOT EXIST %TEMP%\wmic_dump_temp.txt <NUL WMIC product get identifyingnumber,name,version /all > "%TEMP%\wmic_dump_temp.txt" 2>NUL
type %TEMP%\wmic_dump_temp.txt > %TEMP%\wmic_guid_dump.txt 2>NUL
del %TEMP%\wmic_dump_temp.txt
:adminCheck
set /p tmp=Checking for administrator rights...<NUL
net session >nul 2>&1
if %errorlevel%==0 (
	echo Admin rights confirmed
	goto deBloat
) else (
	echo De-Bloat not run with administrator rights, re-launching as administrator...
	goto elevateSelf
)
:elevateSelf
echo Set objShell = CreateObject("Shell.Application") >elevatedapp.vbs
echo Set objWshShell = WScript.CreateObject("WScript.Shell") >>elevatedapp.vbs
echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") >>elevatedapp.vbs
echo objShell.ShellExecute "debloat.bat", "", "", "runas" >>elevatedapp.vbs
start "" /WAIT /MIN elevatedapp.vbs
timeout /t 1 /nobreak > nul
DEL elevatedapp.vbs
exit
:deBloat
echo Part 1:  Remove programs by GUID
echo Comparing system GUID list against blacklisted entries, please wait...
SETLOCAL ENABLEDELAYEDEXPANSION
	for /f "tokens=1" %%a in (%TEMP%\wmic_guid_dump.txt) do (
		for /f "tokens=1" %%j in (%selfDir%\oem\programs_to_target_by_GUID.txt) do (
			if /i %%j==%%a (

				REM Log finding and perform the removal
				echo %%a MATCH from target list, uninstalling...
				start /wait msiexec /qn /norestart /x %%a

				REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but no point really since we're just going to reset it anyway
				REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

				REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
				REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
				if !errorlevel!==0 (
					echo Offending GUID: %%i
					REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations
					REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
				)
			)
		)
	)
ENDLOCAL DISABLEDELAYEDEXPANSION
echo Part 2:  Remove toolbars by GUID
echo Comparing system GUID list against blacklisted entries, please wait...
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "tokens=1" %%a in (%TEMP%\wmic_guid_dump.txt) do (
		for /f "tokens=1" %%j in (%selfDir%\oem\toolbars_BHOs_to_target_by_GUID.txt) do (
			if /i %%j==%%a (

				REM Log finding and perform the removal
				echo %%a MATCH from target list, uninstalling...
				start /wait msiexec /qn /norestart /x %%a

				REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but no point really since we're just going to reset it anyway
				REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

				REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
				REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
				if !errorlevel!==0 (
					echo Offending GUID: %%i
					REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations
					REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
				)
			)
		)
	)
ENDLOCAL DISABLEDELAYEDEXPANSION
echo Part 3:  Remove programs by name (with wildcard)
setlocal EnableExtensions EnableDelayedExpansion
echo Looking for:
	REM Loop through the file...
	for /f %%i in (%selfDir%\oem\programs_to_target_by_name.txt) do (
		REM Do the removal
		echo    %%i
		<NUL "WMIC" product where "name like '%%i'" uninstall /nointeractive >nul 2>&1
		REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
		REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
		if !errorlevel!==0 (
			echo Offending GUID: %%i
			REG query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations
			REG delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
		)	
		)
endlocal DisabledDelayedExpansion
echo Part 4:  Remove Windows 10 Metro apps
start /wait powershell Set-ExecutionPolicy bypass
start /wait powershell -file ".\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1"
start /wait powershell -file ".\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1"
echo Part 5:  Remove OneDrive
start "" /WAIT taskkill /f /im OneDrive.exe
if EXIST %SystemRoot%\System32\OneDriveSetup.exe (
	start "" /WAIT %SystemRoot%\System32\OneDriveSetup.exe /uninstall
)
if EXIST %SystemRoot%\SysWOW64\OneDriveSetup.exe (
	start "" /WAIT %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
)
takeown /f "%LocalAppData%\Microsoft\OneDrive" /r /d y
icacls "%LocalAppData%\Microsoft\OneDrive" /grant administrators:F /t
rmdir /s /q "%LocalAppData%\Microsoft\OneDrive"
rmdir /s /q "%ProgramData%\Microsoft OneDrive"
rmdir /s /q "%SystemDrive%\OneDriveTemp"
REM These two registry entries disable OneDrive links in the Explorer side pane
REG add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f
REG add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f
del %TEMP%\wmic_guid_dump.txt
pause