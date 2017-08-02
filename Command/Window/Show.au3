#include-once <../../Utils.h>

Func ShowWindow()
    If $CmdLine[0] <> 2 Then
	Fail("Usage: WindowControl hide TITLE")
    EndIf

    Local $title = $CmdLine[2]

    Local $hWnd = GetWindowOrFail($title)

    Local $activeWindowPos = WinGetPos("[ACTIVE]")
    If @error == 0 Then
       WinMove($hWnd, "", $activeWindowPos[0], $activeWindowPos[1]);
    EndIf

    WinActivate($hWnd)
EndFunc

