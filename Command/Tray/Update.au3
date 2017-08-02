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
    UpdateTray_SendMessage($hWnd, $message, $icon)
EndFunc

Func UpdateTray_SendMessage($hWnd, $message, $icon)
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
