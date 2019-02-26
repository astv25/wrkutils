@echo off
echo Setting timezone...
tzutil /g
tzutil /s "Central Standard Time"
timeout /t 1 /nobreak>nul
exit
