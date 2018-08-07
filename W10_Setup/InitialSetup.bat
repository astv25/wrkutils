@echo off
REM This utility is a self contained tool that:
REM *Disables services that are unnecessary and/or provide Microsoft with user/system telemetry
REM *Sets Windows (Defender) Firewall to disabled for the Domain, Private, and Public profiles
REM *Imports a default layout for the Start Menu that only includes basic Windows 10 apps (news, mail, weather) and shortcuts for Microsoft Office 2007 applications
REM **This layout only takes effect on newly created user profiles, the current profile is unaffected
REM *Creates a folder on the public desktop named Applications and grants all users full rights to said folder
REM *Disables hibernation
REM Minimal user interaction is required during runtime.  Once the user has disabled User Account Control, the utility is autonomous.
REM All necessary components are created in a temporary folder prior to prompting the user to disable UAC.  These components are designed to be invoked by this utility and may behave
REM unexpectedly if run separately.
title Windows 10 Initial Configuration Utility
echo Preforming initial setup tasks...
mkdir TEMP
echo ALG>TEMP\services.txt
echo PeerDistSvc>>TEMP\services.txt
echo NfsClient>>TEMP\services.txt
echo dmwappushsvc>>TEMP\services.txt
echo MapsBroker>>TEMP\services.txt
echo Ifsvc>>TEMP\services.txt
echo HvHost>>TEMP\services.txt
echo irmon>>TEMP\services.txt
echo SharedAccess>>TEMP\services.txt
echo MSiSCSI>>TEMP\services.txt
echo SmsRouter>>TEMP\services.txt
echo CscService>>TEMP\services.txt
echo WpcMonSvc>>TEMP\services.txt
echo SEMgrSvc>>TEMP\services.txt
echo PhoneSvc>>TEMP\services.txt
echo RpcLocator>>TEMP\services.txt
echo RetailDemo>>TEMP\services.txt
echo SensorDataService>>TEMP\services.txt
echo SensrSvc>>TEMP\services.txt
echo SensorService>>TEMP\services.txt
echo ScDeviceEnum>>TEMP\services.txt
echo SCPolicySvc>>TEMP\services.txt
echo SNMPTRAP>>TEMP\services.txt
echo TabletInputService>>TEMP\services.txt
echo WFDSConSvc>>TEMP\services.txt
echo FrameServer>>TEMP\services.txt
echo wisvc>>TEMP\services.txt
echo icssvc>>TEMP\services.txt
echo Wwansvc>>TEMP\services.txt
echo XblAuthManager>>TEMP\services.txt
echo XblGameSave>>TEMP\services.txt
echo XboxNetApiSvc>>TEMP\services.txt
echo WMPNetworkSvc>>TEMP\services.txt
echo @echo off>TEMP\ShellElevation.bat
echo set targetprog=%%1>>TEMP\ShellElevation.bat
echo set targetparam=%%2>>TEMP\ShellElevation.bat
echo echo Set objShell = CreateObject("Shell.Application") ^>elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo Set objWshShell = WScript.CreateObject("WScript.Shell") ^>^>elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") ^>^>elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo objShell.ShellExecute "%%1", "%%2", "", "runas" ^>^>elevatedapp.vbs>>TEMP\ShellElevation.bat
echo start "" /MIN elevatedapp.vbs>>TEMP\ShellElevation.bat
echo timeout /t 1 /nobreak ^> nul>>TEMP\ShellElevation.bat
echo DEL elevatedapp.vbs>>TEMP\ShellElevation.bat
echo exit>>TEMP\ShellElevation.bat
echo @echo off>TEMP\services.bat
echo for /f %%%%G in (%cd%\TEMP\services.txt) do (>>TEMP\services.bat
echo echo Disabling %%%%G>>TEMP\services.bat
echo sc stop %%%%G>>TEMP\services.bat
echo sc config %%%%G start= disabled>>TEMP\services.bat
echo )>>TEMP\services.bat
echo timeout /t 2 /nobreak ^> nul>>TEMP\services.bat
echo exit>>TEMP\services.bat
echo @echo off>TEMP\firewall.bat
echo echo Initial state of Windows Firewall:>>TEMP\firewall.bat
echo netsh advfirewall show allprofiles ^| findstr "State Profile">>TEMP\firewall.bat
echo echo Disabling...>>TEMP\firewall.bat
echo netsh advfirewall set allprofiles state off>>TEMP\firewall.bat
echo echo Current state of Windows Firewall:>>TEMP\firewall.bat
echo netsh advfirewall show allprofiles ^| findstr "State Profile">>TEMP\firewall.bat
echo timeout /t 2 /nobreak ^> nul>>TEMP\firewall.bat
echo exit>>TEMP\firewall.bat
echo ^<LayoutModificationTemplate Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification"^> >TEMP\StartLayout.xml
echo  ^<LayoutOptions StartTileGroupCellWidth="6" /^> >>TEMP\StartLayout.xml
echo   ^<DefaultLayoutOverride^> >>TEMP\StartLayout.xml
echo     ^<StartLayoutCollection^> >>TEMP\StartLayout.xml
echo       ^<defaultlayout:StartLayout GroupCellWidth="6" xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"^> >>TEMP\StartLayout.xml
echo         ^<start:Group Name="Life at a glance" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout"^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="0" Row="0" AppUserModelID="microsoft.windowscommunicationsapps_8wekyb3d8bbwe!microsoft.windowslive.calendar" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="0" Row="2" AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="2" Row="2" AppUserModelID="Microsoft.Windows.Photos_8wekyb3d8bbwe!App" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="4" Row="2" AppUserModelID="Microsoft.Windows.Cortana_cw5n1h2txyewy!CortanaUI" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="0" Row="4" AppUserModelID="Microsoft.BingWeather_8wekyb3d8bbwe!App" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="4x2" Column="2" Row="0" AppUserModelID="Microsoft.BingNews_8wekyb3d8bbwe!AppexNews" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="2" Row="4" AppUserModelID="Microsoft.ZuneMusic_8wekyb3d8bbwe!Microsoft.ZuneMusic" /^> >>TEMP\StartLayout.xml
echo           ^<start:Tile Size="2x2" Column="4" Row="4" AppUserModelID="Microsoft.ZuneVideo_8wekyb3d8bbwe!Microsoft.ZuneVideo" /^> >>TEMP\StartLayout.xml
echo           ^<start:DesktopApplicationTile Size="2x2" Column="0" Row="6" DesktopApplicationID="{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\Microsoft Office\Office14\EXCEL.EXE" /^> >>TEMP\StartLayout.xml
echo           ^<start:DesktopApplicationTile Size="2x2" Column="2" Row="6" DesktopApplicationID="{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\Microsoft Office\Office14\OUTLOOK.EXE" /^> >>TEMP\StartLayout.xml
echo           ^<start:DesktopApplicationTile Size="2x2" Column="4" Row="6" DesktopApplicationID="{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\Microsoft Office\Office14\POWERPNT.EXE" /^> >>TEMP\StartLayout.xml
echo           ^<start:DesktopApplicationTile Size="2x2" Column="0" Row="8" DesktopApplicationID="{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\Microsoft Office\Office14\WINWORD.EXE" /^> >>TEMP\StartLayout.xml
echo         ^</start:Group^> >>TEMP\StartLayout.xml
echo       ^</defaultlayout:StartLayout^> >>TEMP\StartLayout.xml
echo     ^</StartLayoutCollection^> >>TEMP\StartLayout.xml
echo   ^</DefaultLayoutOverride^> >>TEMP\StartLayout.xml
echo ^</LayoutModificationTemplate^> >>TEMP\StartLayout.xml
echo @echo off>TEMP\startmenu.bat
echo powershell -Command "Import-StartLayout -MountPath C:\ -LayoutPath %cd%\TEMP\StartLayout.xml">>TEMP\startmenu.bat
echo timeout /t 2 /nobreak ^> nul>>TEMP\startmenu.bat
echo exit>>TEMP\startmenu.bat
echo @echo off>TEMP\appfolder.bat
echo mkdir C:\Users\Public\Desktop\Applications>>TEMP\appfolder.bat
echo icacls C:\Users\Public\Desktop\Applications /grant Everyone:(OI)(CI)F /t>>TEMP\appfolder.bat
echo timeout /t 2 /nobreak ^> nul>>TEMP\appfolder.bat
echo exit>>TEMP\appfolder.bat
echo @echo off>TEMP\hibernate.bat
echo powercfg /h off>>TEMP\hibernate.bat
echo timeout /t 1 /nobreak ^>nul>>TEMP\hibernate.bat
echo exit>>TEMP\hibernate.bat
echo ^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!
echo ^!^!^!Please disable User Account Control^!^!^!
echo ^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!
start "" /WAIT C:\Windows\system32\UserAccountControlSettings.exe
set /p tmp=Disabling extraneous services...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\services.bat
timeout /t 5 /nobreak >nul
echo Done
set /p tmp=Setting Windows Firewall to Disabled...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\firewall.bat
timeout /t 5 /nobreak >nul
echo Done
set /p tmp=Setting default layout for Start Menu...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\startmenu.bat
timeout /t 15 /nobreak >nul
echo Done
set /p tmp=Creating Applications folder on Public desktop...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\appfolder.bat
timeout /t 2 /nobreak >nul
echo Done
set /p tmp=Disabling hibernation...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\hibernate.bat
timeout /t 2 /nobreak >nul
echo Done
set /p tmp=Cleaning up...<NUL
DEL /s /q TEMP\* >nul
RD /q TEMP >nul
echo Done