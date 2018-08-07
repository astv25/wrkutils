Shell Elevation Utility
Parameter 1:  target program
Parameter 2:  parameters for target program
Usage:  ShellElevation.bat powershell -file .\script.ps1
		ShellElevation.bat cmd

Presumes user has administrative rights, will either generate a UAC elevation prompt or fail if user does not have administrative rights.