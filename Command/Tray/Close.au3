#include <TrayConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>
#include-once <../../Utils.au3>
#include <Constants.au3>

Func CloseTray()
    If $CmdLine[0] <> 2 Then
	Fail("Usage: WindowControl closeTray TRAY_TITLE")
    EndIf

    Local $trayTitle = $CmdLine[2] & " Tray"

    Local $hWnd = GetWindowOrFail($trayTitle)
    WinClose($hWnd)
EndFunc

