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

Key_0=SC16C|SC166|SC132|SC122|SC14c|SC164|SC13c|SC120|SC124|SC130|SC12e|SC110|Sc119|SC16d|SC105|SC121|SC116|SC165
StringSplit, Key_, Key_0, |


;Options and info
setkeydelay,50          ;10 - default, 50 - slow, 100 - really slow, 0 - freakin fast
Setstorecapslockmode, off
VERSION=1.5

;Iniread
iniread, startdisabled, skeys.ini, config, startdisabled, 0
iniread, skipsetup, skeys.ini, config, skipsetup,0
iniread, startintray, skeys.ini, config, startintray, 0
iniread, portable, skeys.ini, config, portable, 0
if(FileExist(A_Startup . "\Skeys.lnk"))
	Startup=1


Loop, %Key_0%
{
	iniread, Nickname_%A_Index%, skeys.ini, % Key_%A_Index%, name, Use this key
	iniread, Enabled_%A_Index%, skeys.ini, Keys, % Key_%A_Index%, 0
}

#include Skeys_menus.ahk

    ;Main GUI
Gui 1: default
Gui, +resize +minsize
Gui, Menu, mainmenu
Gui, add, dropdownlist, w120 r5 vvMainList ggChange altsubmit
Gui, add, groupbox, xp yp+25 w300 h175 vvGroupbox1, Configuration
Gui, add, text, yp+20 xp+5,Name:
gui, add, edit, yp-3 xp+40 w100 limit21 vvNickname gbuttonset
Gui, add, checkbox, xp+130 yp+3 vvKeyEnabled ggEnableKey, Enabled
	gui, font, italic
gui, add, text, xp+75 yp w40 vvScanCode,
	gui, font
gui, add, button, xp-235 yp+30 ggAdd w29 h17,Add
gui, add, button, xp+35 yp ggEdit wp hp,Edit
gui, add, button, xp+35 yp ggDel wp hp,Del
gui, add, button, xp+135 yp vvUp ggUp wp hp,Up
gui, add, button, xp+35 yp vvDown ggDown wp hp,Dn
Gui, add, listview, xp-245 yp+20 w280 r6 vvMainListview nosort -hdr -LV0x10 -multi +LV0x20,Secret|Message   	   ;)

    ;"Key Setup" GUI
Gui 2: +owner1 +E0x40000
Gui 2: -Theme
Gui 2: add, text, hidden x230 y-20
index=1
AtLeastOne=0
loop, 6
{
	Gui 2: add, checkbox,% "0x1000 w100 h20 v" . Key_%index% . " xp-220 yp+25 gmustselectone -wrap checked" . Enabled_%index%,% Nickname_%index%
	AtLeastOne+=Enabled_%index%
	index++
	Gui 2: add, checkbox,% "0x1000 w100 h20 v" . Key_%index% . " xp+110 yp gmustselectone -wrap checked" . Enabled_%index%,% Nickname_%index%
	AtLeastOne+=Enabled_%index%
	index++
	Gui 2: add, checkbox,% "0x1000 w100 h20 v" . Key_%index% . " xp+110 yp gmustselectone -wrap checked" . Enabled_%index%,% Nickname_%index%
	AtLeastOne+=Enabled_%index%
	index++
}
Gui 2: add, groupbox, yp+25 xp-220 w320 h40
Gui 2: add, button, yp+15 xp+10 h17 w30 ggAll, All
Gui 2: add, button, yp xp+35 h17 w37 gGnone, None
Gui 2: add, checkbox,vvAutoCheck xp+80 yp+1 ggAutoCheck,Autocheck
Gui 2: font, w700
Gui 2: Add, button, xp+110 yp-3 h20 w60 default vvDone disabled,Done
if(AtLeastOne)
	guicontrol 2: -disabled, vDone
Gui 2: font
Gui 2: Add, Statusbar,, Press a key to find its button`, right click to give it a nickname
	
    ;Universal GUI. For paths/keystrokes/etc
Gui 3: +toolwindow +sysmenu
Gui 3: margin, 3, 3
Gui 3: add, edit,vvInput w150
Gui 3: add, button, +hidden xp+135 yp hp vvBrowseButton ggBrowseButton,% A_IsUnicode ? "…" : "..."
Gui 3: add, button, x0 y0 w0 h0 ggUniButton default

gosub, ActivateHotkeys
if(startdisabled=1)
    Suspend, on

    ;Initial checks after Menus are made
param=%1%
if(param="/tray" or startintray=1)
	return
if(skipsetup=1)
	goto mShowMain
else
	goto mShowKeysetup