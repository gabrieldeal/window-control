#include <Constants.au3>

;~ Func GetActiveWindow()
;~ 	Local $windows = WinList()
;~ 	For $windowIndex = 1 To $windows[0][0]
;~ 		If WinActive($windows[$windowIndex][1]) Then
;~ 			Return $windows[$windowIndex][0]
;~ 		EndIf
;~ 	Next
;~ 	SetError(1)
;~ EndFunc

;~ Local $window = GetActiveWindow();
;~ MsgBox($MB_SYSTEMMODAL, "Active window", $window)

Local $activeWindowPos = WinGetPos("[ACTIVE]")

;AutoItSetOption("WinTitleMatchMode", 3) ; Exact title match
Local $targetWindow = WinGetHandle($CmdLine[1])
if @error Then
	MsgBox($MB_SYSTEMMODAL, "Could not find window with title: " & $CmdLine[1])
EndIf

WinActivate($targetWindow)
WinMove($targetWindow, "", $activeWindowPos[0], $activeWindowPos[1]);
