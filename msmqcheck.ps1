gwmi -class Win32_PerfRawData_MSMQ_MSMQQueue | Measure-Object -Sum MessagesInQueue | Select-Object -ExpandProperty Sum | out-file -filepath "C:\Program Files\New Relic\plugins\MSMQ\output.txt" -Encoding Ascii

Get-Service -Name MSMQ | Select -ExpandProperty Status | out-file -filepath "C:\Program Files\New Relic\plugins\MSMQ\output1.txt" -Encoding Ascii