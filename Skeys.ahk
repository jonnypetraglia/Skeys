/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~Skeys version 1.5~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~Copyright Qweex 2012~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~http://www.qweex.com~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~MrQweex@qweex.com~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This file is part of Skeys.

    Poem is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Poem is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with StartupSaver.  If not, see <http://www.gnu.org/licenses/>.
*/

#singleinstance, ignore
#include balloontip.ahk     ;http://www.autohotkey.com/forum/post-254755.html#254755
#include anchor.ahk         ;http://www.autohotkey.net/~Titan/#anchor

About_Name=Skeys
About_Version=1.5
About_DateLaunch=2009
About_Date=2012
About_CompiledDate=02/06/2012

#include Update_Lite.ahk
#include Skeys_autoexec.ahk
#include Skeys_HotkeyLabel.ahk
#include Relativeate.ahk

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Menus~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Handles menu
mPortable:
	if(Portable=1)
	{
		Menu, config, uncheck,Portable
		Menu, config, enable, Start with Windows
		Iniwrite, 0, skeys.ini,Config, Portable
		Portable=0
	}
	else
	{
		Menu, config, check,Portable
		Menu, config, disable, Start with Windows
		Iniwrite, 1, skeys.ini,Config, Portable
		Portable=1
		if(FileExist(A_Startup . "\Skeys.lnk"))
		{
			startup=1
			msgbox,4,,Delete Startup entry for Portable mode?
			ifmsgbox, yes
				gosub, mStartup
		}
	}
return

	;Handles menu
mStartDisabled:
	if(startdisabled=1)
	{   Menu, config, uncheck, Start Disabled
		iniwrite, 0, skeys.ini,Config, startdisabled
		startdisabled=0
	} else {
		Menu, config, check, Start Disabled
		iniwrite, 1, skeys.ini,Config, startdisabled
		startdisabled=1
	}
return

	;Handles menu
mSkipSetup:
	if(skipsetup=1)
	{
		Menu, config, uncheck,Skip Setup
		iniwrite, 0, skeys.ini,Config, skipsetup
		skipsetup=0
	} else {
		Menu, config, check, Skip Setup
		iniwrite, 1, skeys.ini,Config, skipsetup
		skipsetup=1
		if(startintray=1)
		{   Menu, config, uncheck,Start in tray
			iniwrite, 0, skeys.ini,Config, startintray
			startintray=0
		} 
	}
return

	;Handles menu
mStartintray:
	if(startintray=1)
	{   Menu, config, uncheck,Start in tray
		iniwrite, 0, skeys.ini,Config, startintray
		startintray=0
	} else {
		Menu, config, check, Start in tray
		iniwrite, 1, skeys.ini,Config, startintray
		startintray=1
		if(skipsetup=1)
		{   Menu, config, uncheck,Skip Setup
			iniwrite, 0, skeys.ini,Config, skipsetup
			skipsetup=0
		} 
	}
return

	;Handles menu
mStartup:
	if(startup=1)
	{
		Menu, config, uncheck, Start with Windows
		ifexist, %A_Startup%\Skeys.lnk
			FileDelete, %A_Startup%\Skeys.lnk
		startup=0
	}
	else
	{
		Menu, config, check, Start with Windows
		Filecreateshortcut,%A_Scriptfullpath%,%A_Startup%\Skeys.lnk,%A_WorkingDir%,/tray,Special Keys customizer
		startup=1
	}
return

	;Inserts special key from menu
mInsertspecialkey:
	Gui 3: submit, nohide		;DEBUG?
	Guicontrol 3:,vInput,%vInput%{%A_ThisMenuItem%}
return

	;Enables hotkeys
mEnableHotkeys:
	Menu, tray, togglecheck, Enabled
	Suspend, Toggle
return

	;Shows dialog to browse for a file or program
mFileProgram:
	gosub_var=AddFileProgram
	Guicontrol 3: -Number +limit100, vInput
	Guicontrol 3: , vInput
	Guicontrol 3: move, vInput, w135
	Guicontrol 3: , vBrowseButton, % A_IsUnicode ? "…" : "..."
	Guicontrol 3: -hidden, vBrowseButton
	Gui 3: +owndialogs
	Gui 3: show, autosize, Add File/Program
Return

	;Returns 1 if there is already a power option, 0 else
CheckPower()
{
	gui 1: default
	Loop,% LV_GetCount()
	{
		LV_GetText(tempy,A_Index)
		if(tempy="Hibernate" or tempy="Standby" or tempy="Hibernate (S)" or tempy="Shutdown" or tempy="Restart")
			return 1
	}
	return, 0
}

	;Adds a power option if there is not one already
mAddpower:
	if(checkPower()=1)
	{
		msgbox, 16, Multiple power options, You can only have one power option per key!
		Return
	}
	LV_Add("",A_Thismenuitem)
	SaveOptions()
return

	;Shows dialog for Type or Paste
mKeystrokes:
	gosub_var=addkeystrokes
	TempVar:=A_Thismenuitem		;Either Type or Paste
	Guicontrol 3:, vInput,
	Guicontrol 3: +limit100 -number, vInput,
	Guicontrol 3: move, vInput, w135
	Guicontrol 3: -hidden, vvBrowseButton,
	Guicontrol 3: ,vvBrowseButton, +    ;?
	Gui 3: show,autosize,Add %TempVar%
return

	;Adds a popup if there is not one already
mPopup:
	gui 1: default
	Loop, % LV_GetCount()
	{
		LV_GetText(tempy,A_index)
		ifinstring, tempy, popup
		{
			msgbox,16,Only one popup allowed, Only one popup is allowed per key!
			Return
		} 
	}
	LV_Add("","Popup (" . getcaps(A_Thismenuitem) . ")")
	SaveOptions()
	LV_Modifycol(1,"autohdr")
return

	;Adds a generic menu item to the main listview
mGeneric:
	LV_Add("",A_ThisMenuItem)
	SaveOptions()
return

	;Add the wait menu item to the main listview
mWait:
	Guicontrol 3:+Number +limit20,vInput,
	Guicontrol 3:,vInput,
	gosub_var=addwait
	Gui 3: show,,Add Wait
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GUI Events~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Show GUI 2
mShowKeysetup:
	  ;Gets position of Skeys main window if it already exists
	Wingetpos,PositionX,PositionY,,,ahk_id %skeys_id%
	gui 1: hide

	gosub MustSelectOne

	if(winexist("ahk_id " . setup_id))
	{
		winactivate, ahk_id %setup_id%
		gosub SetupKeycapture
		Return
	}

	Gui 2: show,% (PositionX ? ("x" . PositionX) : "") . " " (PositionY ? ("y" . PositionY) : ""), Skeys Key Setup
	Gui 2: +Lastfound
	setup_id:=WinExist()
	gui 3: +owner2
	gosub setupkeycapture
	Menu, nickname, add,% "  Nickname  ",Nickname
	  Menu, nickname, color, white	;DEBUG
return

mShowMain:
	Gui 2: hide
	LV_Modifycol(1,70)
	LV_Modifycol(2,100)

	gosub, CreateListString
	gosub, gChange

	if(winexist("ahk_id " . skeys_id))
	{
		winactivate, ahk_id %skeys_id%
		Return
	}

	if(ifmax=1)
		gui 1: show, maximize, Skeys
	else
		gui 1: show, autosize %PositionX% %PositionY%,Skeys
	gui 1: +lastfound
	skeys_id:=WinExist()
	gui 3: +owner1
return

Nickname:
	Guicontrol 3:-Number +limit21,vInput
	Guicontrol 3:,vInput,% %CurrentControl%_nick
	gosub_var=setnewnick
	loop, 18
		if(CurrentControl=Key_%A_Index%)
		{
			Gui 3: show,,% "Change nick: " . Nickname_%A_Index%
			break
		}
return

	;When GUI 1 is sized
Guisize:
	anchor("vGroupbox1","wh")
	anchor("vMainListView","wh")
	anchor("vUp","x")
	anchor("vDown","x")
	anchor("vScanCode","x")
	gui 1: default
	LV_Modifycol(2,"autohdr")
return

	;Show About window
mAbout:	;DEBUG!
	gui 18: default
	gui, +owner1 +toolwindow
	gui, margin, 3,3
	gui,add, picture, icon1 x5 y5 h32 w32, % A_IsCompiled ? A_Scriptname : "Skeys.ico"
	Gui, font, w700 underline
	Gui, add, text, xp+36 yp+3,Skeys v%VERSION%
	Gui, font
	Gui, add, text, xp yp+17 w145 r1,Skeys is made specifically
	gui, add, text, xp-33 yp+15 w180 h60,for "Special keys" (where Skeys`ngets its name)`, and the ability to`ncustomize them to your liking.`nFeedback is encouraged.
	Gui, font, underline
	gui, add, text, xp+10 yp+60 ggmReadme, Readme
		gui, add, text, xp+45, |
	gui, font, CBlue
	Gui, add, text, xp+10 ggWebsite,Website
		gui, add, text, xp+45, |
	Gui, add, text, xp+10 ggEmail,Email
	gui, show, w170, About Skeys
return

	;Handles when about window is closed
18guiclose:
	gui 18: destroy
return

	;When GUI 1 is closed
guiclose:
	Winget,ifmax,Minmax, ahk_id %skeys_id%
	gui 1: hide
	Gui 3: hide
	;~ gosub activatehotkeys
return

	;When GUI 2 is closed
2guiclose:
	Gui 3: hide
	Gui 2: hide
	gosub activatehotkeys
return

2guicontextmenu:
	loop, 18
	{  
		if(A_Guicontrol=Key_%A_Index%)
		{
			CurrentControl:=A_GuiControl
			Guicontrolget, Position, pos, %CurrentControl%
			PositionX+=3
			PositionY+=42
			Menu, nickname, show, %PositionX%, %PositionY%
			Break
		}
	}
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~GLabels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Ensures at least one key is enabled in GUI 2
MustSelectOne:
	Gui 2: submit, nohide
	Loop, 18
	{
		tempvar:=Key_%A_Index%
		if(%tempvar%=1)
		{  
		  Guicontrol 2: enabled, vdone
		  Return
		}
	}
	Guicontrol 2: disabled, vdone
return

gWebsite:
	run, http://www.FreewareWire.blogspot.com
Return

gEmail:
	run, mailto:FreewareWire@gmail.com
return

gmReadme:
ifexist, readme.txt
	run readme.txt		;DEBUG
return

	;Handler for browse button
gBrowseButton:
	Gui 3: submit, nohide
	if(gosub_var="addfileprogram" or edit_action="Open")
	{
		Fileselectfile, outputfile, 35,,Select file/program, Programs (*.exe)
		if(!outputfile)
			return
		SplitPath, outputfile,,,ext
		if(Portable)
		{
			outputfile:=Relativeate(outputfile)
			if(!outputfile)
			{
				msgbox, Skeys is in Portable mode so the file or program you select must be on the same disk!
				return
			}
		}
		Guicontrol 3: ,vInput, %outputfile%
		if(ext="exe")
			BalloonTip("","If your program has any parameters, pass them at the end!",3000)		;DEBUG: Y U NO WORK?!
	}
	else if(gosub_var="addkeystrokes" or edit_action="Type" or edit_action="Paste")
	{
		Guicontrolget, Position, pos,vBrowseButton
		PositionX+=18
		PositionY+=18
		Menu, functionkeys, show, %PositionX%, %PositionY%
	}
	;    balloontip("Legend",Balloonmsg,100000)		;DEBUG?
return

AddFileProgram:
	AddEntry("Open")
return

AddWait:
	AddEntry("Wait",0,vInput)
return

EditEntry:
	Gui 3: submit
	AddEntry(edit_action,rownum,vInput)
return

gEdit:
	gui 1: default
	rownum:=LV_GetNext()
	LV_GetText(TempVar,rownum,1)	;What to edit
	if(tempvar!="Wait" and tempvar!="Open" and tempvar!="Type" and tempvar!="Paste")
		return
	if(tempvar="Wait")
	{
		Guicontrol 3:+limit20, vInput
		Guicontrol 3:+number, vInput
	} else
	{
		if(tempvar="Open")
		{
			Guicontrol 3:+limit20, vInput
			Guicontrol 3:move,vInput,w135 
			Guicontrol 3:-hidden,vBrowseButton
		} else
		{
			if(tempvar="Type" or tempvar="Paste")
				Guicontrol 3: +limit100,vInput
			Guicontrol 3:move,vInput,w135 
			Guicontrol 3:-hidden,vvBrowseButton
			Guicontrol 3:,vvBrowseButton,+     ;?
		}
	}
	gosub_var=EditEntry
	LV_GetText(tempvar,rownum,2)
	Guicontrol 3:,vInput,%tempvar%
	Gui 3: show,autosize, Edit entry
return

gUp:
	simplemove("Up")
	SaveOptions()
return

gDown:
	simplemove("Down")
	SaveOptions()
Return

2ButtonDone:
	Wingetpos,PositionX,PositionY,,,ahk_id %setup_id%
	if(PositionX!="") {
	  PositionX=x%PositionX%
	  PositionY=y%PositionY%
	}
	Gui 2: submit
	Gui 3: hide
	Loop, 18
	{
		tempy:= Key_%A_Index%
		if(%tempy%)   
			iniwrite, 1, skeys.ini, Keys,% Key_%A_index%
		Else
			iniwrite, 0, skeys.ini, Keys,% Key_%A_index%
	}
	gosub, activatehotkeys
goto, mShowMain

gEnableKey:
	gui 1: submit, nohide
	TempVar:=Activated%vMainlist%
	Enabled_%Tempvar%:=vKeyEnabled
	iniwrite, %vKeyEnabled%, skeys.ini,% Key_%TempVar%,enabled
	if(vKeyEnabled)
	{
		hotkey, ifwinactive			;DEBUG
		Hotkey,% "*" . Key_%tempvar%, HotkeyLabel, on
		guicontrol 1: enable, vAdd 
		guicontrol 1: enable, vEdit
		guicontrol 1: enable, vDel
		guicontrol 1: enable, vUp
		guicontrol 1: enable, VDown
		guicontrol 1: enable, vMainListView
	}
	else
	{
		Hotkey, ifwinactive
		Hotkey,% "*" . Key_%tempvar%, HotkeyLabel, off
		guicontrol 1: disable, vAdd 
		guicontrol 1: disable, vEdit
		guicontrol 1: disable, vDel
		guicontrol 1: disable, vUp
		guicontrol 1: disable, vDown
		guicontrol 1: disable, vMainListView
	}
return

gAutoCheck:
	Gui 2: submit, nohide
return

gAdd:
	Menu, add, show, 55, 121		;DEBUG: relative
return

gAll:
	Loop, 18
		Guicontrol 2:,% Key_%A_index%,1
	Guicontrol 2: enabled,vdone
return

gNone:
Loop, 18
		Guicontrol 2:,% Key_%A_index%,0
	Guicontrol 2: disabled,vdone
return

gDel:
	gui 1: submit, nohide
	if(!LV_GetCount("Selected"))
		return
	TempVar:=LV_GetNext(0,"Focused")		;What to delete
	LV_Delete(TempVar)
	if(tempvar=(LV_GetCount()+1))
		LV_Modify(TempVar - 1, "Select")
	Else
		LV_Modify(TempVar, "Select")
	SaveOptions()
	TempVar:=Activated%vMainlist%
	Inidelete, skeys.ini, % Key_%tempvar%, % "Entry" . (LV_GetCount()+1)
	Inidelete, skeys.ini, % Key_%tempvar%, % "Option" . (LV_GetCount()+1)
return

	;Selects new Key in the main list
gChange:
	gui 1: submit, nohide
	gui 1: default
	LV_Delete()
	TempVar:=Activated%vMainList%
	guicontrol 1:,vKeyEnabled,% Enabled_%TempVar%
	guicontrol 1:,vNickname,% Nickname_%TempVar%
	guicontrol 1:,vScanCode,% Key_%TempVar%
	Loop,
	{
		iniread, entry, skeys.ini,% Key_%TempVar%, entry%A_INDex%
		if(entry="ERROR")
			Break
		if(entry="Open" or entry="Wait" or entry="Type" or entry="Paste")
		{ 
			iniread, Option, skeys.ini, % Key_%TempVar%, option%A_Index%
			LV_Add("",entry,option)
		} Else
			LV_Add("",entry)
	}
	LV_Modifycol(1,"autohdr")
	LV_modifycol(2,"autohdr")
	gosub gEnableKey
return

gUniButton:
	gosub %gosub_var%
3guiclose:
	Gui 3: hide
	Guicontrol 3:move,vInput,w150
	Guicontrol 3:+hidden, vvBrowseButton
	edit_action=
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Misc~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Gets characters for popups: e.g., Bottom Left = BL
GetCaps(input)		;DEBUG: optimize
{
	Stringsplit, capsarray, input, %A_space%
	output=
	Loop,
	{
		if(capsarray%A_Index%="")     
			Break
		Stringsplit,output,capsarray%A_Index%
		output:=output . output1
		capsarray%A_Index%=
	}
	return, %output%
}

	;Adds or edits an entry in the main listview
		;entry = what to add
		;IsEdit = editing instead of adding
		;options = 
AddEntry(entry, IsEdit = 0, options = 0)
{
	global vInput
	Gui 3: submit, nohide   
	if(vInput="")
		Return
	Gui 3: hide
	gui 1: default
	if(IsEdit=0)
		LV_Add("", entry,vInput)
	Else
		LV_Modify(IsEdit, "", entry,options)
	SaveOptions()
}

	;Adds Keystrokes to the main listview
addkeystrokes:
	Gui 3: submit, nohide
	if(vInput="")
		return
	Gui 3: hide
	gui 1: default
	LV_Add("", TempVar, vInput)
	SaveOptions()
return

;Moves a Listview item either "up" or "down"
SimpleMove(direction)
{
	if(direction="down")
		UpOrDown=-1
	else if(direction="up")
		UpOrDown=1
	else
		return -1
	Selected := LV_GetNext(0, "Focused")
	totalCount := LV_GetCount()
	if (!Selected or !LV_GetCount("Selected") or (rownumber=1 and direction="up") or (rownumber=totalCount and direction="down"))
		return
	if(Selected=LV_GetNext(Selected-1,"Checked"))
		Checkit=1
	else
		checkit=0
	LV_GetText(entry, selected,1)
	LV_GetText(option, selected,2)
	LV_Delete(selected)
	LV_Insert(selected - UpOrDown, "select", entry, option)
	if(checkit>0)
		LV_modify(selected - UpOrDown, "Check")
}


	;Saves options to the INI file
SaveOptions()		;DEBUG: Why is this a function?
{
	global
	gui 1: submit, nohide
	Loop, % LV_GetCount()
	{
		LV_GetText(entry,A_Index)
		tempvar:=Activated%vMainList%
		iniwrite, %entry%, skeys.ini,% Key_%tempvar%,Entry%A_INDEX%
		if(entry="Open" or entry="Wait" or entry="Type" or entry="Paste")
		{
			LV_GetText(option,A_Index,2)
			iniwrite, %option%, skeys.ini,% Key_%tempvar%,Option%A_INDEX%  
		}
		Else
			inidelete, skeys.ini, % Key_%tempvar%, Option%A_index%
	}
	LV_Modifycol(1,"autohdr")
	LV_modifycol(2,"autohdr")
}


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


SetupKeyCapture:
	loop, 18
	{
		Hotkey, IfWinActive, ahk_id %setup_id%
		Hotkey,% "*" . Key_%A_Index%, KeySetupHotkey, on
	}
return

ActivateHotkeys:
loop, 18
{
	if(Enabled_%A_Index%)
	{
		Hotkey, ifwinactive		;DEBUG? Window id
		Hotkey,% "*" . Key%A_Index%, HotkeyLabel, on
	}
	else
	{
		Hotkey,% "*" . Key_%A_Index%, HotkeyLabel, off
	}
}
return

DisableHotkeys:
	loop, 18
		Hotkey,% "*" . Key_%A_Index%, HotkeyLabel, off
return



RemoveAsterisk(inputstring)
{
  StringReplace, outputstring, inputstring,*
  return outputstring
  
}

exittime:
exitapp

SetNewNick:
	Gui 3: submit
	Guicontrol 3:, vInput,
	Loop, 18
	{
		if(CurrentControl=Key_%A_Index%)
		{
			Nickname_%A_index%:=vInput
			if(Nickname_%A_Index%="")
			{
				if(%CurrentControl%_highlight)
					Guicontrol 2:, %CurrentControl%, !!!Use This Key!!!
				else
					Guicontrol 2:, %CurrentControl%,Use this key
				inidelete,skeys.ini,%CurrentControl%,name
			}
			else
			{
				if(%CurrentControl%_highlight)
					Guicontrol 2:, %CurrentControl%, !!!%vInput%!!!
				else
					Guicontrol 2:,%CurrentControl%,%vInput%
				iniwrite,%vInput%,skeys.ini,%CurrentControl%, name
			}
		}
	}
return

ButtonSet:
	gui 1: submit, nohide
	TempVar:=Activated%vMainList%
	Nickname_%TempVar%:=vNickname
	Stringsplit, array, Nickname_%TempVar%
	if(vNickname="")
		vNickname:=Key_%TempVar%
	if(vNickname!=Key_%TempVar%)
		iniwrite,%vNickname%,skeys.ini, % Key_%TempVar%,name
	Else
		inidelete, skeys.ini, % Key_%TempVar%,name
	Stringreplace, MainListString, MainListString,||,|
	stringSplit, MainListString, MainListString,|
	MainListString%vMainList%:=vNickname . "|"
	MainListString=
	loop, % MainListString0-1
	{
		MainListString.=MainListString%A_Index% . "|"
		MainListString%A_Index%=
	}
	guicontrol 1:, vMainList, |
	guicontrol 1:, vMainList, %MainListString%
return

showpopup:
	if(PopupX!=0 and PopupX!="")
	{
		DetectHiddenWindows, on
		gui 50: show, x%PopupX% y%PopupY% hide
		Wingetpos,,,tempvar,,ahk_id %Popup_id%
		PopupX-=tempvar+2
		DetectHiddenWindows, off
	}
	if(PopupX="")
		gui 50: show, hide
	else
		gui 50: show, hide y%PopupY% x%PopupX%
	DllCall("AnimateWindow","UInt",Popup_id,"Int",250,"UInt",PopupShow)
	PopupNoWait=0
	settimer, destroypopup, -1000
return

destroypopup:
	if(PopupNoWait=1)
		return
	DllCall("AnimateWindow","UInt",Popup_id,"Int",250,"UInt",PopupHide)
	gui 50: destroy
	PopupNoWait=0
return

CreateListString:
	MainListString=
	index=1
	loop, 18
	{
		iniread, tempy, skeys.ini, Keys,% Key_%A_Index%,0
		if(tempy)
		{
			Activated%index%:=A_Index
			iniread, Nickname_%index%, skeys.ini,% Key_%A_Index%,name,% Key_%A_Index%
			iniread, Enabled_%index%, skeys.ini,% Key_%A_Index%,enabled,0
			MainListString.=Nickname_%index% . "|"
			index++
		}
	}
	stringreplace, MainListString, MainListString, |, ||
	guicontrol 1:,vMainList, |
	guicontrol 1:,vMainList, %MainListString%
return

KeySetupHotkey:
	Suspend, permit
	thishotkey:=RemoveAsterisk(A_ThisHotkey)
	gui 2: submit, nohide
	loop, 18
		if(Key_%A_Index%=thishotkey)
		{
			if(%ThisHotkey%_highlight)
				Guicontrol 2:, %ThisHotkey%,% Nickname_%A_Index%
			else
				Guicontrol 2:, %ThisHotkey%,% "!!!" . Nickname_%A_Index% . "!!!"
			%ThisHotkey%_highlight := %ThisHotkey%_highlight ? 0 : 1
			break
		}
	if(vAutoCheck=1)
	{
		Guicontrol 2:,%Thishotkey%,1
		gosub mustselectone
	}
return

#include AboutWindow.ahk