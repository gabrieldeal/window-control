Global $TRAY_MESSAGE_STRUCT = "char message[256]; char icon[256]"
Global $TRAY_COPYDATA_STRUCT = "ptr dwData; dword cbData; ptr lpData"

Func Fail($message)
   ConsoleWriteError($message & @CRLF)
   Exit 1
EndFunc
