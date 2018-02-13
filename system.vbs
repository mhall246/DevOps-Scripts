Dim waittime : waittime = 1 * 60 * 1000    

do 
On Error Resume Next
  Dim fso, folder, files, NewsFile,sFolder,counter,JSONFile,JSONstring , group, url, pluginpath, dirpath, hostname, instance, process, datacenter, application, servertype, memory, cdrive, ddrive, CFragmentation, ProcessCount,lastreboot, ipaddress, cpu, usernames, usersconnected, Status

  url = "https://insights-collector.newrelic.com/v1/accounts/1123927/events"
  pluginpath = "C:\Program Files\New Relic\plugins\system\"
  process = "Server Stats"
  hostname = "HOSTNAME"
  group = "SITE"
  datacenter = "DATACENTER"
  instance = "prod"
  application = "APPLICATION"
  servertype = "SERVERTYPE"
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\cpu.txt", 1)
  content = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\mem.txt", 1)
  content2 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\cdrive.txt", 1)
  content3 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\proc.txt", 1)
  content4 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\ddrive.txt", 1)
  content5 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\frag.txt", 1)
  content6 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\days.txt", 1)
  content7 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\ipaddress.txt", 1)
  content8 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\status.txt", 1)
  content9 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\users.txt", 1)
  content10 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\system\usersnum.txt", 1)
  content11 = file.ReadAll
  
  Set JSONFile = fso.CreateTextFile(PluginPath&"JSONfeedtest.json", True)
  JSONstring = "[{"
  JSONstring = JSONstring & chr(34) & "eventType" & chr(34) & ":" & chr(34) & "ServerStats" & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "hostname" & chr(34) & ":" & chr(34) & hostname & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "instance" & chr(34) & ":" & chr(34) & instance & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "group" & chr(34) & ":" & chr(34) & group & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "datacenter" & chr(34) & ":" & chr(34) & datacenter & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "application" & chr(34) & ":" & chr(34) & application & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "servertype" & chr(34) & ":" & chr(34) & servertype & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "process" & chr(34) & ":" & chr(34) & process & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "memory" & chr(34) & ":" & chr(34) & CStr(content2) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "cdrive" & chr(34) & ":" & chr(34) & CStr(content3) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "ddrive" & chr(34) & ":" & chr(34) & CStr(content5) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "CFragmentation" & chr(34) & ":" & chr(34) & CStr(content6) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "ProccessCount" & chr(34) & ":" & chr(34) & CStr(content4) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "lastreboot" & chr(34) & ":" & chr(34) & CStr(content7) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "ipaddress" & chr(34) & ":" & chr(34) & CStr(content8) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "status" & chr(34) & ":" & chr(34) & CStr(content9) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "usernames" & chr(34) & ":" & chr(34) & content10 & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "usersconnected" & chr(34) & ":" & chr(34) & CStr(content11) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "cpu" & chr(34) & ":" & CStr(content)
  JSONstring = JSONstring & "}]" 

  JSONFile.WriteLine(JSONstring)
  JSONFile.Close

  Set objXmlHttpMain = CreateObject("MSXML2.XMLHTTP")
  objXmlHttpMain.setProxy 1, "http://PITC-Zscaler-Americas-Alpharetta3PR.proxy.corporate.ge.com:80"
  objXmlHttpMain.open "POST",url, False 
  objXmlHttpMain.setRequestHeader "X-Insert-Key", "ywC6nKOi6GJJp-E7ViZp5-EzkUx97zaL"
  objXmlHttpMain.setRequestHeader "Content-Type", "application/json"
  objXmlHttpMain.send JSONstring
  result = objXmlHttpMain.responseText

  WScript.Quit
  'Wscript.Echo content
  WScript.Sleep(waittime)
loop
