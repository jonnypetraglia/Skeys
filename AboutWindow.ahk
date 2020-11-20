/*
About_Name=
About_Version=
About_DateLaunch=
About_Date=
About_CompiledDate=

#include AboutWindow.ahk
*/
return

ShowAbout:
if(About_Name="Randomizer")
	Gui 99: +toolwindow
else
	Gui 99: +toolwindow +owner1
Gui 99: color, white
Gui 99: margin, 16, 16
Gui 99: add, picture, x16 y16 w128 h128 Icon2, %A_ScriptFullPath%
Gui 99: Font, c494949 s30 w600, Verdana		;333333 444444 494949
Gui 99: add, text, xp+150 yp-10, %About_Name%
Gui 99: Font
Gui 99: add, text, xp+10 yp+50,% "Version " . About_Version . "  " . (A_PtrSize ? "–" : "-") . "  released " . About_CompiledDate
								. "`nCreated with Autohotkey version " . A_AHKVERSION . (A_PtrSize = 4 ? "L x86" : (A_PtrSize = 8 ? "L x64" : ""))
								. "`nCopyright " . (A_PtrSize ? "© " : "") . About_DateLaunch . (About_Date ? "-" . About_Date : "") . " Qweex"
								. "`nDistributed under the GPLv3"
								. "`n" . (LAND && LANG!="English" ? ("Translated into " . LANG . " by ") : "") . @Translator
Gui 99: font,CBlue Underline s11
Gui 99: Add, text, xp-10 yp+76 gQweexWebsite, www.Qweex.com
Gui 99: Add, text, xp yp+16 gQweexEmail, MrQweex@qweex.com
Gui 99: font
if(About_Message)
	Gui 99: add, text, x32 yp+30 w400, %About_Message%
Gui 99: Show,% "Autosize " . (About_X ? ("x" . About_X) : "") . (About_Y ? ("x" . About_Y) : ""), About %About_Name%
return

99GuiClose:
if(About_Name="Randomizer")
	exitapp
Gui 99: Destroy
return

QweexWebsite:
	run, http://www.qweex.com
return

QweexEmail:
	run mailto:contact@qweex.com
return