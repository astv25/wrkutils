Windows 10 Initial Setup Utility
One stop shop file that automates common setup tasks on a fresh install of Windows 10.
*Prompts user to disable UAC (technically UAC can be disabled via registry key, but I've seen that result in extremely odd behavior)
*Disables Windows Firewall
*Imports a new default Start Menu layout for newly created users
*Creates Applications folder on Public desktop
*Disables hibernation
*Disables unnecessary services (Xbox, telemetry, etc)
*Sets time zone
*Downloads and installs Chrome
*Disables Chrome Software Reporting tool
*Downloads and installs Adobe Reader DC
*Creats a batch file that:
-Sets default browser to Chrome 
-Sets default PDF application to Adobe Reader DC
--Uses SetUserFTA by Christoph Kolbicz @ kolbi.cz
--Needs to be run after user creation