$Source  = hostname
$Target = 10.42.185.60
Test-Connection -Source $source -ComputerName 10.42.185.60 | Measure-Object ResponseTime -Maximum -minimum | select @{name='Latency';expression={$_.Maximum}} | Select Latency -ExpandProperty Latency | out-file -filepath "C:\Program Files\New Relic\plugins\Latency\db.txt" -Encoding Ascii