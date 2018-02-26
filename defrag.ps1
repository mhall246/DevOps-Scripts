#############################C Fragmentation################################
$cdrive = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter = 'C:'"
$creport = $cdrive.DefragAnalysis()
#$creport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation | out-file -filepath "C:\Program Files\New Relic\plugins\system\frag.txt" -Encoding Ascii 
$creport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation 
$cfragmentation = $creport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation
#$cfragmentation

#############################C Fragmentation################################
$ddrive = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter = 'D:'"
$dreport = $cdrive.DefragAnalysis()
#$dreport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation | out-file -filepath "C:\Program Files\New Relic\plugins\system\frag.txt" -Encoding Ascii 
$dreport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation 
$dfragmentation = $dreport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation
#$dfragmentation

#############################E Fragmentation################################
$edrive = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter = 'E:'"
$ereport = $edrive.DefragAnalysis()
#$ereport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation | out-file -filepath "C:\Program Files\New Relic\plugins\system\frag.txt" -Encoding Ascii 
$ereport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation 
$efragmentation = $ereport.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation
#$efragmentation

########Windows 2008 R2###########
#$optimize = defrag c:
#If ($fragmentation -ge '25') { $optimize
#}
#else { Exit
#}
#
########Windows 2012###########
$coptimize = optimize-volume C -defrag
If ($cfragmentation -ge '10') { 'no C: defrag'
}
else { $coptimize
}
$doptimize = optimize-volume D -defrag
If ($dfragmentation -ge '10') { 'no D: defrag'
}
else { $doptimize
}
$eoptimize = optimize-volume E -defrag
If ($efragmentation -ge '10') { 'no E: defrag'
}
else { $eoptimize
}
