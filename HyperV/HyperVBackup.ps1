##Hyper-V VM Backup Utility
##Checks for list of VMs to back up in local file
##If VM is running, shuts down VM for backup and restarts
$HyperVServerName = 'ChangeMe' ##FQDN of target Hyper-V host
$HyperVBackupDir = 'ChangeMe' ##SMB path to desired backup folder on the Hyper-V Host
$DestinationBackupDir = 'ChangeMe' ##SMB path to destination backup folder. (e.g. \\hostname\e$\HyperV\)
$TargetVMs = (Get-Content 'VMs.txt') ##File in the same directory that contains VM names on separate lines (Names as seen in Get-VM)
$Start = (Get-Date)
$NumberofVMs = ($TargetVMs).count
Write-Host "$NumberofVMs VM to back up."
Write-Host "Removing existing backup data..."
If (not exist $DestinationBackupDir\Backups) { mkdir $DestinationBackupDir\Backups }
ForEach ($folder in Get-ChildItem $DestinationBackupDir\Backups) { Remove-Item -path $DestinationBackupDir\Backups\$folder -recurse }
Write-Host "Done."
Write-Host "Prompting for credentials to initiate Hyper-V connection..."
$Credentials = (Get-Credential)
Write-Host "Conencting to Hyper-V system..."
Write-Host "Beginning backup: $Start"
Enter-PSSession -ComputerName $HyperVServerName -Credential $Credentials
Write-Host "Beginning backup job..."
ForEach ($VM in $TargetVMs) {
$wasrunning = $false
Write-Host "Checking to see if $VM is running..."
if ((Get-VM -Name $VM -ComputerName $HyperVServerName).State -eq "Running") {
Stop-VM -Name $VM -ComputerName $HyperVServerName
$wasrunning = $true
}
Write-Host "Beginning backup of $VM..."
Export-VM -Name $VM -Path $HyperVBackupDir\ -ComputerName $HyperVServerName
$SourcePath = "$HyperVBackupDir\$VM"
robocopy $SourcePath $DestinationBackupDir\Backups\$VM /MIR /NP /ETA
Remove-Item -Recurse $SourcePath
Write-Host "Backup of $VM complete."
if ($wasrunning -eq $true) {
Start-VM -Name $VM -ComputerName $HyperVServerName
}
}
Write-Host "Disconnecting from Hyper-V server."
Exit-PSSession
$End = (Get-Date)
Write-Host "Backup complete. $End"