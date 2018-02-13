###############NewRelic Agent Check###############

get-service 'newrelic-infra' | ? { $_.Status -eq 'Stopped'  } | start-service

################SYSTEM Checks####################

$AVGProc = Get-WmiObject -computername localhost win32_processor |  
Measure-Object -property LoadPercentage -Average | Select Average 
$OS = gwmi -Class win32_operatingsystem -computername localhost | 
Select-Object @{Name = "MemoryUsage"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }} 
$vol = Get-WmiObject -Class win32_Volume -ComputerName localhost -Filter "DriveLetter = 'C:'" | 
Select-object @{Name = "C PercentFree"; Expression = {“{0:N2}” -f  (($_.FreeSpace / $_.Capacity)*100) } } 
$vold = Get-WmiObject -Class win32_Volume -ComputerName localhost -Filter "DriveLetter = 'D:'" | Select-object @{Name = "D PercentFree"; Expression = {“{0:N2}” -f  (($_.FreeSpace / $_.Capacity)*100) } }

$CPULoad = "$($AVGProc.Average)" 
$MemLoad = "$($OS.MemoryUsage)" 
$CDrive = "$($vol.'C PercentFree')" 
$DDrive = "$($vold.'D PercentFree')"
 
$CPULoad  | out-file -filepath "C:\Program Files\New Relic\plugins\system\cpu.txt"  -Encoding Ascii 
$MemLoad | out-file -filepath "C:\Program Files\New Relic\plugins\system\mem.txt"  -Encoding Ascii 
$CDrive | out-file -filepath "C:\Program Files\New Relic\plugins\system\cdrive.txt" -Encoding Ascii 
$DDrive | out-file -filepath "C:\Program Files\New Relic\plugins\system\ddrive.txt" -Encoding Ascii 
$(Get-Process).count | out-file -filepath "C:\Program Files\New Relic\plugins\system\proc.txt" -Encoding Ascii 

#############################C Fragmentation################################
$drive = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter = 'C:'"
$report = $drive.DefragAnalysis()
$report.DefragAnalysis | Select -ExpandProperty FilePercentFragmentation | out-file -filepath "C:\Program Files\New Relic\plugins\system\frag.txt" -Encoding Ascii 

########Windows 2008 R2###########
#$optimize = defrag c:
#If ($report.DefragAnalysis -ge '25') { $optimize
#}
#else { Exit
#}
#
########Windows 2012###########
#$optimize = optimize-volume C -defrag
#If ($report.DefragAnalysis -ge '25') { $optimize
#}
#else { 'no defrag'
#}
##############################Last Reboot###################################
$Lastreboottime = Get-WmiObject win32_operatingsystem | 
select csname, @{LABEL='LastBootUpTime';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

$Today = Get-Date
$DiffDays = $Today.Date - $Lastreboottime.LastBootUpTime.Date

$DiffDays.TotalDays | out-file -filepath "C:\Program Files\New Relic\plugins\system\days.txt" -Encoding Ascii

############################Server IPAddress###################################

$localhostname = (Get-WmiObject -Class Win32_ComputerSystem -Property Name).Name

$ipaddress = Test-Connection -ComputerName ($localhostname) -Count 1 | Select -ExpandProperty IPV4Address | Select -ExpandProperty IPAddressToString | out-file -filepath "C:\Program Files\New Relic\plugins\system\ipaddress.txt" -Encoding Ascii 

############################USER DATA#########################################

Remove-Item –path "C:\Program Files\New Relic\plugins\system\users.txt"
$explorerprocesses = @(Get-WmiObject -Query "Select * FROM Win32_Process WHERE Name='rdpclip.exe'" -ErrorAction SilentlyContinue)
if ($explorerprocesses.Count -eq 0)
{
    "No explorer process found / Nobody interactively logged on" | out-file -filepath "C:\Program Files\New Relic\plugins\system\users.txt" -Encoding Ascii
} else {
    foreach ($i in $explorerprocesses)
    {
        $Username = $i.GetOwner().User
        $Domain = $i.GetOwner().Domain
        $Domain + "\" + $Username + " logged on since: " + ($i.ConvertToDateTime($i.CreationDate)) | out-file -Append -filepath "C:\Program Files\New Relic\plugins\system\users.txt" -Encoding Ascii
    }
}
Get-content "C:\Program Files\New Relic\plugins\system\users.txt" | Measure-Object –Line | Select -ExpandProperty Lines | out-file -filepath "C:\Program Files\New Relic\plugins\system\usersnum.txt" -Encoding Ascii

############################Server STATUS#######################################
[int]$CPULoad = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\cpu.txt' | Get-Content 
[int]$MemLoad = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\mem.txt' | Get-Content
[int]$CDrive = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\cdrive.txt' | Get-Content
[int]$DDrive = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\ddrive.txt' | Get-Content
[int]$proc = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\proc.txt' | Get-Content
[int]$fragmentation = Get-ChildItem 'C:\Program Files\New Relic\plugins\system\frag.txt' | Get-Content
[int]$iisconnections = Get-ChildItem 'C:\Program Files\New Relic\plugins\IISconnections\output.txt' | Get-Content
[int]$wwps = Get-ChildItem 'C:\Program Files\New Relic\plugins\Processes\wwps\output.txt' | Get-Content


If ($CPULoad -gt 90) { 
#$CPULoad
'DEGRADED-CPU-CRITICAL' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
} Elseif ($CPULoad -gt 80) {
'DEGRADED-CPU-WARNING' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
#$CPULoad
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}
If ($MemLoad -gt 90) { 
#$MemLoad
'DEGRADED-MEM-CRITICAL' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
} Elseif ($MemLoad -gt 80) {
'DEGRADED-MEM-WARNING' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}
If ($CDrive -lt 10) { 
#$CDrive
'DEGRADED-CDrive-CRITICAL' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
} Elseif ($CDrive -lt 20) {
'DEGRADED-CDrive-WARNING' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}
If ($proc -gt 120) {
#$proc 
'DEGRADED-PROC-WARNING' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}
######################################### APPLICATION CHECK ##########################################
If ($iisconnections -gt 150) { 
#$iisconnections
'DEGRADED-IISCON-CRITICAL' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
} Elseif ($iisconnections -gt 100) {
'DEGRADED-IISCON-WARNING' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}
If ($wwps -lt 1) {
#$proc
'DEGRADED-WWPS-CRITICAL' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
Exit
}
else { 'OK' | out-file -filepath "C:\Program Files\New Relic\plugins\system\status.txt" -Encoding Ascii
}

