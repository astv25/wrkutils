##Hyper-V Single VM Remote Start/Shutdown Utility
##Connects to specified Hyper-V host to start/shutdown specified VM
##Requires CredSSP to be enabled on both client and server
$targetvm = 'changeme'  ##Name of VM on hyper-v system
$targetserver = 'changeme' ##DNS name of hyper-v server
Write-Host "Connecting to $targetserver..."
Write-Host "Prompting for connection credentials..."
$Credentials = (Get-Credential)
Write-Host "Getting status of $targetvm..."
if ((Get-VM -Name $targetvm -ComputerName $targetserver -Credential $Credentials).State -eq "Running") {
Write-Host "$targetvm is running.  Shutting down $targetvm..."
Stop-VM -Name $targetvm -ComputerName $targetserver -Credential $Credentials }
elseif ((Get-VM -Name $targetvm -ComputerName $targetserver -Credential $Credentials).State -eq "Off") {
Write-Host "$targetvm is not running.  Starting $targetvm..."
Start-VM -Name $targetvm -ComputerName $targetserver -Credential $Credentials }
Pause