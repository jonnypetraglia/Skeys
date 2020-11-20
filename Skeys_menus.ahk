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
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Menu~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;Tray menu
if(A_IsCompiled)
{	Menu, tray, nostandard
	Menu, tray, icon, %A_Scriptfullpath%
}
Menu, tray, tip, Skeys v%VERSION%
Menu, tray, add, Enabled, mEnableHotkeys
Menu, tray, check, Enabled
Menu, tray, default, Enabled
Menu, tray, add,Show, mShowMain
Menu, tray, add,Key Setup, mShowKeysetup
Menu, tray, add, Exit, exittime

	;Main Menu
	Menu, MenuMenu, add, Key setup, mShowKeysetup
	Menu, MenuMenu, add, Exit, exittime
Menu, MainMenu, add, Menu,:MenuMenu
    Menu, Config, add, Start with Windows, mStartup
    Menu, Config, add, Start Disabled, mStartDisabled
    Menu, Config, add, Skip Setup, mSkipSetup
    Menu, Config, add, Start in tray,mStartintray
	Menu, Config, add, Portable, mPortable
Menu, mainmenu, add, Options, :config
	Menu, help, add, Check for update, Update
	Menu, help, add, Readme, gmReadme
	Menu, help, add, About, ShowAbout
Menu, mainmenu, add, Help, :help

	if(startup=1)
		Menu, config, check, Start with Windows
	if(startdisabled=1)
	{
		Menu, config, check, Start Disabled
		Menu, tray, uncheck, Enabled
	;~       Suspend, on		;DEBUG?
	}
	if(skipsetup=1)
		Menu, config, check, Skip Setup
	if(startintray=1)
		Menu, config, check, Start in tray
	if(Portable=1)
	{
		Menu, config, check, Portable
		Menu, config, disable, Start with Windows
	}

    ;Massive "Add" Menu
Menu, add, add, Open file/program, mFileProgram
	Menu, powerfunction, add, Logoff, mAddpower
	Menu, powerfunction, add, Switch User, mAddpower
	Menu, powerfunction, add, Standby, mAddpower
	Menu, powerfunction, add, Hibernate, mAddpower
	Menu, powerfunction, add, Hibernate/Standby, mAddpower
	Menu, powerfunction, add, Shutdown, mAddpower
	Menu, powerfunction, add, Restart, mAddpower
Menu, add, add, Power function, :powerfunction
	Menu, keystrokes, add, Type, mKeystrokes
	Menu, keystrokes, add, Paste, mKeystrokes
Menu, add, add, Send keystrokes, :keystrokes
	Menu, volumefunction, add, Mute, mGeneric
	Menu, volumefunction, add, Unmute, mGeneric
	Menu, volumefunction, add, Toggle Mute, mGeneric
	Menu, volumefunction, add, Volume up, mGeneric
	Menu, volumefunction, add, Volume down, mGeneric
Menu, add, add, Volume function, :volumefunction
	Menu, popup, add, Center, mPopup
	Menu, popup, add, Bottom Right, mPopup
	Menu, popup, add, Bottom Left, mPopup
	Menu, popup, add, Top Right, mPopup
	Menu, popup, add, Top Left, mPopup 
Menu, add, add, Popup, :popup
	Menu, skeysstuff, add, Show Skeys, mGeneric
	Menu, skeysstuff, add, Show Skeys Setup, mGeneric
	Menu, skeysstuff, add, Disable Skeys, mGeneric
	Menu, skeysstuff, add, Disable this hotkey, mGeneric
	Menu, skeysstuff, add, Exit Skeys, mGeneric
Menu, add, add, Skeys,:skeysstuff
Menu, add, add, Wait, mWait

    ;Massive "Keystrokes" menu
      Menu, Arrows,add,Up, mInsertspecialkey
      Menu, Arrows,add,Down, mInsertspecialkey
      Menu, Arrows,add,Left, mInsertspecialkey
      Menu, Arrows,add,Right, mInsertspecialkey
    Menu, common, add, Arrows,:arrows
    Menu, common, add, BackSpace, mInsertspecialkey
    Menu, common, add, Break, mInsertspecialkey
    Menu, common, add, Delete, mInsertspecialkey
    Menu, common, add, Enter, mInsertspecialkey
    Menu, common, add, Escape, mInsertspecialkey
    Menu, common, add, Insert, mInsertspecialkey
    Menu, common, add, PrintScreen, mInsertspecialkey
    Menu, common, add, Space, mInsertspecialkey
    Menu, common, add, Tab, mInsertspecialkey
  Menu, functionkeys,add,Common,:common
    loop, 12
    Menu, Fkeys, add,F%A_Index%, mInsertspecialkey
      loop, 12
      Menu, Fkeysmore, add,% "F" . (A_Index+12), mInsertspecialkey
    menu, fkeys, add, More, :fkeysmore
  Menu, functionkeys, add, F keys, :fkeys
    ;Mouse gestures, for future release...
;~     Menu, mouse, add, Left Click, insertspecialkey
;~     Menu, mouse, add, Right Click, insertspecialkey
;~     Menu, mouse, add, Middle Click, insertspecialkey
;~     Menu, mouse, add, Wheel up, insertspecialkey
;~     Menu, mouse, add, Wheel down, insertspecialkey
;~     Menu, mouse, add, Wheel left, insertspecialkey
;~     Menu, mouse, add, Wheel right, insertspecialkey
    
     loop, 10
       Menu, numpadnum, add,% "Numpad " . (A_Index-1), mInsertspecialkey
    Menu, numpad, add, Numbers, :numpadnum
     Menu, numpadarrow, add, Numpad Up,mInsertspecialkey
     Menu, numpadarrow, add, Numpad Down,mInsertspecialkey
     Menu, numpadarrow, add, Numpad Left,mInsertspecialkey
     Menu, numpadarrow, add, Numpad Right,mInsertspecialkey
    Menu, numpad, add, Arrows,:numpadarrow
      Menu, numpadmath, add, Numpad .,mInsertspecialkey
      Menu, numpadmath, add, Numpad *,mInsertspecialkey
      Menu, numpadmath, add, Numpad /,mInsertspecialkey
      Menu, numpadmath, add, Numpad +,mInsertspecialkey
      Menu, numpadmath, add, Numpad -,mInsertspecialkey
    Menu, numpad, add, Math, :numpadmath
    Menu, numpad, add, Numpad Enter,mInsertspecialkey
    Menu, numpad, add, Numpad Delete,mInsertspecialkey
    Menu, numpad, add, Numpad Insert,mInsertspecialkey
    Menu, numpad, add, Numpad Clear,mInsertspecialkey
    Menu, numpad, add, Numpad Home,mInsertspecialkey
    Menu, numpad, add, Numpad End,mInsertspecialkey
    Menu, numpad, add, Numpad PgUp,mInsertspecialkey
    Menu, numpad, add, Numpad PgDn,mInsertspecialkey
  Menu, functionkeys, add, Numpad,:numpad
      Menu, locks, add, Capslock, mInsertspecialkey
      Menu, locks, add, Numlock, mInsertspecialkey
      Menu, locks, add, Scrolllock, mInsertspecialkey
    Menu, toggle, add, (Locks), :locks
      Menu, alt, add, Alt, mInsertspecialkey
      Menu, alt, add, Alt Down, mInsertspecialkey
      Menu, alt, add, Alt Up, mInsertspecialkey
    Menu, toggle, add, Alt, :alt
      Menu, ctrl, add, Control, mInsertspecialkey
      Menu, ctrl, add, Control Down, mInsertspecialkey
      Menu, ctrl, add, Control Up, mInsertspecialkey
    Menu, toggle, add, Control, :ctrl
      Menu, shift,add, Shift, mInsertspecialkey
      Menu, shift, add, Shift Down, mInsertspecialkey
      Menu, Shift, add, Shift Up, mInsertspecialkey
    Menu, toggle, add, Shift, :shift
      Menu, win, add, Win, mInsertspecialkey
      Menu, win, add, Win Down, mInsertspecialkey
      Menu, win, add, Win Up, mInsertspecialkey
    Menu, toggle, add, Win, :win

  Menu, functionkeys, add, Toggle, :toggle
    Menu, brackets, add, {, mInsertspecialkey
    Menu, brackets, add, },mInsertspecialkey
  Menu, functionkeys, add, Brackets, :brackets
  Menu, functionkeys, add
  Menu, functionkeys, add, View Readme, gmReadme
  Menu, functionkeys, disable, View Readme
 