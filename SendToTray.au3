#include <TrayConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>
#include <Utils.au3>
#include <Constants.au3>

Main()

Func Main()
    If $CmdLine[0] <> 4 Then
        Fail("Usage: Send TRAY_TITLE COMMAND MESSAGE ICON")
    EndIf

    Local $trayTitle = $CmdLine[1]
    Local $command = $CmdLine[2]
    Local $message = $CmdLine[3]
    Local $icon = $CmdLine[4]

    Local $hWnd = GetTrayWindow($trayTitle)

    Switch $command
    Case "close"
         WinClose($hWnd)
    Case "message"
         SendMessage($hWnd, $message, $icon)
    Case Else
         Fail("Unrecognized command: " & $command)
    EndSwitch
EndFunc

Func GetTrayWindow($trayTitle)
    Local $hWnd = WinGetHandle($trayTitle)
    If @error <> 0 Then
       Fail("Could not find tray")
    EndIf

    Return $hWnd
EndFunc

Func SendMessage($hWnd, $message, $icon)
    ; This is building a COPYDATASTRUCT as documented at
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms649010(v=vs.85).aspx

    Local $lpDataStruct = DllStructCreate($TRAY_MESSAGE_STRUCT)
    DllStructSetData($lpDataStruct, "message", $message)
    DllStructSetData($lpDataStruct, "icon", $icon)

    Local $copydataStruct = DllStructCreate($TRAY_COPYDATA_STRUCT)
    DllStructSetData($copydataStruct, "dwData", 0)
    DllStructSetData($copydataStruct, "cbData", DllStructGetSize($lpDataStruct))
    DllStructSetData($copydataStruct, "lpData", DllStructGetPtr($lpDataStruct))

    Local $wParam = 0 ; supposed to be a handle to the window passing the data
    Local $wParamType = "int"
    Local $lParam = DllStructGetPtr($copydataStruct)
    Local $lParamType = "ptr"
    Local $iReturn = 0
    _SendMessage($hWnd, $WM_COPYDATA, $wParam, $lParam, $iReturn, $wParamType, $lParamType)
EndFunc
