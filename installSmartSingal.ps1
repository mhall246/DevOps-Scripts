#################################################################################################################
#                                                                                                               #
#                                                                                                               #
# Run this code first ----> Set-ExecutionPolicy RemoteSigned                                                    #
#                                                                                                               #
#                                                                                                               #
############################## BASIC SERVER INFORMATION #########################################################

#$hostname =read-host -prompt "enter hostname"
$group =read-host -prompt "enter group(example: EQI, $tree2, $tree1, DELTA, CMS, MT3P….)"
$datacenter =read-host -prompt "enter datacenter(example: AWS, GEIP, CPOD, GEIX….)"
$application ="SmartSignal"
$servertype =read-host -prompt "WHAT servertype OF SERVER IS THIS?(WEB/SQL/APP/GWY/CORE)"
$configFiles = Get-ChildItem 'C:\Program Files\New Relic\plugins' -Recurse -Include *.vbs | Get-Content
$infrainstall =read-host -prompt "Install Infrastructure Client also?(N/Y)"
$windows =read-host -prompt "Is This a Windows 2008 Installation?(N/Y)"
$isproxy =read-host -prompt "Is there a Proxy(N/Y) Hint EQI is (N)"
$username =read-host -prompt "enter user for the plugins to run"
$password =read-host -prompt "enter user password for the plugins to run"
$localhostname = (Get-WmiObject -Class Win32_ComputerSystem -Property Name).Name
$ipaddress = Test-Connection -ComputerName ($localhostname) -Count 1 | Select -ExpandProperty IPV4Address | Select -ExpandProperty IPAddressToString

foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'HOSTNAME', $localhostname } |
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'SITE', $group }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'DATACENTER', $datacenter }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'APPLICATION', $application }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'SERVERTYPE', $servertype }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'IPADDRESS', $ipaddress }|
    Set-Content $file.PSPath
}
################################## SYSTEM TYPE MONITORS ##########################################
'Adding Server status Powershell script'

If ($servertype -eq 'APP') {
 Rename-Item -Path "C:\Program Files\New Relic\plugins\system\system-app.ps1" "C:\Program Files\New Relic\plugins\system\system.ps1";
 $BadFile = Get-Item "C:\Program Files\New Relic\plugins\system\system-web.ps1"
 $BadFile2 = Get-Item "C:\Program Files\New Relic\plugins\system\system-sql.ps1"
 $BadFile3 = Get-Item "C:\Program Files\New Relic\plugins\system\system-gwy.ps1"
 $BadFile4 = Get-Item "C:\Program Files\New Relic\plugins\system\system-core.ps1"
 $BadFile | Remove-Item -force
 $BadFile2 | Remove-Item -force
 $BadFile3 | Remove-Item -force
 $BadFile4 | Remove-Item -force
} Elseif ($servertype -eq 'GWY') {
 Rename-Item -Path "C:\Program Files\New Relic\plugins\system\system-gwy.ps1" "C:\Program Files\New Relic\plugins\system\system.ps1";
 $BadFile = Get-Item "C:\Program Files\New Relic\plugins\system\system-app.ps1"
 $BadFile2 = Get-Item "C:\Program Files\New Relic\plugins\system\system-sql.ps1"
 $BadFile3 = Get-Item "C:\Program Files\New Relic\plugins\system\system-web.ps1"
 $BadFile4 = Get-Item "C:\Program Files\New Relic\plugins\system\system-core.ps1"
 $BadFile | Remove-Item -force
 $BadFile2 | Remove-Item -force
 $BadFile3 | Remove-Item -force
 $BadFile4 | Remove-Item -force
} Elseif ($servertype -eq 'SQL') {
 Rename-Item -Path "C:\Program Files\New Relic\plugins\system\system-sql.ps1" "C:\Program Files\New Relic\plugins\system\system.ps1";
 $BadFile = Get-Item "C:\Program Files\New Relic\plugins\system\system-app.ps1"
 $BadFile2 = Get-Item "C:\Program Files\New Relic\plugins\system\system-web.ps1"
 $BadFile3 = Get-Item "C:\Program Files\New Relic\plugins\system\system-gwy.ps1"
 $BadFile4 = Get-Item "C:\Program Files\New Relic\plugins\system\system-core.ps1"
 $BadFile | Remove-Item -force
 $BadFile2 | Remove-Item -force
 $BadFile3 | Remove-Item -force
 $BadFile4 | Remove-Item -force
} Elseif ($servertype -eq 'WEB') {
 Rename-Item -Path "C:\Program Files\New Relic\plugins\system\system-web.ps1" "C:\Program Files\New Relic\plugins\system\system.ps1";
 $BadFile = Get-Item "C:\Program Files\New Relic\plugins\system\system-app.ps1"
 $BadFile2 = Get-Item "C:\Program Files\New Relic\plugins\system\system-sql.ps1"
 $BadFile3 = Get-Item "C:\Program Files\New Relic\plugins\system\system-gwy.ps1"
 $BadFile4 = Get-Item "C:\Program Files\New Relic\plugins\system\system-core.ps1"
 $BadFile | Remove-Item -force
 $BadFile2 | Remove-Item -force
 $BadFile3 | Remove-Item -force
 $BadFile4 | Remove-Item -force
} Elseif ($servertype -eq 'CORE') {
 Rename-Item -Path "C:\Program Files\New Relic\plugins\system\system-core.ps1" "C:\Program Files\New Relic\plugins\system\system.ps1";
 $BadFile = Get-Item "C:\Program Files\New Relic\plugins\system\system-web.ps1"
 $BadFile2 = Get-Item "C:\Program Files\New Relic\plugins\system\system-sql.ps1"
 $BadFile3 = Get-Item "C:\Program Files\New Relic\plugins\system\system-gwy.ps1"
 $BadFile4 = Get-Item "C:\Program Files\New Relic\plugins\system\system-app.ps1"
 $BadFile | Remove-Item -force
 $BadFile2 | Remove-Item -force
 $BadFile3 | Remove-Item -force
 $BadFile4 | Remove-Item -force
} Else {
  Exit
}

If ($windows -eq 'N') {

#####################################System Monitoring#######################################################
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\system\system.ps1"'),
          (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\system\system.vbs"')

#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR System monitoring" -Action $action -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitor System stats"
Register-ScheduledTask -TaskName "NR System monitoring" -Action $action -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitor System stats"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR System monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

###################################Update Monitoring######################################################
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\WindowsUpdates\WindowsUpdate.ps1"'),
          (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\WindowsUpdates\WindowsUpdateCount.vbs"')

#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR Windows Update Monitoring" -Action $action -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitors for critial updates"
Register-ScheduledTask -TaskName "NR Windows Update Monitoring" -Action $action -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitors for critial updates"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR Windows Update Monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

#start Tasks automatically

schtasks /run /TN "NR System monitoring"`
schtasks /run /TN "NR Windows Update Monitoring"

$starttasks
  } Elseif ($windows -eq 'Y') { 
  'NR Tasks must be manually created'
  } Else {
  'Must servertype "N" or "Y"'
  Exit
  }
If ($windows -eq 'N') {
##############################IIS Server Install########################################

If ($servertype -eq 'WEB') {
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\IISconnections\IISconnections.ps1"')
$action1 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\IISconnections\IISconnections.vbs"')
$action2 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\wwps\processcheck.ps1"')
$action3 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\wwps\wwwpscount.vbs"')
$action4 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\iisadmin\processcheck.ps1"')
$action5 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\iisadmin\iisadmincount.vbs"')

#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR IISconnections Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5 -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitors IISconnections"
Register-ScheduledTask -TaskName "NR IISconnections Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5 -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitors IISconnections"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR IISconnections Monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

$starttasks = schtasks /run /TN "NR IISconnections Monitoring";
$starttasks
} Elseif ($servertype -eq 'SQL') { 
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\MSSQLSERVER\processcheck.ps1"')
$action1 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\MSSQLSERVER\processcount.vbs"')
$action2 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\SQLBrowser\processcheck.ps1"')
$action3 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\SQLBrowser\processcount.vbs"')


#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR SQL Monitoring" -Action $action,$action1,$action2,$action3 -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitors SQL"
Register-ScheduledTask -TaskName "NR SQL Monitoring" -Action $action,$action1,$action2,$action3 -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitors SQL"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR SQL Monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

$starttasks = schtasks /run /TN "NR SQL Monitoring";
$starttasks
} Elseif ($servertype -eq 'APP') { 
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Users\212599118\Desktop\plugins\Processes\ServerAgentService\processcheck.ps1"')
$action1 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\ServerAgentService\processcount.vbs"')
$action2 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\ServerControllerService\processcheck.ps1"')
$action3 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\ServerControllerService\processcount.vbs"')
$action4 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\MatrikonOPCTunneller\processcheck.ps1"')
$action5 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\MatrikonOPCTunneller\processcount.vbs"')
$action6 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\NotificationManager\processcheck.ps1"')
$action7 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\NotificationManager\processcount.vbs"')
$action8 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\MSMQ\msmqcheck.ps1"')
$action9 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\MSMQ\MSMQcount.vbs"')

#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR SmartSignal Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5,$action6,$action7,$action8,$action9 -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitors SmartSignal"
Register-ScheduledTask -TaskName "NR SmartSignal Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5,$action6,$action7,$action8,$action9 -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitors SmartSignal"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR SmartSignal Monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

$starttasks = schtasks /run /TN "NR SmartSignal Monitoring";
$starttasks
} Elseif ($servertype -eq 'CORE') { 
#Create the Action
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/13/use-powershell-to-create-scheduled-tasks.aspx
$action = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Users\212599118\Desktop\plugins\Processes\ServerAgentService\processcheck.ps1"')
$action1 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\ServerAgentService\processcount.vbs"')
$action2 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\ServerControllerService\processcheck.ps1"')
$action3 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\ServerControllerService\processcount.vbs"')
$action4 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\MatrikonOPCTunneller\processcheck.ps1"')
$action5 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\MatrikonOPCTunneller\processcount.vbs"')
$action6 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\Processes\NotificationManager\processcheck.ps1"')
$action7 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\Processes\NotificationManager\processcount.vbs"')
$action8 = (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-noprofile -executionpolicy bypass -File "C:\Program Files\New Relic\plugins\MSMQ\msmqcheck.ps1"')
$action9 = (New-ScheduledTaskAction -Execute 'Cscript' -Argument '//B //nologo "C:\Program Files\New Relic\plugins\MSMQ\MSMQcount.vbs"')

#Create a trigger - e.g. when do you wan it to run
$trigger =  New-ScheduledTaskTrigger -Daily -At 12am
#When the task is created, run with elevated privilages using the builtin administrators group

#Modify task to set compatibility to Win8 aka 2012 / 2012 R2
#http://blogs.technet.com/b/heyscriptingguy/archive/2015/01/14/use-powershell-to-configure-scheduled-task.aspx
$settings = New-ScheduledTaskSettingsSet -Compatibility Win8

#Now we "splat" the parameters to the Register-ScheduledTask cmdlet
# we could do 
#Register-ScheduledTask -TaskName "NR SmartSignal Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5,$action6,$action7,$action8,$action9 -Trigger $trigger -User $username -Settings $settings -RunLevel "Highest" -Description "Monitors SmartSignal"
Register-ScheduledTask -TaskName "NR SmartSignal Monitoring" -Action $action,$action1,$action2,$action3,$action4,$action5,$action6,$action7,$action8,$action9 -Trigger $trigger -User $username -Password $password -Settings $settings -RunLevel "Highest" -Description "Monitors SmartSignal"
# but that looks ugly and hard to read on one line
Start-Sleep -Seconds 5
$task = Get-ScheduledTask -TaskName "NR SmartSignal Monitoring"
$task
$task.Triggers.repetition.Duration = 'PT24H'
$task.Triggers.repetition.Interval = 'PT01M'
#$task | Set-ScheduledTask -User $username
$task | Set-ScheduledTask -User $username -Password $password

$starttasks = schtasks /run /TN "NR SmartSignal Monitoring";
$starttasks
} Else {
  'Must servertype "WEB" or "SQL" or "APP" or "GWY" or "CORE"'
  Exit
}

  } Elseif ($windows -eq 'Y') { 
  'NR Tasks must be manually created'
  } Else {
  'Must servertype "N" or "Y"'
  Exit
  }

################################################################################################
############################ INFRASTRUCTURE INSTALL ############################################
################################################################################################

If ($infrainstall -eq 'N') {
Exit
} Elseif ($infrainstall -eq 'Y') {
# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
   # Exit from the current, unelevated, process
   exit
   }
# Run your code that needs to be elevated here

'Check to make sure proper directory'

New-Item -ItemType Directory -Force -Path "C:\Program Files\New Relic\plugins"

'Download Newest infrastructure_agent'

$source = "https://download.newrelic.com/infrastructure_agent/windows/newrelic-infra.msi"
$destination = "C:\Program Files\New Relic\plugins\newrelic-infra.msi"
 
Invoke-WebRequest $source -OutFile $destination

Start-Sleep -s 15

'Running Install'

msiexec /i "C:\Program Files\New Relic\plugins\newrelic-infra.msi"

Start-Sleep -s 25

'Updating Config .yml file' 

$configFiles = Get-ChildItem 'C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml' | Get-Content
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace '<ENTER YOUR NEW RELIC KEY HERE>', "1e6fea7eeeccfc3e9f51a26d4f2a438a9c324c73" } |
    Set-Content $file.PSPath
}

Start-Sleep -s 3

$configFiles = Get-ChildItem 'C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml' | Get-Content

Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`ndisplay_name: HOSTNAME"

If ($isproxy -eq 'N') {
  'No Proxy'
  } Elseif ($isproxy -eq 'Y') { $proxylocation =read-host -prompt "Alpharetta(ALP) or Cincinnati(CIN) or 10.75.0.231(231) or 10.75.0.233(233)"
    If ($proxylocation -eq 'ALP') {
    Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`nproxy: http://PITC-Zscaler-Americas-Alpharetta3PR.proxy.corporate.ge.com:80"
    } Elseif ($proxylocation -eq '231') {
    Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`nproxy: 10.75.0.231:80"
    } Elseif ($proxylocation -eq '233') {
    Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`nproxy: 10.75.0.233:80"
    } Elseif ($proxylocation -eq 'CIN') {
    Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`nproxy: http://CIS-Cinci-pitc-SSOW.proxy.corporate.gtm.ge.com:80"
    } 
    Else { 'NO MATCH. EXITING...'
    Exit
  }
} 
Add-Content -Path "C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml" -Value "`r`ncustom_attributes:
  group: SITE
  datacenter: DATACENTER
  instance: prod
  application: APPLICATION
  servertype: SERVERTYPE
  ipaddress: IPADDRESS"

Start-Sleep -s 3

$configFiles = Get-ChildItem 'C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml' | Get-Content
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'HOSTNAME', $localhostname } |
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'SITE', $group }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'DATACENTER', $datacenter }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'APPLICATION', $application }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'SERVERTYPE', $servertype }|
    Set-Content $file.PSPath
}
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -creplace 'IPADDRESS', $ipaddress }|
    Set-Content $file.PSPath
}

Start-Sleep -s 3

'Starting infrastructure_agent'

net start newrelic-infra

Start-Sleep -s 3

'Installation Complete'
Exit
}