$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\temptrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\sstrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totaltrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\write transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\tempwritetrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\write transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\sswritetrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\write transactions/sec" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totalwritetrans.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\data file(s) size (kb)" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\tempfilesize.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\data file(s) size (kb)" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\ssfilesize.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\data file(s) size (kb)" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totalfilesize.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\percent log used" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\templogused.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\percent log used" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\sslogused.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\percent log used" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totallogused.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\log cache hit ratio" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\templogcache.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\log cache hit ratio" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\sslogcache.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\log cache hit ratio" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totallogcache.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(tempdb)\active transactions" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\tempactivetransactions.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(smartsignal)\active transactions" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\ssactivetransactions.txt" -Encoding Ascii
$a = Get-Counter -Counter "\SQLServer:databases(_total)\active transactions" | Foreach-Object {$_.CounterSamples[0].CookedValue}; [math]::Round($a) | out-file -filepath "C:\Program Files\New Relic\plugins\sql\totalactivetransactions.txt" -Encoding Ascii