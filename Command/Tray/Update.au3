#include <TrayConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>
#include-once <../../Utils.au3>
#include <Constants.au3>

Func UpdateTray()
    If $CmdLine[0] <> 4 Then
	Fail("Usage: WindowControl updateTray TRAY_TITLE MESSAGE ICON")
    EndIf

    Local $trayTitle = $CmdLine[2] & " Tray"
    Local $message = $CmdLine[3]
    Local $icon = $CmdLine[4]

    Local $hWnd = GetWindowOrFail($trayTitle)
    SendTrayMessage($hWnd, $TRAY_UPDATE_MESSAGE_TYPE, $message, $icon)
EndFunc
