;debug(UnRelativeate(".\..\Dropper\Dropper.exe"))
;debug(UnRelativeate(".\PEM.exe"))
test=P:\Program Files\Mozilla Firefox\firefox.exe
msgbox, %test%
msgbox, % test:=Relativeate(test)
msgbox, % UnRelativeate(test)
return

; This function is designed to make Path1 relative to Path2.
Relativeate(Path1,Path2="")
{	
	if !Path2
		Path2:=A_scriptdir
	if(SubStr(Path1,1,3)!=SubStr(Path2,1,3))	;The two paths must be on the same drive!
		return ERROR
	StringSplit, Path1_, Path1,\
	StringSplit, Path2_, Path2,\
	Splitpath, Path2, Fn,Dir
	if(SubStr(Path2,1,StrLen(Path2)-StrLen(Fn)-1)!=SubStr(Path1,1,StrLen(Path2)-StrLen(Fn)-1))	;If they aren't in the same directory...
	{
		GotIt:=Path2_0			;"GotIt" is how many folders to check out. First, we check all of them.
		loop, % Path2_0-1		;The -1 is for the drive letter, since we already checked if they are the same.
		{						;(this loop checks folders from right to left)
			
			loop, %GotIt%		;We add the character count of every folder we want to check...
				StrLen+=StrLen(Path2_%A_index%)+1			;(The +1 is for the following slash)
			if(SubStr(Path1,1,StrLen)=SubStr(Path2,1,StrLen))	;...then we compare the two.
				break										; If they are a match, then they are the same folder and we are done.
			OutPath.="..\"									; Otherwise, count it as up a parent...
			GotIt--											; ...and the number of folders to check decrements.
		}
	}
	else {			;If they are in the same directory...
		Stringreplace,Dir,Dir,\,\,UseErrorLevel		; Count how many \'s are in the directory...
		GotIt:=ErrorLevel+2							; ...then add 2 to it???
	}
	if !OutPath										;Failsafe check to see if they are in the same directory.
		OutPath=.\
	
	GotIt++		; "GotIt" is now the number of folders in Path1 that are not common to the Path2
	loop, % Path1_0-GotIt
	{
		OutPath.=Path1_%GotIt% . "\"		;We just append it to the "..\"'s we had earlier, and we have our path.
		GotIt++
	}
	OutPath.=Path1_%Path1_0%				;And finally add the last folder/file of the path.
	return outpath
}

; This function is designed to determine a relative path. I.E., to turn a relative path into a static one.
;		"." means the current directory
;		".." means the parent directory
UnRelativeate(OutPath,ScriptPath="")
{
	if !ScriptPath
		ScriptPath:=A_scriptdir
	StringSplit, SPath_, ScriptPath,\
	StringSplit, OPath_, OutPath,\
	OutPath=
	loop, %OPath_0%
	{
		if(OPath_%A_Index%=".")
			continue
		if(OPath_%A_Index%="..")
			SPath_0--
		else
			OutPath.= "\" . OPath_%A_Index%
	}
	RPath=
	loop, % SPath_0
		RPath.= "\" . SPath_%A_Index%
	if(SubStr(RPath,1,1)="\")
		RPath:=SubStr(RPath,2)
	RPath.= OutPath
	return %RPath%
}