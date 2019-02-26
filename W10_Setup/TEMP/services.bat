@echo off
for /f %%G in (E:\Git\wrkutils\W10_Setup\TEMP\services.txt) do (
echo Disabling %%G
sc stop %%G
sc config %%G start= disabled
)
timeout /t 2 /nobreak > nul
exit
