$content = @"
diskmgmt.msc
`$drive_letter = "C"
`$size = (Get-PartitionSupportedSize -DriveLetter `$drive_letter)
Resize-Partition -DriveLetter `$drive_letter -Size `$size.SizeMax
"@ 
New-Item 'C:\\Users\\Public\\Desktop\\resize_partition.ps1'
Add-Content 'C:\\Users\\Public\\Desktop\\resize_partition.ps1' $content


$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("C:\Users\Public\Desktop\clickme.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass `"C:\Users\Public\Desktop\resize_partition.ps1`""
$Shortcut.Save()