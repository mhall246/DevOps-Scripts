get-service 'SscNotificationManagerSvc' | ? { $_.Status -eq 'Stopped'  } | start-service

get-service 'SmartSignal.Core.ServerAgentService.exe' | ? { $_.Status -eq 'Stopped'  } | start-service

get-service 'SmartSignal.Core.ServerControllerService.exe' | ? { $_.Status -eq 'Stopped'  } | start-service

exit