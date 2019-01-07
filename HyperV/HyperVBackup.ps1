##Hyper-V VM Backup Utility
##Checks for list of VMs to back up in local file
##If VM is running, shuts down VM for backup and restarts
$HyperVServerName = 'CHANGEME' ##DNS Name of target Hyper-V host
$BackupDir = 'CHANGEME' ##Full file path with drive letter to desired backup folder
$VMdrive = 'CHANGEME' ##Drive letter of Hyper-V host where VMs are stored (e.g. $VMdrive = 'd$')
$TargetVMs = (Get-Content 'VMs.txt')
$Start = (Get-Date)
$NumberofVMs = ($TargetVMs).count
Write-Host "$NumberofVMs VM to back up."
Write-Host "Removing existing backup data..."
Remove-Item -Path . -Include *.txt
ForEach ($folder in Get-ChildItem $PSScriptRoot\Backups) { Remove-Item -path $PSScriptRoot\Backups\$folder -recurse }
Write-Host "Done."
Write-Host "Prompting for credentials to initiate Hyper-V connection..."
$Credentials = (Get-Credential)
Write-Host "Conencting to Hyper-V system..."
Write-Host "Beginning backup job..."
ForEach ($VM in $TargetVMs) {
$wasrunning = $false
Write-Host "Checking to see if $VM is running..."
if ((Get-VM -Name $VM -ComputerName $HyperVServerName).State -eq "Running") {
Stop-VM -Name $VM -ComputerName $HyperVServerName
$wasrunning = $true
}
Write-Host "Beginning backup of $VM..."
Write-Host "Getting $VM storage location..."
$TempVM = Get-VM -Name $VM -ComputerName $HyperVServerName
$TempPath = (Split-Path -Path $TempVM.Path -NoQualifier)
$SourcePath = "\\$HyperVServerName\$VMDrive$TempPath"
robocopy $SourcePath $BackupDir\$VM /MIR /NP /ETA
Write-Host "Backup of $VM complete."
if ($wasrunning -eq $true) {
Start-VM -Name $VM -ComputerName $HyperVServerName
}
}
Write-Host "Disconnecting from Hyper-V server."
Write-Host "Backup complete. $Start"