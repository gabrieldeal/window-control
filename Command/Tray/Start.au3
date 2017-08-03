#include <TrayConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include-once <../../Utils.au3>

Local $TRAY_TITLE

Func StartTray()
    If $CmdLine[0] <> 4 Then
	Fail("Usage: WindowControl startTray TITLE INITIAL_ICON INITIAL_MESSAGE")
    EndIf

    $TRAY_TITLE = $CmdLine[2]
    Local $initialIcon = $CmdLine[3]
    Local $initialMessage = $CmdLine[4]

    Local $trayTitle = $TRAY_TITLE & " Tray"
    GUICreate($trayTitle)
    AutoItWinSetTitle($trayTitle)

    TraySetState($TRAY_ICONSTATE_SHOW)
    StartTray_Update($initialIcon, $initialMessage)

    GUIRegisterMsg($WM_COPYDATA, "StartTray_MY_WM_COPYDATA")
    While 1
        Local $msg = GUIGetMsg()
        Switch $msg
            Case $GUI_EVENT_CLOSE
                 Exit 0
            Case 0
                 ; No message
            Case Else
                 ConsoleWrite("Got a message: " & $msg)
        EndSwitch
    WEnd
EndFunc

Func StartTray_Update($icon, $message)
    TraySetIcon($icon)
    TraySetToolTip($message)
EndFunc

Func StartTray_MY_WM_COPYDATA($hWnd, $Msg, $wParam, $lParam)
    Local $copydataStruct = DllStructCreate($TRAY_COPYDATA_STRUCT, $lParam)
    Local $lpData = DllStructGetData($copydataStruct, "lpData")

    Local $lpDataStruct = DllStructCreate($TRAY_MESSAGE_STRUCT, $lpData)
    Local $messageType = DllStructGetData($lpDataStruct, "messageType")
    Local $message = DllStructGetData($lpDataStruct, "message")
    Local $icon = DllStructGetData($lpDataStruct, "icon")

    Switch $messageType
    Case $TRAY_DISPLAY_NOTIFICATION_MESSAGE_TYPE
	StartTray_Update($icon, $message)
	TrayTip($TRAY_TITLE, $message, 5)
    Case $TRAY_UPDATE_MESSAGE_TYPE
	StartTray_Update($icon, $message)
    Case Else
	ConsoleWriteError("Got unrecognized message type " & $messageType)
    EndSwitch
EndFunc

