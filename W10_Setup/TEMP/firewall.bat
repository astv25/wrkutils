@echo off
echo Initial state of Windows Firewall:
netsh advfirewall show allprofiles | findstr "State Profile"
echo Disabling...
netsh advfirewall set allprofiles state off
echo Current state of Windows Firewall:
netsh advfirewall show allprofiles | findstr "State Profile"
timeout /t 2 /nobreak > nul
exit
