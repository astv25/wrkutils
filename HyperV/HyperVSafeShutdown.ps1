##Hyper-V Shutdown Helper
##Uses Hyper-V Powershell module to save or shut down all VMs before shutting down/rebooting physical server host
$saveVM = $false ##If false, shuts VMs down
$rebootHost = $false ##If false, shuts host down
Write-Host "Save virtual machine states or shut virtual machines down? (Default is Shut Down)"
$ReadHost = Read-Host "( save / shut )"
Switch ($ReadHost)
    {
        SAVE {Write-Host "Saving VMs..."; $saveVM = $true}
        SHUT {Write-Host "Shutting down VMs..."; $saveVM = $false}
        Default {Write-Host "Defaulting to VM shutdown..."; $saveVM = $false}
    }
Write-Host "Reboot physical host or shut down? (Default is Shut Down)"
$ReadHost = Read-Host "( r / s )"
Switch ($ReadHost)
    {
        R {Write-Host "Rebooting host..."; $rebootHost = $true}
        S {Write-Host "Shutting down host..."; $rebootHost = $false}
        Default {Write-Host "Defaulting to host shutdown..."; $rebootHost = $false}
    }
Write-Host "Beginning poweroff.  Save VMs: "$saveVM " Reboot host: "$rebootHost
Switch ($saveVM)
    {
        $false {Write-Host "Beginning VM shutdown..."; Get-VM | Stop-VM}
        $true {Write-Host "Beginning VM saving, this will take some time..."; Get-VM | Save-VM}
        Default {Write-Host "Script exception has occurred, exiting! saveVM variable at unhandled value: "$saveVM; exit}
    }
Write-Host "VM handling complete."
Switch ($rebootHost)
    {
        $false {Write-Host "Shutting down host server..."; Stop-Computer}
        $true {Write-Host "Restarting host server..."; Restart-Computer}
        Default {Write-Host "Script exception has occurred, exiting! rebootHost variable at unhandled value: "$rebootHost; exit}
    }
Write-Host "Host server handling complete."
Write-Host "Goodbye."
