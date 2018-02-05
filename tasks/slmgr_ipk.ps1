Param([Parameter(Mandatory=$True)] [String] $activation_key)
cscript.exe C:\Windows\System32\slmgr.vbs /ipk $activation_key