Global $TRAY_MESSAGE_STRUCT = "int messageType; char message[256]; char icon[256]"
Global $TRAY_COPYDATA_STRUCT = "ptr dwData; dword cbData; ptr lpData"

Global $TRAY_DISPLAY_NOTIFICATION_MESSAGE_TYPE = 101;
Global $TRAY_UPDATE_MESSAGE_TYPE = 201;


Func Fail($message)
   ConsoleWriteError($message & @CRLF)
   Exit 1
EndFunc

Func GetWindowOrFail($trayTitle)
    AutoItSetOption("WinTitleMatchMode", 3) ; Exact title match
    Local $hWnd = WinGetHandle($trayTitle)
    If @error <> 0 Then
       Fail("Could not find window '" & $trayTitle & "'")
    EndIf

    Return $hWnd
EndFunc

Func SendTrayMessage($hWnd, $messageType, $message, $icon)
    ; This is building a COPYDATASTRUCT as documented at
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms649010(v=vs.85).aspx

    Local $lpDataStruct = DllStructCreate($TRAY_MESSAGE_STRUCT)
    ; FIXME: Bounds check message & icon!
    DllStructSetData($lpDataStruct, "messageType", $messageType)
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
