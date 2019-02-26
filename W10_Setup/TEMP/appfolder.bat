@echo off
mkdir C:\Users\Public\Desktop\Applications
icacls C:\Users\Public\Desktop\Applications /grant Everyone:(OI)(CI)F /t
timeout /t 2 /nobreak > nul
exit
