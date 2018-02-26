get-service 'SscNotificationManagerSvc' | ? { $_.Status -eq 'Stopped'  } | start-service

get-service 'SmartSignal.Core.ServerAgentService.exe' | ? { $_.Status -eq 'Stopped'  } | start-service

get-service 'SmartSignal.Core.ServerControllerService.exe' | ? { $_.Status -eq 'Stopped'  } | start-service

$Prog = "C:\Program Files (x86)\SmartSignal\SmartSignal Engine Agent\SmartSignal.Core.HistoricalDataCollector.exe"
$Running = Get-Process -Name SmartSignal.Core.HistoricalDataCollector -ErrorAction SilentlyContinue
$Start = {([wmiclass]"win32_process").Create($Prog)} 
if($Running -eq $null) # evaluating if the program is running
{& $Start} # the process is created on this line

exit