Dim waittime : waittime = 1 * 60 * 1000    

do 
On Error Resume Next
  Dim fso, folder, files, NewsFile,sFolder,counter,JSONFile,JSONstring , group, url, pluginpath, dirpath, hostname, instance, process, datacenter, proxycompare, proxy, Status

  url = "https://insights-collector.newrelic.com/v1/accounts/1123927/events"
  pluginpath = "C:\Program Files\New Relic\plugins\proxymonitor\"
  process = "proxymonitor"
  process = "Server Stats"
  hostname = "HOSTNAME"
  group = "SITE"
  datacenter = "DATACENTER"
  instance = "prod"
  application = "APPLICATION"
  servertype = "SERVERTYPE"
  
  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\proxymonitor\proxy.txt", 1)
  content = file.ReadAll

  Set fso = CreateObject("Scripting.FileSystemObject")  
  Set file = fso.OpenTextFile("C:\Program Files\New Relic\plugins\proxymonitor\proxycompare.txt", 1)
  content1 = file.ReadAll

  Set JSONFile = fso.CreateTextFile(PluginPath&"JSONfeedtest.json", True)
  JSONstring = "[{"
  JSONstring = JSONstring & chr(34) & "eventType" & chr(34) & ":" & chr(34) & "proxymonitor" & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "hostname" & chr(34) & ":" & chr(34) & hostname & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "instance" & chr(34) & ":" & chr(34) & instance & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "group" & chr(34) & ":" & chr(34) & group & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "datacenter" & chr(34) & ":" & chr(34) & datacenter & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "process" & chr(34) & ":" & chr(34) & process & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "proxycompare" & chr(34) & ":" & chr(34) & content1 & chr(34) & ","
  JSONstring = JSONstring & chr(34) & "proxy" & chr(34) & ":" & chr(34) & content & chr(34)
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