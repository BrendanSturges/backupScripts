# Author: github.com/brendansturges
# Description: backupScripts.ps1 - built to backup my code repository every weekday at noon.  I run this with a scheduled task on my local machine.  
# Built originally because the environment had no version control in place and everything was saved locally.
#

$powershellBackup = $false
$VSBackup = $false
$ErrorMessage = "None"
$smtpserver = ""
$backupFolder = ""
$uName = ""
$recepient = ""

Try{
	cp c:\Powershell $backupFolder -recurse -force
	$powershellBackup = $true
	cp "C:\Users\$uName\Documents\Visual Studio 2015\Projects" $backupFolder -recurse -force
	$VSBackup = $true
	$subject = "Code Backup Completed"
}
	
Catch {
	$ErrorMessage = $_.Exception.Message
	$subject = "Code Backup Failed"
}

$msgBody = "Powershell Backup Completed: " + $powershellBackup + "`nVisual Studio Backup Completed: " + $VSBackup + "`nErrors: " + $ErrorMessage

Send-MailMessage -to $recepient -from donotreply -subject $subject -body $msgBody -smtpserver $smtpserver