$proxy = [System.Net.WebProxy]::GetDefaultProxy() | select address | Select -ExpandProperty Address | Select -ExpandProperty OriginalString

IF([string]::IsNullOrEmpty($proxy)) {            
    Write-Output "No Proxy Configured" | out-file -filepath "C:\Program Files\New Relic\plugins\proxymonitor\proxy.txt" -Encoding Ascii         
} else {            
    Write-Output "$proxy" | out-file -filepath "C:\Program Files\New Relic\plugins\proxymonitor\proxy.txt" -Encoding Ascii            
}
