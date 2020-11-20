UpdateURL=http://www.qweex.com/update.php

Update:
	if(A_ThisLabel=="Update")
	{
		URLDownloadToFile, %UpdateURL%?id=%About_Name%&v=%About_Version%, %A_Temp%\%About_Name%_Update.tmp
		if(ErrorLevel)
		{
			msgbox, 16, Error, Could not contact update server
			return
		}
		FileRead, TempVar, %A_Temp%\%About_Name%_Update.tmp
		if(TempVar=0)
		{
			msgbox,, Up to date,You are running the latest version of %About_Name%!
			return
		}
		msgbox,4,An update is available, There is a new version of %About_Name%!`n`nYour version:`t%About_Version%`nNew version:`t%TempVar%`n`nDownload it now?
		ifmsgbox, yes
			run, %ProjectURL%
		return
	}