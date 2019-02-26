@echo off
start "" /WAIT powershell -Command "Import-StartLayout -MountPath C:\ -LayoutPath E:\Git\wrkutils\W10_Setup\TEMP\StartLayout.xml"
timeout /t 2 /nobreak > nul
exit
