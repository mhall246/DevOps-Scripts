get-service 'W3SVC' | ? { $_.Status -eq 'Stopped'  } | start-service

get-service 'IISADMIN' | ? { $_.Status -eq 'Stopped'  } | start-service

exit