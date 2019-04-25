@echo off
title Hyper-V Hypervisor Toggle
for /f "tokens=2" %%i in ('bcdedit /enum ^| findstr "Off Auto"') do set tvar="%%i"
if %tvar%=="Off" ( bcdedit /set hypervisorlaunchtype Auto )
if %tvar%=="Auto" ( bcdedit /set hypervisorlaunchtype Off )
shutdown -r -t 0