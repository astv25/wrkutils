@echo off
REM This utility is a self contained tool that:
REM *Disables services that are unnecessary and/or provide Microsoft with user/system telemetry
REM *Sets Windows (Defender) Firewall to disabled for the Domain, Private, and Public profiles
REM *Imports a default layout for the Start Menu that only includes basic Windows 10 apps (news, mail, weather) and shortcuts for Microsoft Office 2007 applications
REM **This layout only takes effect on newly created user profiles, the current profile is unaffected
REM *Creates a folder on the public desktop named Applications and grants all users full rights to said folder
REM *Disables hibernation
REM *Sets time zone
REM Minimal user interaction is required during runtime.  Once the user has disabled User Account Control, the utility is autonomous.
REM All necessary components are created in a temporary folder prior to prompting the user to disable UAC.  These components are designed to be invoked by this utility and may behave
REM unexpectedly if run separately.
title Windows 10 Initial Configuration Utility
REM Input desired timezone here.  Value will be passed to tzutil.  Acceptable values can be found by running tzutil /l
set timezone="Central Standard Time"
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
echo XboxGipSvc>>TEMP\services.txt
echo xbgm>>TEMP\services.txt
echo WMPNetworkSvc>>TEMP\services.txt
echo Wecsvc>>TEMP\services.txt
echo @echo off>TEMP\ShellElevation.bat
echo set targetprog=%%1>>TEMP\ShellElevation.bat
echo set targetparam=%%2>>TEMP\ShellElevation.bat
echo echo Set objShell = CreateObject("Shell.Application") ^>TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo Set objWshShell = WScript.CreateObject("WScript.Shell") ^>^>TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo Set objWshProcessEnv = objWshShell.Environment("PROCESS") ^>^>TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
echo echo objShell.ShellExecute "%%1", "%%2", "", "runas" ^>^>TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
echo start "" /MIN TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
echo timeout /t 1 /nobreak ^> nul>>TEMP\ShellElevation.bat
echo DEL TEMP\elevatedapp.vbs>>TEMP\ShellElevation.bat
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
echo start "" /WAIT powershell -Command "Import-StartLayout -MountPath C:\ -LayoutPath %cd%\TEMP\StartLayout.xml">>TEMP\startmenu.bat
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
echo @echo off>TEMP\telemetry.bat
echo echo Removing bad updates...>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2902907 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2922324 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2952664 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2976978 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2977759 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2990214 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3012973 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3014460 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3015249 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3021917 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3022345 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3035583 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3044374 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3050265 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3050267 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3065987 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3068708 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3075249 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3075851 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3075853 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3080149 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:2976987 /norestart /quiet>>TEMP\telemetry.bat
echo start /wait "" wusa /uninstall /kb:3068707 /norestart /quiet>>TEMP\telemetry.bat
echo echo Disabling telemetry scheduled tasks...>>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem">>TEMP\telemetry.bat
echo schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\application experience\Microsoft compatibility appraiser">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\application experience\aitagent">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\application experience\programdataupdater">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\autochk\proxy">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\consolidator">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\kernelceiptask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\usbceip">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\diskdiagnostic\Microsoft-Windows-diskdiagnosticdatacollector">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\maintenance\winsat">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\activateWindowssearch">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\configureinternettimeservice">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\dispatchrecoverytasks">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\ehdrminit">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\installplayready">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\mcupdate">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\mediacenterrecoverytask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\objectstorerecoverytask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\ocuractivate">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\ocurdiscovery">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscovery"^>nul 2^>^&1>>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw1">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw2">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrrecoverytask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrscheduletask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\registersearch">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\reindexsearchroot">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\sqlliterecoverytask">>TEMP\telemetry.bat
echo schtasks /delete /f /tn "\Microsoft\Windows\media center\updaterecordpath">>TEMP\telemetry.bat
echo echo Disabling M$ Telemetry registry keys...>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f>>TEMP\telemetry.bat
echo REG add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f>>TEMP\telemetry.bat
echo Blocking telemetry host addresses...>>TEMP\telemetry.bat
echo route -p add 204.79.197.200/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 23.218.212.69/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 204.160.124.125/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.253.14.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.254.25.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 93.184.215.200/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 198.78.194.252/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 198.78.209.253/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.254.23.254/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 131.253.14.76/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 23.201.58.73/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 204.160.124.125/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.253.14.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.254.25.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 191.236.16.12/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 157.56.91.82/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 23.61.72.70/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 204.160.124.125/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.253.14.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 8.254.25.126/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 93.184.215.200/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.7/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 207.46.202.114/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.63/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.63/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 204.79.197.200/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.91/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 104.79.156.195/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.92/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.44.108/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 157.56.106.210/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 168.62.11.145/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 23.96.212.225/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 23.96.212.225/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.94/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.93/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.93/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 134.170.115.60/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 207.46.114.61/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.108.153/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 64.4.54.22/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.92/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.92/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 168.62.187.13/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.9/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 131.253.40.37/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 64.4.54.254/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 64.4.54.32/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 64.4.54.254/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 207.46.223.94/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.55.252.71/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.11/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.108.29/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.108.29/32 0.0.0.0>>TEMP\telemetry.bat
echo route -p add 65.52.100.93/32 0.0.0.0>>TEMP\telemetry.bat
echo Snooping disabled.>>TEMP\telemetry.bat
echo timeout /t 1 /nobreak^>nul>>TEMP\telemetry.bat
echo exit>>TEMP\telemetry.bat
echo @echo off>TEMP\timezone.bat
echo echo Setting timezone...>>TEMP\timezone.bat
echo tzutil /g>>TEMP\timezone.bat
echo tzutil /s %timezone%>>TEMP\timezone.bat
echo timeout /t 1 /nobreak^>nul>>TEMP\timezone.bat
echo exit>>TEMP\timezone.bat
echo !^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!
echo ^!^!^!Please disable User Account Control^!^!^!
echo ^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!^!
start "" /WAIT C:\Windows\system32\UserAccountControlSettings.exe
set /p tmp=Disabling extraneous services...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\services.bat
timeout /t 5 /nobreak >nul
echo Done
set /p tmp=Disabling Windows 10 Snooping...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\telemetry.bat
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
set /p tmp=Setting time zone...<NUL
start "" /WAIT /MIN TEMP\ShellElevation.bat TEMP\timezone.bat
timeout /t 2 /nobreak >nul
echo Done
set /p tmp=Cleaning up...<NUL
DEL /s /q TEMP\* >nul
RD /q TEMP >nul
echo Done