/*
BalloonTip2("This is a BalloonTip Test.", 100 ,10, "Hy", 1)

Sleep, 20000
ExitApp
*/

;hicon = 1 for i; 2 for !; 3 for x; 7 for ?
BalloonTip2(sText, xpos, ypos, sTitle = "", hIcon=0, hBGRcolor="")
{
    Old_DetectHiddenWindows := A_DetectHiddenWindows
    DetectHiddenWindows, On
	
    hWnd := DllCall("CreateWindowEx","Uint", 0x8,"str", "tooltips_class32","Uint", 0,"Uint", 0xC3,"int", 0,"int", 0,"int", 0,"int", 0,"Uint", 0,"Uint", 0,"Uint", 0,"Uint", 0)
	
	VarSetCapacity(ti, 40, 0)						;Set aside 40 bytes in ti
    ti := Chr(40)
	
	
	;ti = '('
										;Destination	;Length		;Content
    DllCall("ntdll\RtlFillMemoryUlong", "Uint", &ti + 4,"Uint", 4, "Uint", 0x20)							;Contents

	;ti = '( '

    DllCall("ntdll\RtlFillMemoryUlong","Uint", &ti +36,"Uint", 4,"Uint", &sText)
			
	;ti = '( &'
	
	;SB_SetParts - 0x404
    SendMessage, 0x404, 0, &ti,, ahk_id %hWnd%		;Send 1028(0, &) to BalloonTip 
	
	;TTM_TRACKACTIVATE - 0x411
    SendMessage, 0x411, 1, &ti,, ahk_id %hWnd%		;Send 1041(1, &) to BalloonTip
	
	;TTM_TRACKPOSITION - 0x412
    SendMessage, 0x412, 0, xpos | ypos << 16,, ahk_id %hWnd% ;Send 1042(0, xpos | ypos << 16) to BalloonTip
	
	
    ;If hBGRcolor {
    ;    SendMessage, 1043, hBGRcolor, 0,, ahk_id %hWnd%
    ;    SendMessage, 1044,~hBGRcolor & 0xFFFFFF, 0,, ahk_id %hWnd%
    ;  }
	
	TTM_SETTITLE := A_IsUnicode ? 1057 : 1056
	;If sTitle
		SendMessage, TTM_SETTITLE, hIcon, &sTitle,, ahk_id %hWnd%
	
	TTM_UPDATETIPTEXT := A_IsUnicode ? 1081 : 1036
    SendMessage, TTM_UPDATETIPTEXT, 0, &ti,, ahk_id %hWnd%
    DetectHiddenWindows, %Old_DetectHiddenWindows%
 }

;sTitle and sText are ASCII strings
BalloonTip(sTitle = "", sText = "", Timeout = 10000, MinTimeDisp = 200, RefreshRate = 100)
{
   Static hwnd, ActiveWinID, ActiveCtrl, CtrlContent, CaretX, CaretY, MinTime
   If (!sTitle && !sText)
      Goto _DestroyBalloonTip
   SetTimer, _DestroyBalloonTip, Off
   Gosub _DestroyBalloonTip
   ActiveWinID := WinExist("A")
   ControlGetFocus, ActiveCtrl, Ahk_ID %ActiveWinID%
   If !ActiveCtrl
      Return
   MinTime = 1
   ControlGetText, CtrlContent, %ActiveCtrl%, Ahk_ID %ActiveWinID%
   coordmode, caret, screen
   CaretX := A_CaretX
   CaretY := A_CaretY
   hwnd := DllCall("CreateWindowEx", "Uint", 0x80028, "str", "tooltips_class32", "str", "", "Uint", 0x42, "int", 0, "int", 0, "int", 0, "int", 0, "Uint", 0, "Uint", 0, "Uint", 0, "Uint", 0)
   VarSetCapacity(ti, 40, 0)
   ti := Chr(40)
;   DllCall("ntdll\RtlFillMemoryUlong", "Uint", &ti + 4, "Uint", 4, "Uint", 0x20)   ; TTF_TRACK
   NumPut(0x20, ti, 4, "UInt")   ; TTF_TRACK
   If (StrLen(sTitle)>99)
      sTitle := SubStr(sTitle, 1, 98) "…"
   TTM_SETTITLE := A_IsUnicode ? 1057 : 1056
   DllCall("SendMessage", "Uint", hWnd, "Uint", TTM_SETTITLE, "Uint", 0, "Uint", &sTitle)   ; TTM_SETTITLE   ; 0: None, 1:Info, 2: Warning, 3: Error. n > 3: assumed to be an hIcon.
;   DllCall("ntdll\RtlFillMemoryUlong", "Uint", &ti +36, "Uint", 4, "Uint", &sText)
   NumPut(&sText, ti, 36, "UInt")
   DllCall("SendMessage", "Uint", hWnd, "Uint", 1028, "Uint", 0, "Uint", &ti)   ; TTM_ADDTOOL
      ;sleep 1000
   WinGetPos, WinX, WinY, , , Ahk_ID %ActiveWinID%
   ControlGetPos, CtrlX, CtrlY, CtrlW, CtrlH, %ActiveCtrl%, Ahk_ID %ActiveWinID%
   ; TTM_TRACKPOSITION
   If ((CaretY < CtrlY+WinY) || (CaretY > CtrlY+CtrlH-11+WinY) || (CaretX < CtrlX+WinX) || (CaretX > CtrlX+CtrlW-4+WinX))
      DllCall("SendMessage", "Uint", hWnd, "Uint", 1042, "Uint", 0, "Uint", (CtrlX+4+WinX & 0xFFFF)|(CtrlY+CtrlH-9+WinY & 0xFFFF)<<16)
   Else
      DllCall("SendMessage", "Uint", hWnd, "Uint", 1042, "Uint", 0, "Uint", (CaretX+4 & 0xFFFF)|(CaretY+11 & 0xFFFF)<<16)
   TTM_UPDATETIPTEXT := A_IsUnicode ? 1081 : 1036
   DllCall("SendMessage", "Uint", hWnd, "Uint", TTM_UPDATETIPTEXT, "Uint", 0, "Uint", &ti)   ; TTM_UPDATETIPTEXT
   DllCall("SendMessage", "Uint", hWnd, "Uint", 1041, "Uint", 1, "Uint", &ti)   ; TTM_TRACKACTIVATE
   WinShow, Ahk_ID %hwnd%
   SetTimer, _UpdateBalloonTip, %RefreshRate%
   If MinTimeDisp
      SetTimer, _MinTimeDisp, -%MinTimeDisp%
   If Timeout
      SetTimer, _DestroyBalloonTip, -%Timeout%
   Return
   _MinTimeDisp:
   MinTime =
   Return
   _UpdateBalloonTip:
   F := WinExist("A")
   If (F = ActiveWinID)
   {
      ControlGetFocus, F, Ahk_ID %ActiveWinID%
      If (F = ActiveCtrl)
      {
         coordmode, caret, screen
         ControlGetText, F, %F%, Ahk_ID %ActiveWinID%
         If ((A_CaretX = CaretX) && (A_CaretY = CaretY) && (CtrlContent = F))
            Return
         Else If MinTime
         {
            CaretX := A_CaretX
            CaretY := A_CaretY
            CtrlContent := F
            WinGetPos, WinX, WinY, , , Ahk_ID %ActiveWinID%
            ControlGetPos, CtrlX, CtrlY, CtrlW, CtrlH, %ActiveCtrl%, Ahk_ID %ActiveWinID%
            If ((CaretY < CtrlY+WinY) || (CaretY > CtrlY+CtrlH-11+WinY) || (CaretX < CtrlX+WinX) || (CaretX > CtrlX+CtrlW-4+WinX))
               DllCall("SendMessage", "Uint", hWnd, "Uint", 1042, "Uint", 0, "Uint", (CtrlX+4+WinX & 0xFFFF)|(CtrlY+CtrlH-9+WinY & 0xFFFF)<<16)
            Else
               DllCall("SendMessage", "Uint", hWnd, "Uint", 1042, "Uint", 0, "Uint", (CaretX+4 & 0xFFFF)|(CaretY+11 & 0xFFFF)<<16)
            Return
         }
      }
   }
   _DestroyBalloonTip:
   SetTimer, _UpdateBalloonTip, Off
   SetTimer, _MinTimeDisp, Off
   SetWinDelay, -1
   WinClose, Ahk_ID %hwnd%
   hwnd =
   Return
}