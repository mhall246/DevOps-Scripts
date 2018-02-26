Dim waittime : waittime = 1 * 60 * 1000    

do 
On Error Resume Next
  Dim fso, folder, files, NewsFile, sFolder, counter, JSONFile, JSONstring , url, pluginpath, dirpath, hostname, instance, process, site, datacenter, application, servertype, Status

  url = "https://insights-collector.newrelic.com/v1/accounts/1123927/events"
  pluginpath = "C:\Program Files\New Relic\plugins\sql\"
  process = "sql stats"
  hostname = "HOSTNAME"
  site = "SITE"
  datacenter = "DATACENTER"
  instance = "prod"
  application = "APPLICATION"
  servertype = "SERVERTYPE"
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\temptrans.txt", 1)
  content = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\sstrans.txt", 1)
  content2 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totaltrans.txt", 1)
  content3 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\tempwritetrans.txt", 1)
  content4 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\sswritetrans.txt", 1)
  content5 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totalwritetrans.txt", 1)
  content6 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\tempfilesize.txt", 1)
  content7 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\ssfilesize.txt", 1)
  content8 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totalfilesize.txt", 1)
  content9 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\templogused.txt", 1)
  content10 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\sslogused.txt", 1)
  content11 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totallogused.txt", 1)
  content12 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\templogcache.txt", 1)
  content13 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\sslogcache.txt", 1)
  content14 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totallogcache.txt", 1)
  content15 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\tempactivetransactions.txt", 1)
  content16 = file.ReadAll
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\ssactivetransactions.txt", 1)
  content17 = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\sql\totalactivetransactions.txt", 1)
  content18 = file.ReadAll
  
  Set JSONFile = fso.CreateTextFile(PluginPath&"JSONfeedtest.json", True)
  JSONstring = "[{"
  JSONstring = JSONstring & chr(34) & "eventType" & chr(34) & ":" & chr(34) & "sql stats" & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "hostname" & chr(34) & ":" & chr(34) & hostname & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "instance" & chr(34) & ":" & chr(34) & instance & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "process" & chr(34) & ":" & chr(34) & process & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "site" & chr(34) & ":" & chr(34) & site & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "datacenter" & chr(34) & ":" & chr(34) & datacenter & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "application" & chr(34) & ":" & chr(34) & application & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "servertype" & chr(34) & ":" & chr(34) & servertype & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "SmartSingal transactions/sec" & chr(34) & ":" & chr(34) & CStr(content2) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total transactions/sec" & chr(34) & ":" & chr(34) & CStr(content3) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb write transactions/sec" & chr(34) & ":" & chr(34) & CStr(content4) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "SmartSingal write transactions/sec" & chr(34) & ":" & chr(34) & CStr(content5) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total write transactions/sec" & chr(34) & ":" & chr(34) & CStr(content6) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb data file(s) size (kb)" & chr(34) & ":" & chr(34) & CStr(content7) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "SmartSingal data file(s) size (kb)" & chr(34) & ":" & chr(34) & CStr(content8) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total data file(s) size (kb)" & chr(34) & ":" & chr(34) & CStr(content9) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb percent log used" & chr(34) & ":" & chr(34) & CStr(content10) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "SmartSingal percent log used" & chr(34) & ":" & chr(34) & CStr(content11) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total percent log used" & chr(34) & ":" & chr(34) & CStr(content12) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb log cache hit ratio" & chr(34) & ":" & chr(34) & CStr(content13) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "SmartSingal log cache hit ratio" & chr(34) & ":" & chr(34) & CStr(content14) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total log cache hit ratio" & chr(34) & ":" & chr(34) & CStr(content15) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb active transactions" & chr(34) & ":" & chr(34) & CStr(content16) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "SmartSingal active transactions" & chr(34) & ":" & chr(34) & CStr(content17) & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "Total active transactions" & chr(34) & ":" & chr(34) & CStr(content18) & chr(34) & ","

  JSONstring = JSONstring & chr(34) & "Tempdb transactions/sec" & chr(34) & ":" & CStr(content)
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
