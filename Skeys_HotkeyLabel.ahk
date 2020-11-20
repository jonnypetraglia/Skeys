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

HotkeyLabel:
ThisHotkey:=RemoveAsterisk(A_ThisHotkey)
Loop, 
{
	iniread, action, skeys.ini, %thishotkey%,Entry%A_Index%
	if(action="" or action="ERROR")
		Break
	if(action="Exit Skeys")
		ExitApp
	ifinstring, action, Popup
	{
		wingetpos,,,tskbrw, tskbrh, ahk_class Shell_TrayWnd
		iniread, popuptext,skeys.ini,%Thishotkey%,name,Skeys v%VERSION%
		ifnotinstring, action, C
		{
			ifinstring, action,B
			{
				PopupShow=0x60008
				PopupHide=0x50004
				PopupY:=(A_Screenheight-tskbrh-24-2)
			}
			Else ifinstring, action, T
			{
				PopupShow=0x40004
				PopupHide=0x50008
				PopupY=0
			}
			ifinstring, action,R
				PopupX:=A_screenwidth
			Else ifinstring, action, L
				PopupX=0
		} else
		{ 
			PopupShow=0x60010
			PopupHide=0x50010
			PopupX:=
			PopupY:=
		}
		ifwinexist,ahk_id %Popup_id%
			PopupNoWait=1
		gui 50: destroy
		gui 50: -caption +alwaysontop +toolwindow   
		gui 50: margin, 2, 2
		gui 50: +lastfound
		Popup_id:=WinExist()
		gui 50: add, picture, w24 h24 icon1,% A_IsCompiled ? A_Scriptfullpath : "Skeys.ico"
		gui 50: font, w700
		Gui 50: add, text, xp+27 yp+5,%popuptext%         ;yp
		gui 50: font
		settimer, showpopup, -1 ;000
    }
    else {
    if(action="Wait" or action="Open" or action="Type" or action="Paste")
    {
		iniread, option, skeys.ini, %Thishotkey%,option%A_index%
		if(action="Wait")
			sleep, % round(option*1000)
		else  if(action="Open")
		{
			if(SubStr(Option,1,1)=".")
				Option:=UnRelativeate(Option)
			ifexist, %Option%
				run, %option%
			else
				msgbox,, ERROR 404, Does not exist. ;DEBUG
		}
		else if(action="Type" or action="Paste")
		{   stringreplace, option, option,!,{!}, all  
			stringreplace, option, option,#,{#}, all
			stringreplace, option, option,+,{+}, all
			stringreplace, option, option,^,{^}, all
			stringreplace, option, option,{Win,{LWin, all :DEBUG
			Stringreplace, option, option,{Left Click},{LButton}
			Stringreplace, option, option,{Middle Click},{MButton}
			Stringreplace, option, option,{Right Click},{RButton}
			Stringreplace, option, option,{Left Click},{LButton}
			Stringreplace, option, option,% "{Wheel ",% "{Wheel"
			ifinstring, option, {Numpad ;DEBUG
			{
				stringreplace, option, option,% "{Numpad ",% "{Numpad",all
				Stringreplace, option, option,{Numpad.},{NumpadDot},all
				Stringreplace, option, option,{Numpad/},{NumpadDiv},all
				Stringreplace, option, option,{Numpad+},{NumpadAdd},all
				Stringreplace, option, option,{Numpad-},{NumpadDot},all
				Stringreplace, option, option,{NumpadDelete},{NumpadDel},all
				Stringreplace, option, option,{NumpadInsert},{NumpadIns},all
			}
			if(action="Type")
			{
				Send, %option%
			} else if(action="Paste")
			{
				Sendinput, %option%
			}
		}
	}
	else
	{
		ifinstring, action, mute
		{
			action:= action = "Toggle Mute" ? -1 : (action = "Mute" ? 1 : (action = "Unmute" ? 0 : "Fred"))
			SoundSet, %action%,,MUTE
		}
		else
		{
			if(action="Logoff")
				Shutdown,0
			else if(action="Switch User")
				run, %windir%\system32\rundll32.exe user32.dll`,LockWorkStation
			else if(action="Standby")
				DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
			else if(action="Hibernate")
		    {
				Regread, hiberfil, HKLM, SYSTEM\CurrentControlSet\Control\Session Manager\Power, heuristics
				ifinstring, hiberfil, 05000000000101
					DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
			}
			else if(action="Hibernate/Standby")
			{
				Regread, hiberfil, HKLM, SYSTEM\CurrentControlSet\Control\Session Manager\Power, heuristics
				ifinstring, hiberfil, 05000000000101
					DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
				Else
					DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
			}
			else if(action="Restart")
				shutdown, 2
			else if(action="Shutdown")
				shutdown,1
			else if(action="Show Skeys")
				gosub mShowMain
			else if(action="Show Skeys Setup")
				gosub mShowKeysetup
			else if(action="Disable Skeys")
				Suspend, On
			else if(action="Disable this hotkey")
			{
				hotkey, *%Thishotkey%, HotkeyLabel, off
				tempvar:=Activated%vMainList%
				Enabled_%tempvar%=0
				iniwrite, 0, skeys.ini,% Key_%TempVar%,enabled
				IfWinexist, ahk_id %skeys_id%
				{
					gui, submit, nohide
					if(Key_%tempvar%=ThisHotkey)
					{
						guicontrol,, vKeyEnabled, 0
						gosub, gEnableKey
					}
				}
			}
		}}
    }
}
return