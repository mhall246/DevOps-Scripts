# PowerShell cmdlet to Restart the SmartSignal.Core.ServerControllerService.exe service
$srvName = "SmartSignal.Core.ServerControllerService.exe"
$servicePrior = Get-Service $srvName
"$srvName is now " + $servicePrior.status
Set-Service $srvName -startuptype manual
Restart-Service $srvName
$serviceAfter = Get-Service $srvName
"$srvName is now " + $serviceAfter.status

Start-Sleep -s 30

# PowerShell cmdlet to Restart the SmartSignal.Core.ServerAgentService.exe service
$srvName = "SmartSignal.Core.ServerAgentService.exe"
$servicePrior = Get-Service $srvName
"$srvName is now " + $servicePrior.status
Set-Service $srvName -startuptype manual
Restart-Service $srvName
$serviceAfter = Get-Service $srvName
"$srvName is now " + $serviceAfter.status

Start-Sleep -s 30

# PowerShell cmdlet to Restart the SscNotificationManagerSvc service
$srvName = "SscNotificationManagerSvc"
$servicePrior = Get-Service $srvName
"$srvName is now " + $servicePrior.status
Set-Service $srvName -startuptype manual
Restart-Service $srvName
$serviceAfter = Get-Service $srvName
"$srvName is now " + $serviceAfter.status