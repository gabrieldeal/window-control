#include-once <../../Utils.h>

Func HideWindow()
    If $CmdLine[0] <> 2 Then
	Fail("Usage: WindowControl hide TITLE")
    EndIf

    Local $title = $CmdLine[2]

    Local $hWnd = GetWindowOrFail($title)
    WinSetState($hWnd, "", @SW_MINIMIZE)
EndFunc
