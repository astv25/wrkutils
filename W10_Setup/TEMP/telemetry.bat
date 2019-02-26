@echo off
echo Removing bad updates...
start /wait "" wusa /uninstall /kb:2902907 /norestart /quiet
start /wait "" wusa /uninstall /kb:2922324 /norestart /quiet
start /wait "" wusa /uninstall /kb:2952664 /norestart /quiet
start /wait "" wusa /uninstall /kb:2976978 /norestart /quiet
start /wait "" wusa /uninstall /kb:2977759 /norestart /quiet
start /wait "" wusa /uninstall /kb:2990214 /norestart /quiet
start /wait "" wusa /uninstall /kb:3012973 /norestart /quiet
start /wait "" wusa /uninstall /kb:3014460 /norestart /quiet
start /wait "" wusa /uninstall /kb:3015249 /norestart /quiet
start /wait "" wusa /uninstall /kb:3021917 /norestart /quiet
start /wait "" wusa /uninstall /kb:3022345 /norestart /quiet
start /wait "" wusa /uninstall /kb:3035583 /norestart /quiet
start /wait "" wusa /uninstall /kb:3044374 /norestart /quiet
start /wait "" wusa /uninstall /kb:3050265 /norestart /quiet
start /wait "" wusa /uninstall /kb:3050267 /norestart /quiet
start /wait "" wusa /uninstall /kb:3065987 /norestart /quiet
start /wait "" wusa /uninstall /kb:3068708 /norestart /quiet
start /wait "" wusa /uninstall /kb:3075249 /norestart /quiet
start /wait "" wusa /uninstall /kb:3075851 /norestart /quiet
start /wait "" wusa /uninstall /kb:3075853 /norestart /quiet
start /wait "" wusa /uninstall /kb:3080149 /norestart /quiet
start /wait "" wusa /uninstall /kb:2976987 /norestart /quiet
start /wait "" wusa /uninstall /kb:3068707 /norestart /quiet
echo Disabling telemetry scheduled tasks...
schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy"
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks"
schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
schtasks /delete /f /tn "\Microsoft\Windows\application experience\Microsoft compatibility appraiser"
schtasks /delete /f /tn "\Microsoft\Windows\application experience\aitagent"
schtasks /delete /f /tn "\Microsoft\Windows\application experience\programdataupdater"
schtasks /delete /f /tn "\Microsoft\Windows\autochk\proxy"
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\consolidator"
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\kernelceiptask"
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\usbceip"
schtasks /delete /f /tn "\Microsoft\Windows\diskdiagnostic\Microsoft-Windows-diskdiagnosticdatacollector"
schtasks /delete /f /tn "\Microsoft\Windows\maintenance\winsat"
schtasks /delete /f /tn "\Microsoft\Windows\media center\activateWindowssearch"
schtasks /delete /f /tn "\Microsoft\Windows\media center\configureinternettimeservice"
schtasks /delete /f /tn "\Microsoft\Windows\media center\dispatchrecoverytasks"
schtasks /delete /f /tn "\Microsoft\Windows\media center\ehdrminit"
schtasks /delete /f /tn "\Microsoft\Windows\media center\installplayready"
schtasks /delete /f /tn "\Microsoft\Windows\media center\mcupdate"
schtasks /delete /f /tn "\Microsoft\Windows\media center\mediacenterrecoverytask"
schtasks /delete /f /tn "\Microsoft\Windows\media center\objectstorerecoverytask"
schtasks /delete /f /tn "\Microsoft\Windows\media center\ocuractivate"
schtasks /delete /f /tn "\Microsoft\Windows\media center\ocurdiscovery"
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscovery">nul 2>&
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw1"
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw2"
schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrrecoverytask"
schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrscheduletask"
schtasks /delete /f /tn "\Microsoft\Windows\media center\registersearch"
schtasks /delete /f /tn "\Microsoft\Windows\media center\reindexsearchroot"
schtasks /delete /f /tn "\Microsoft\Windows\media center\sqlliterecoverytask"
schtasks /delete /f /tn "\Microsoft\Windows\media center\updaterecordpath"
echo Disabling M$ Telemetry registry keys...
REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REG add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
REG add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f
REG add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f
REG add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f
REG add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f
REG add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f
REG add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
REG add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f
REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
REG add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
Blocking telemetry host addresses...
route -p add 204.79.197.200/32 0.0.0.0
route -p add 23.218.212.69/32 0.0.0.0
route -p add 204.160.124.125/32 0.0.0.0
route -p add 8.253.14.126/32 0.0.0.0
route -p add 8.254.25.126/32 0.0.0.0
route -p add 93.184.215.200/32 0.0.0.0
route -p add 198.78.194.252/32 0.0.0.0
route -p add 198.78.209.253/32 0.0.0.0
route -p add 8.254.23.254/32 0.0.0.0
route -p add 131.253.14.76/32 0.0.0.0
route -p add 23.201.58.73/32 0.0.0.0
route -p add 204.160.124.125/32 0.0.0.0
route -p add 8.253.14.126/32 0.0.0.0
route -p add 8.254.25.126/32 0.0.0.0
route -p add 191.236.16.12/32 0.0.0.0
route -p add 157.56.91.82/32 0.0.0.0
route -p add 23.61.72.70/32 0.0.0.0
route -p add 204.160.124.125/32 0.0.0.0
route -p add 8.253.14.126/32 0.0.0.0
route -p add 8.254.25.126/32 0.0.0.0
route -p add 93.184.215.200/32 0.0.0.0
route -p add 65.52.100.7/32 0.0.0.0
route -p add 207.46.202.114/32 0.0.0.0
route -p add 65.55.252.63/32 0.0.0.0
route -p add 65.55.252.63/32 0.0.0.0
route -p add 204.79.197.200/32 0.0.0.0
route -p add 65.52.100.91/32 0.0.0.0
route -p add 104.79.156.195/32 0.0.0.0
route -p add 65.52.100.92/32 0.0.0.0
route -p add 65.55.44.108/32 0.0.0.0
route -p add 157.56.106.210/32 0.0.0.0
route -p add 168.62.11.145/32 0.0.0.0
route -p add 23.96.212.225/32 0.0.0.0
route -p add 23.96.212.225/32 0.0.0.0
route -p add 65.52.100.94/32 0.0.0.0
route -p add 65.55.252.93/32 0.0.0.0
route -p add 65.55.252.93/32 0.0.0.0
route -p add 134.170.115.60/32 0.0.0.0
route -p add 207.46.114.61/32 0.0.0.0
route -p add 65.52.108.153/32 0.0.0.0
route -p add 64.4.54.22/32 0.0.0.0
route -p add 65.55.252.92/32 0.0.0.0
route -p add 65.55.252.92/32 0.0.0.0
route -p add 168.62.187.13/32 0.0.0.0
route -p add 65.52.100.9/32 0.0.0.0
route -p add 131.253.40.37/32 0.0.0.0
route -p add 64.4.54.254/32 0.0.0.0
route -p add 64.4.54.32/32 0.0.0.0
route -p add 64.4.54.254/32 0.0.0.0
route -p add 207.46.223.94/32 0.0.0.0
route -p add 65.55.252.71/32 0.0.0.0
route -p add 65.52.100.11/32 0.0.0.0
route -p add 65.52.108.29/32 0.0.0.0
route -p add 65.52.108.29/32 0.0.0.0
route -p add 65.52.100.93/32 0.0.0.0
Snooping disabled.
timeout /t 1 /nobreak>nul
exit
