#singleinstance, ignore
#include balloontip.ahk     ;http://www.autohotkey.com/forum/post-254755.html#254755
#include anchor.ahk         ;http://www.autohotkey.net/~Titan/#anchor
SC1=SC16C
sc2=SC166
sc3=SC132
sc4=SC122
sc5=SC14c
sc6=SC164
sc7=SC13c
sc8=SC120
sc9=SC124
sc10=SC130
sc11=SC12e
sc12=SC110
sc13=Sc119
sc14=SC16d
sc15=SC105
sc16=SC121
sc17=SC116
sc18=SC165

  setkeydelay,50          ;10 - default, 50 - slow, 100 - really slow, 0 - freakin fast
  Setstorecapslockmode, off
  SetScrollLockState, off
  SetNumLockState, off

  ;Tray menu
Menu, tray, nostandard
Menu, tray, tip, Skeys v1.0
Menu, tray, add, Enabled, enablehotkeys
Menu, tray, check, Enabled
Menu, tray, default, Enabled
Menu, tray, add,Show, Main
Menu, tray, add,Key Setup, keysetup
Menu, tray, add, Exit, exittime

ifexist, %A_Startup%\Skeys.lnk
  Startup=1
iniread, startdisabled, skeys.ini, config, startdisabled, 0
iniread, skipsetup, skeys.ini, config, skipsetup,0
iniread, startintray, skeys.ini, config, startintray, 0

    ;Menu bar menu
    Menu, Menuu, add, Key setup, keysetup
    Menu, Menuu, add, Exit, exittime
  Menu, mainmenu, add, Menu,:Menuu
    Menu, config, add, Start with Windows, startup
    Menu, config, add, Start Disabled, startdisabled
    Menu, config, add, Skip Setup, skipsetup
    Menu, config, add, Start in tray,startintray
    if(startup=1)
      Menu, config, check, Start with Windows
    if(startdisabled=1) {
      Menu, config, check, Start Disabled
      Menu, tray, uncheck, Enabled
;~       Suspend, on
    }
    if(skipsetup=1)
      Menu, config, check, Skip Setup
    if(startintray=1)
      Menu, config, check, Start in tray
Menu, mainmenu, add, Options, :config
  Menu, help, add, Readme, readme
  Menu, help, add, About, about
Menu, mainmenu, add, Help, :help

    ;Massive "Add" Menu
Menu, add, add, Open file/program, fileprogram
  Menu, powerfunction, add, Logoff, addpower
  Menu, powerfunction, add, Switch User, addpower
  Menu, powerfunction, add, Standby, addpower
  Menu, powerfunction, add, Hibernate, addpower
  Menu, powerfunction, add, Hibernate/Standby, addpower
  Menu, powerfunction, add, Shutdown, addpower
  Menu, powerfunction, add, Restart, addpower
Menu, add, add, Power function, :powerfunction
  Menu, keystrokes, add, Send, keystrokes
  Menu, keystrokes, add, Paste, keystrokes
Menu, add, add, Send keystrokes, :keystrokes
  Menu, volumefunction, add, Mute, generic
  Menu, volumefunction, add, Unmute, generic
  Menu, volumefunction, add, Toggle Mute, generic
  Menu, volumefunction, add, Volume up, generic
  Menu, volumefunction, add, Volume down, generic
Menu, add, add, Volume function, :volumefunction
  Menu, popup, add, Center,popup
  Menu, popup, add, Bottom Right,popup  
  Menu, popup, add, Bottom Left,popup
  Menu, popup, add, Top Right,popup
  Menu, popup, add, Top Left,popup  
Menu, add, add, Popup, :popup
  Menu, skeysstuff, add, Show Skeys, generic
  Menu, skeysstuff, add, Show Skeys Setup, generic
  Menu, skeysstuff, add, Disable Skeys, generic
  Menu, skeysstuff, add, Disable this hotkey, generic
  Menu, skeysstuff, add, Exit Skeys, generic
Menu, add, add, Skeys,:skeysstuff
Menu, add, add, Wait, wait

    ;Massive "Keystrokes" menu
      Menu, Arrows,add,Up,insertspecialkey
      Menu, Arrows,add,Down,insertspecialkey
      Menu, Arrows,add,Left,insertspecialkey
      Menu, Arrows,add,Right,insertspecialkey
    Menu, common, add, Arrows,:arrows
    Menu, common, add, BackSpace,insertspecialkey
    Menu, common, add, Break, insertspecialkey
    Menu, common, add, Delete,insertspecialkey
    Menu, common, add, Enter,insertspecialkey
    Menu, common, add, Escape,insertspecialkey
    Menu, common, add, Insert,insertspecialkey
    Menu, common, add, PrintScreen,insertspecialkey
    Menu, common, add, Space,insertspecialkey
    Menu, common, add, Tab,insertspecialkey
  Menu, functionkeys,add,Common,:common
    loop, 12
    Menu, Fkeys, add,F%A_Index%,insertspecialkey
      loop, 12
      Menu, Fkeysmore, add,% "F" . (A_Index+12),insertspecialkey
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
       Menu, numpadnum, add,% "Numpad " . (A_Index-1),insertspecialkey
    Menu, numpad, add, Numbers, :numpadnum
     Menu, numpadarrow, add, Numpad Up,insertspecialkey
     Menu, numpadarrow, add, Numpad Down,insertspecialkey
     Menu, numpadarrow, add, Numpad Left,insertspecialkey
     Menu, numpadarrow, add, Numpad Right,insertspecialkey
    Menu, numpad, add, Arrows,:numpadarrow
      Menu, numpadmath, add, Numpad .,insertspecialkey
      Menu, numpadmath, add, Numpad *,insertspecialkey
      Menu, numpadmath, add, Numpad /,insertspecialkey
      Menu, numpadmath, add, Numpad +,insertspecialkey
      Menu, numpadmath, add, Numpad -,insertspecialkey
    Menu, numpad, add, Math, :numpadmath
    Menu, numpad, add, Numpad Enter,insertspecialkey
    Menu, numpad, add, Numpad Delete,insertspecialkey
    Menu, numpad, add, Numpad Insert,insertspecialkey
    Menu, numpad, add, Numpad Clear,insertspecialkey
    Menu, numpad, add, Numpad Home,insertspecialkey
    Menu, numpad, add, Numpad End,insertspecialkey
    Menu, numpad, add, Numpad PgUp,insertspecialkey
    Menu, numpad, add, Numpad PgDn,insertspecialkey
  Menu, functionkeys, add, Numpad,:numpad
      Menu, locks, add, Capslock, insertspecialkey
      Menu, locks, add, Numlock, insertspecialkey
      Menu, locks, add, Scrolllock, insertspecialkey
    Menu, toggle, add, (Locks), :locks
      Menu, alt, add, Alt, insertspecialkey
      Menu, alt, add, Alt Down, insertspecialkey
      Menu, alt, add, Alt Up, insertspecialkey
    Menu, toggle, add, Alt, :alt
      Menu, ctrl, add, Control, insertspecialkey
      Menu, ctrl, add, Control Down, insertspecialkey
      Menu, ctrl, add, Control Up, insertspecialkey
    Menu, toggle, add, Control, :ctrl
      Menu, shift,add, Shift, insertspecialkey
      Menu, shift, add, Shift Down, insertspecialkey
      Menu, Shift, add, Shift Up, insertspecialkey
    Menu, toggle, add, Shift, :shift
      Menu, win, add, Win, insertspecialkey
      Menu, win, add, Win Down, insertspecialkey
      Menu, win, add, Win Up, insertspecialkey
    Menu, toggle, add, Win, :win

  Menu, functionkeys, add, Toggle, :toggle
    Menu, brackets, add, {, insertspecialkey
    Menu, brackets, add, },insertspecialkey
  Menu, functionkeys, add, Brackets, :brackets
  Menu, functionkeys, add
  Menu, functionkeys, add, View Readme, exittime
  Menu, functionkeys, disable, View Readme

    ;Main GUI
Gui 1: default
gui, +resize +minsize
Gui, menu, mainmenu
gui, add, dropdownlist, w120 r5 vlisty gchange altsubmit
gui, add,groupbox, xp yp+25 w300 h175 vshakeit, Configuration
Gui, add, text, yp+20 xp+5,Name:
gui, add, edit, yp-3 xp+40 w100 limit21 vnickname gbuttonset
Gui, add, checkbox, xp+130 yp+3 vengable genabled, Enabled
  gui, font, italic
gui, add, text, xp+75 yp w40 vvk,
  gui, font

gui, add, button, xp-235 yp+30 vadd gadd w29 h17,Add
gui, add, button, xp+35 yp vedit gedit wp hp,Edit
gui, add, button, xp+35 yp vdel gdel wp hp,Del
gui, add, button, xp+135 yp vup gup wp hp,Up
gui, add, button, xp+35 yp vdown gdown wp hp,Dn
Gui, add, listview, xp-245 yp+20 w280 r6 vlouis nosort -hdr -LV0x10 -multi +LV0x20,CS Lewis|Is amazing       ;)

    ;"Key Setup" GUI
index=1
gui 7: +owner1 +E0x40000
Gui 7: -Theme
gui 7: add, text, hidden x230 y-20, Jon Petraglia
loop, 6
{
  tempy:=SC%index%
  gui 7: add, checkbox,0x1000 w100 h20 v%tempy% xp-220 yp+25 gmustselectone -wrap,% %Tempy%_nick
  index++
  tempy:=SC%index%
  gui 7: add, checkbox,0x1000 w100 h20 v%tempy% xp+110 yp gmustselectone -wrap,% %Tempy%_nick
  index++
  tempy:=SC%index%
  gui 7: add, checkbox,0x1000 w100 h20 v%tempy% xp+110 yp gmustselectone -wrap,% %Tempy%_nick
  index++
}
gui 7: add, groupbox, yp+25 xp-220 w320 h40
GUi 7: add, button, yp+15 xp+10 h17 w30 gall, All
GUi 7: add, button, yp xp+35 h17 w37 gnone, None
gui 7: add, checkbox,vautoit xp+80 yp+1 gautoit,Autocheck
Gui 7: font, w700
Gui 7: Add, button, xp+110 yp-3 h20 w60 default vdone disabled,Done

    ;Universal GUI. For paths/keystrokes/etc
gui 8: +toolwindow +syswindow +owner1
gui 8: margin, 3, 3
gui 8: add, edit,vminput w150
Gui 8: add, button, +hidden xp+135 yp w15 hp vbrowseb gbrowseb,…
gui 8: add, button, x0 y0 w0 h0 gmbutton default

gosub, activatehotkeys
if(startdisabled=1)
    Suspend, on

    ;Initial checks after Menus are made
param=%1%
if(param="/tray" or startintray=1) {
  return
}
if(skipsetup=1)
  goto main

keysetup:

  ;Gets position of Skeyss main window if it already exists
Wingetpos,guix,guiy,,,ahk_id %skeys_id%
if(guix!="") {
  guix=x%guix%
  guiy=y%guiy%
}
gui 1: hide

  ;Look to check if each is enabled or has a nickname
loop, 18 {
  iniread, tempy, skeys.ini, Keys,% SC%A_Index%, durrrr
  if(tempy=1)
    guicontrol 7:,% SC%A_INDEX%,1
  iniread, tempy, skeys.ini, % sc%A_Index%, name, Use this key
  if(tempy=SC%A_Index%)
    tempy=Use this key
  guicontrol, 7:,% SC%A_Index%,%tempy%
}
gosub mustselectone

if(winexist("ahk_id " . setup_id))
  { winactivate, ahk_id %setup_id%
    gosub setupkeycapture
    Return
  }

gui 7: show,%guix% %guiy%, Skeys Key Setup
gui 7: +Lastfound
setup_id:=WinExist()
gosub setupkeycapture

Menu, nickname, add,% "  Nickname  ",Nickname
                                                  Menu, nickname, color, white
return

Main:
gui 7: hide
LV_Modifycol(1,70)
LV_Modifycol(2,100)

gosub, ddl_string
gosub change

if(winexist("ahk_id " . skeys_id))
{   winactivate, ahk_id %skeys_id%
    Return
}

if(ifmax=1)
  gui 1: show, maximize, Skeys
else
  gui 1: show, autosize %guix% %guiy%,Skeys
gui 1: +lastfound
skeys_id:=WinExist()
return

mustselectone:
gui 7: submit, nohide
Loop, 18
{   tempy:=SC%A_Index%
    if(%TEmpy%)=1 {  
      guicontrol 7: enabled,done
      Return
    }
}
guicontrol 7: disabled,done
return


Guisize:
anchor("shakeit","wh")
anchor("louis","wh")
anchor("up","x")
anchor("down","x")
anchor("vk","x")
gui 1: default
LV_Modifycol(2,"autohdr")
return

Startdisabled:
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

skipsetup:
if(skipsetup=1)
{   Menu, config, uncheck,Skip Setup
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

Startintray:
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


startup:
if(startup=1)
{   Menu, config, uncheck, Start with Windows
    ifexist, %A_Startup%\Skeys.lnk
      FileDelete, %A_Startup%\Skeys.lnk
    startup=0
}
else
{   Menu, config, check, Start with Windows
    Filecreateshortcut,%A_Scriptfullpath%,%A_Startup%\Skeys.lnk,%A_WorkingDir%,/tray,Special Keys customizer
    startup=1
}
return

setupkeycapture:
loop,18
{   tempy:=SC%A_Index%
    Hotkey, IfWinActive, ahk_id %setup_id%
    Hotkey, %tempy%,SC,on
    %tempy%_yesorno:="yes"
    iniread, %Tempy%_nick,skeys.ini,% sc%A_Index%, name, Use this key
}
return
;~ Don't need???
;~   gosub, activatehotkeys
;~ return

about:
gui 18: default
gui, +owner1 +toolwindow
gui, margin, 3,3
gui,add, picture, icon1 x5 y5 h32 w32, %A_Scriptname%
Gui, font, w700 underline
Gui, add, text, xp+36 yp+3,Skeys v1.0
Gui, font
Gui, add, text, xp yp+17 w145 r1,Skeys is made specifically
gui, add, text, xp-33 yp+15 w180 h60,for "Special keys" (where Skeys`ngets its name)`, and the ability to`ncustomize them to your liking.`nFeedback is encouraged.
Gui, font, underline
gui, add, text, xp+10 yp+60 gReadme, Readme
  gui, add, text, xp+45, |
gui, font, CBlue
Gui, add, text, xp+10 gwebsite,Website
  gui, add, text, xp+45, |
Gui, add, text, xp+10 gemail,Email
gui, show, w170, About Skeys
return

website:
run, http://www.FreewareWire.blogspot.com
Return

email:
run, mailto:FreewareWire@gmail.com
return

readme:
ifexist, readme.txt
  run readme.txt
return

18guiclose:
gui 18: destroy
return

ddl_string:
ddl_string=
bubba=1
loop, 18 {
  iniread, tempy, skeys.ini, Keys,% SC%A_Index%,0
  if(tempy=1) {
    activate%bubba%:=sc%A_Index%
    iniread, name%bubba%, skeys.ini,% SC%A_Index%,name,% SC%A_Index%
    iniread, en%Bubba%, skeys.ini,% SC%A_Index%,enabled,0
    ddl_string:= ddl_string  . name%bubba% . "|"
    bubba++
  }
}
stringreplace, ddl_string, ddl_string, |, ||
guicontrol 1:,listy, |
guicontrol 1:,listy, %ddl_string%
return

insertspecialkey:
gui 8: submit, nohide
guicontrol 8:,minput,%minput%{%A_ThisMenuItem%}
return

updateOptions() {
global
gui 1: submit, nohide
Loop,% LV_GetCount()
{   LV_GetText(entry,A_Index)
   ; index:=GetIt()
    iniwrite, %entry%, skeys.ini,% activate%listy%,Entry%A_INDEX%
    if(entry="Open" or entry="Wait" or entry="Send" or entry="Paste")
    { LV_GetText(option,A_Index,2)
      iniwrite, %option%, skeys.ini,% activate%listy%,Option%A_INDEX%  
    }
    Else
      inidelete, skeys.ini, % activate%listy%, Option%A_index%
}
LV_Modifycol(1,"autohdr")
LV_modifycol(2,"autohdr")
}

addit(addit,editit = 0,options = 0)
  {  global minput
    gui 8: submit, nohide   
    if(minput="")
    Return
    gui 8: hide
    gui 1: default
    if(editit=0)
      LV_Add("",addit,minput)
    Else
      LV_Modify(editit,"",addit,options)
    updateOptions()
  }

enablehotkeys:
Menu, tray, togglecheck, Enabled
Suspend, Toggle
return

fileprogram:
  gosub=addfileprogram
  guicontrol 8:-Number +limit100,minput
  guicontrol 8:,minput
  guicontrol 8:move,minput,w135
  guicontrol 8:, browseb,…
  guicontrol 8:-hidden,browseb
  gui 8: +owndialogs
  gui 8: show, autosize, Add File/Program
  Return
  browseb:
  gui 8: submit, nohide
  if(gosub="addfileprogram" or editit="Open") {
  Fileselectfile, outputfile, 35,,Select file/program, Programs (*.exe)
  if(outputfile!="")
    guicontrol 8:,minput, %outputfile%
  SplitPath, outputfile,,,ext
  if(ext="exe")
    BalloonTip("","If your program has any parameters, pass them at the end!",3000)
  }
  else if(gosub="addkeystrokes" or editit="Send" or editit="Paste") {
    Guicontrolget, pos, pos,browseb
    posx+=18
    posy+=18
    Menu, functionkeys, show, %posx%, %posy%
  }
;    balloontip("Legend",Balloonmsg,100000)
  return
  addfileprogram:
  addit("Open")
  return

  return
  
  checkpower() {
    gui 1: default
    Loop,% LV_GetCount()
    {   LV_GetText(tempy,A_Index)
        if(tempy="Hibernate" or tempy="Standby" or tempy="Hibernate (S)" or tempy="Shutdown" or tempy="Restart")
          return 1
    }
    return, 0
  }
  addpower:
   if(checkPower()=1) {
    msgbox, 16, Multiple power options, You can only have one power option per key!
    Return
    }
  LV_Add("",A_Thismenuitem)
  updateOptions()
  return 
  
 
keystrokes:
  gosub=addkeystrokes
  sendpaste:=A_Thismenuitem
  guicontrol 8:,minput,
  guicontrol 8:+limit100 -number,minput,
  guicontrol 8:move,minput,w135
  guicontrol 8:-hidden,browseb,
  guicontrol 8:,browseb,+    ;?
  gui 8: show,autosize,Add %Sendpaste%
  return
  addkeystrokes:
  gui 8: submit, nohide
  if(minput="")
    return
  gui 8: hide
  gui 1: default
  LV_Add("",sendpaste,minput)
  updateOptions()
  return

getcaps(input) {
  Stringsplit, capsarray, input, %A_space%
  output=
  Loop,
  { if(capsarray%A_Index%="")     
      Break
    Stringsplit,output,capsarray%A_Index%
    output:=output . output1
    capsarray%A_Index%=
  }
  return, %output%
}
  

popup:
gui 1: default
loop, % LV_GetCount()
{  LV_GetText(tempy,A_index)
  ifinstring, tempy, popup
  { msgbox,16,Only one popup allowed, Only one popup is allowed per key!
    Return
  } 
}
LV_ADD("","Popup (" . getcaps(A_Thismenuitem) . ")")
updateoptions()
LV_Modifycol(1,"autohdr")
return
 
 Generic:
 LV_ADD("",A_ThisMenuItem)
 updateoptions()
 return
 
wait:
Guicontrol 8:+Number +limit20,minput,
Guicontrol 8:,minput,
gosub=addwait
gui 8: show,,Add Wait
return
  addwait:
  addIt("Wait")
  return

del:
gui 1: submit, nohide
deleteIt:=LV_GetNext()
LV_Delete(deleteIt)
ifequal, deleteIt, % LV_GetCount() + 1
 LV_Modify(deleteIT - 1, "Select")
Else
 LV_Modify(deleteIt, "Select")
updateOptions()
;index:=getIt()
Inidelete, skeys.ini, % activate%listy%, % "Entry" . (LV_GetCount()+1)
Inidelete, skeys.ini, % activate%listy%, % "Option" . (LV_GetCount()+1)
return

editit:
gui 8: submit
addit(editit,rownum,minput)
return
edit:
gui 1: default
rownum:=LV_GetNext()
LV_GetText(editit,rownum,1)
if(editit!="Wait" and editit!="Open" and editit!="Send" and editit!="Paste")
  return
  
if(edidit="Wait")
{  guicontrol 8:+limit20, minput
  guicontrol 8:+number, minput
} else {
  if(editit="Open")
  {  guicontrol 8:+limit20, minput
    guicontrol 8:move,minput,w135 
    guicontrol 8:-hidden,browseb
  } else {
    If(editit="Send" or editit="Paste")
    guicontrol 8: +limit100,minput
    guicontrol 8:move,minput,w135 
    guicontrol 8:-hidden,browseb
    guicontrol 8:,browseb,+     ;?
  }
}
gosub=editit
LV_GetText(tempy,rownum,2)
guicontrol 8:,minput,%tempy%
gui 8: show,autosize, Edit entry
return

up:
simplemove("up")
updateOptions()
return
down:
simplemove("down")
updateOptions()
Return

simplemove(direction){
   if direction=down
    linus=-1
   else
    if direction=up
     linus=1
    else
     return
   selectedCount := LV_GetCount("Selected")
   totalCount := LV_GetCount()
   if not selectedCount
     Return
   RowNumber := LV_GetNext(RowNumber)
   if (rownumber=1 and direction=="up")
     return
   if (rownumber=LV_GetCount() and direction="down")
     return
   ifequal, selectedcount,% LV_GetNext(selectedcount-1,"Checked")
    checkit:= rownumber - linus
   Else
    checkit=0
   LV_GetText(entry, rownumber,1)
   LV_GetText(option, rownumber,2)
   LV_Delete(rownumber)
   LV_Insert(rownumber - linus,"select",entry,option)
   if(checkit>0)
    LV_modify(checkit,"Check")
  }


nickname:
  guicontrol 8:-Number +limit21,minput
Guicontrol 8:,minput,% %control%_nick
gosub=setnewnick
gui 8: show,,% "Change nick: " . %control%_nick
return

mbutton:
gosub %gosub%
8guiclose:
gui 8: hide
guicontrol 8:move,minput,w150
guicontrol 8:+hidden, browseb
editit=
return

setnewnick:
gui 8: submit
Guicontrol 8:,minput,
%control%_nick:=minput
if(%control%_nick="")
{  guicontrol 7:,%control%,Use this key
   inidelete,skeys.ini,%control%,name
} else {
  guicontrol 7:,%control%,%minput%
  iniwrite,%minput%,skeys.ini,%control%, name
}
return

change:
gui 1: submit, nohide
gui 1: default
LV_Delete()
tempy:=en%listy%
guicontrol 1:,engable,%tempy%
tempy:=name%listy%
guicontrol 1:,nickname,%tempy%
;index:=getIt()
guicontrol 1:,vk,% activate%Listy%
Loop,
{ iniread, entry, skeys.ini,% activate%listy%, entry%A_INDex%
  if(entry="ERROR")
      Break
  if(entry="Open" or entry="Wait" or entry="Send" or entry="Paste")
  {   iniread, Option, skeys.ini, % activate%listy%, option%A_Index%
      LV_ADD("",entry,option)
  } Else
      LV_ADD("",entry)
}
LV_Modifycol(1,"autohdr")
LV_modifycol(2,"autohdr")
gosub enabled
return

7guicontextmenu:
loop, 18
{   if(A_Guicontrol=sc%A_Index%) {
      control:=A_GuiControl
                                        Guicontrolget, pos, pos, %control%
                                        posx+=3
                                        posy+=42
      Menu, nickname, show              , %posx%, %posy%
      Break
    }
}
return

buttonset:
gui 1: submit, nohide
name%listy%:=nickname
Stringsplit, array, name%listy%
;~ index:=getIt()
if(nickname="")
  nickname:=activate%listy%
if(nickname!=Varit(activate%listy%))
  iniwrite,%nickname%,skeys.ini, % activate%listy%,name
Else
  inidelete, skeys.ini, % activate%listy%,name
Stringreplace, ddl_string, ddl_string,||,|
stringSplit, ddl_string, ddl_string,|
ddl_string%listy%:=nickname . "|"
ddl_string=
loop,
{ if(ddl_string%A_index%="")  
      Break
    ddl_string:=ddl_string . ddl_string%A_Index% . "|"
    ddl_string%A_Index%=
}
guicontrol 1:, listy, |
guicontrol 1:, listy, %ddl_string%
return

varit(var) {
  return %var%
}

all:
Loop, 18
  guicontrol 7:,% SC%A_index%,1
guicontrol 7: enabled,done
;~ guicontrol 7: ,done,Done
return
None:
Loop, 18
  guicontrol 7:,% SC%A_index%,0
guicontrol 7: disabled,done
;~ guicontrol 7: ,done,Exit
return


autoit:
gui 7: submit, nohide
return


add:
Menu, add, show, 55, 121
return


enabled:
gui 1: submit, nohide
if(engable=1) {
  en%listy%=1
  ;index:=GetIt()
  iniwrite, 1, skeys.ini,% activate%listy%,enabled
  hotkey, ifwinactive
  Hotkey,% activate%listy%, Scforizzle, on
  guicontrol 1: enable, add 
  guicontrol 1: enable, edit
  guicontrol 1: enable, del
  guicontrol 1: enable, up
  guicontrol 1: enable, down
  guicontrol 1: enable, louis
} else {
  en%listy%=0
;~     index:=GetIt()
  iniwrite, 0, skeys.ini,% activate%listy%,enabled
;~   Used to be SC%Listy%
  Hotkey, ifwinactive
  Hotkey,% activate%listy%, Scforizzle, off
  guicontrol 1: disable, add 
  guicontrol 1: disable, edit
  guicontrol 1: disable, del
  guicontrol 1: disable, up
  guicontrol 1: disable, down
  guicontrol 1: disable, louis
}
return

activatehotkeys:
loop,18
{  iniread, yesorno, skeys.ini,keys, % SC%A_Index%,0  
    if(yesorno=1) {
      tempy:=SC%A_Index%
      hotkey, ifwinactive
      Hotkey, %tempy%,SCforizzle, on
    }
    else {
      tempy:=SC%A_Index%
      Hotkey, %tempy%,SCforizzle, off
    }
}
return
disablehotkeys:
loop, 18
{   tempy:=SC%A_Index%
    hotkey, %tempy%, off
}
return

showpopup:
settimer, showpopup,off
if(posx!=0 and posx!="") {
  DetectHiddenWindows, on
  gui 50: show,%posy% %posx% hide
  Wingetpos,,,wid,,ahk_id %fitty_id%
  posx-=wid+2
  DetectHiddenWindows, off
}
if(posx!="")
  posx:="x" . posx
gui 50: show, hide %posy% %posx%
DllCall("AnimateWindow","UInt",fitty_id,"Int",250,"UInt",sunrise)
nowait=0
settimer, destroypopup, 1000
return
destroypopup:
settimer,destroypopup, off
if(nowait=1)
  return
DllCall("AnimateWindow","UInt",fitty_id,"Int",250,"UInt",sunset)
gui 50: destroy
nowait=0
return

SCFoRizzle:
Loop, 
{   iniread, action, skeys.ini, %A_thishotkey%,entry%A_Index%
    if(action="" or action="ERROR")
      Break
    if(action="Exit Skeys")
      ExitApp
    ifinstring, action, Popup
    {   wingetpos,,,tskbrw, tskbrh, ahk_class Shell_TrayWnd
        iniread, popuptext,skeys.ini,%A_Thishotkey%,name,Skeys v1.0
        ifnotinstring, action, C
        {   ifinstring, action,B
            { sunrise=0x60008
              sunset=0x50004
              posy:="y" . (A_Screenheight-tskbrh-24-2)
            }
            Else ifinstring, action, T
            { sunrise=0x40004
              sunset=0x50008
              posy=y0
            }
            ifinstring, action,R
              posx:=A_screenwidth
            Else ifinstring, action, L
              posx=0
        } else
        { sunrise=0x60010
          sunset=0x50010
          posx:=
          posy:=
        }
        ifwinexist,ahk_id %fitty_id%
          nowait=1
        gui 50: destroy
        gui 50: -caption +alwaysontop +toolwindow   
        gui 50: margin, 2, 2
        gui 50: +lastfound
        fitty_id:=WinExist()
        gui 50: add, picture, w24 h24 icon1,%A_Scriptfullpath%
        gui 50: font, w700
        Gui 50: add, text, xp+27 yp+5,%popuptext%         ;yp
        gui 50: font
        settimer, showpopup, 1 ;000
    }
    else {
    if(action="Wait" or action="Open" or action="Send" or action="Paste")
    {   iniread, option, skeys.ini, %A_Thishotkey%,option%A_index%
        if(action="Wait")
          sleep, % round(option*1000)
        else  if(action="Open")
              {  ;ifexist, %tempyarray1%
                  run, %option%
              }
              else if(action="Send" or action="Paste")
              {   stringreplace, option, option,!,{!}, all  
                  stringreplace, option, option,#,{#}, all
                  stringreplace, option, option,+,{+}, all
                  stringreplace, option, option,^,{^}, all
                  stringreplace, option, option,{Win,{LWin, all
;~                   Stringreplace, option, option,{Left Click},{LButton}
;~                   Stringreplace, option, option,{Middle Click},{MButton}
;~                   Stringreplace, option, option,{Right Click},{RButton}
;~                   Stringreplace, option, option,{Left Click},{LButton}
;~                   Stringreplace, option, option,% "{Wheel ",% "{Wheel"
                  ifinstring, option, {Numpad
                  {   stringreplace, option, option,% "{Numpad ",% "{Numpad",all
                      Stringreplace, option, option,{Numpad.},{NumpadDot},all
                      Stringreplace, option, option,{Numpad/},{NumpadDiv},all
                      Stringreplace, option, option,{Numpad+},{NumpadAdd},all
                      Stringreplace, option, option,{Numpad-},{NumpadDot},all
                      Stringreplace, option, option,{NumpadDelete},{NumpadDel},all
                      Stringreplace, option, option,{NumpadInsert},{NumpadIns},all
                  }
                  
                  if(action="Send") {
                    Send, %option%
                  } else if(action="Paste") {
                         Sendinput, %option%
                         }
      }
      }
   else {
      ifinstring, action, mute
      {   action:= action = "Toggle Mute" ? -1 : (action = "Mute" ? 1 : (action = "Unmute" ? 0 : "Fred"))
          SoundSet, %action%,,MUTE
      } else {
    
        if(action="Logoff")
          Shutdown,0
        else if(action="Switch User")
                run, %windir%\system32\rundll32.exe user32.dll`,LockWorkStation
             else if(action="Standby")
                    DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
                  else if(action="Hibernate")
                       {  Regread, hiberfil, HKLM, SYSTEM\CurrentControlSet\Control\Session Manager\Power, heuristics
                          ifinstring, hiberfil, 05000000000101
                          DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
                        }
                      else if(action="Hibernate/Standby")
                           {  Regread, hiberfil, HKLM, SYSTEM\CurrentControlSet\Control\Session Manager\Power, heuristics
                              ifinstring, hiberfil, 05000000000101
                                DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
                              Else
                                DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
                           }
                            else if(action="Restart")
                                    shutdown,2
                                 Else if(action="Shutdown")
                                        shutdown,1
                                      else if(action="Show Skeys")
                                              gosub main
                                           else if(action="Show Skeys Setup")
                                                  gosub keysetup
                                                else if(action="Disable Skeys")
                                                       Suspend, On
                                                      else if(action="Disable this hotkey")
                                                              hotkey, %A_Thishotkey%, off
                                      
    } }
    }
}


return
SC:
Suspend, permit
tempy:=%A_thishotkey%_yesorno
if(tempy="yes")
{   tempy:=%A_Thishotkey%_nick
    guicontrol 7:,%A_Thishotkey%,!!!%tempy%!!!
    %A_thishotkey%_yesorno:="no"
} else {
  tempy:=%A_Thishotkey%_nick
  guicontrol 7: ,%A_Thishotkey%,%tempy%
  %A_thishotkey%_yesorno:="yes"
}
if(autoit=1)
{  guicontrol 7:,%A_Thishotkey%,1
   gosub mustselectone
}

return



7ButtonDone:
Wingetpos,guix,guiy,,,ahk_id %setup_id%
if(guix!="") {
  guix=x%guix%
  guiy=y%guiy%
}
gui 7: submit
gui 8: hide

Loop, 18
{ tempy:= SC%A_Index%
  if(%tempy%=1)   
      iniwrite, 1, skeys.ini, Keys,% SC%A_index%
    Else
      iniwrite, 0, skeys.ini, Keys,% SC%A_index%
}
gosub, activatehotkeys
goto, main

guiclose:
Winget,ifmax,Minmax, ahk_id %skeys_id%
gui 1: hide
gui 8: hide
;~ gosub activatehotkeys
return
7guiclose:
gui 8: hide
gui 7: hide
gosub activatehotkeys
return
exittime:
exitapp