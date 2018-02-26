$a = Get-Counter "\Process(SmartSignal.Core.ServerAgentService*)\% Processor Time"
[math]::Round($a)

PowerShell
1
Get-Process -Name "SmartSignal.Core.ServerAgentService" | Select -ExpandProperty Name "SmartSignal.Core.ServerAgentService"

$a = Get-Counter "\Process(SmartSignal.Core.ServerAgentService*)\% Processor Time" | Select -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue
[math]::Round($Samples)

Get-Process | Where-Object { $_.Name -eq "SmartSignal.Core.ServerAgentService" }

$ProcessName = "SmartSignal.Core.ServerAgentService"
 
$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$Samples = (Get-Counter "\Process($Processname*)\% Processor Time").CounterSamples
$Samples | Select InstanceName, @{Name="CPU %";Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 8)}} | Select -ExpandProperty "CPU %"
$a = $Sample
[math]::Round($a)