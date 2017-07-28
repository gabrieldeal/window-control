#include <Constants.au3>
#include <Utils.au3>

Local $usageMessage = "Usage: WindowControl COMMAND [ WINDOW_TITLE ]" & @CRLF & @CRLF & 'COMMAND: "show" or "hide"' & @CRLF
If $CmdLine[0] == 0 Or $CmdLine[0] > 2 Then
   Fail($usageMessage)
EndIf
Local $command = $CmdLine[1]

Local $targetWindowTitle = "Pomodoro Bash"
If $CmdLine[0] == 2 Then
   $targetWindowTitle = $CmdLine[2]
EndIf

AutoItSetOption("WinTitleMatchMode", 3) ; Exact title match
Local $targetWindow = WinGetHandle($targetWindowTitle)
if @error Then
   Fail("Could not find window with title '" & $targetWindowTitle & "'")
EndIf

Switch $command
Case "show"
     Show($targetWindow)
Case "hide"
     Hide($targetWindow)
Case Else
     Fail("Unknown command '" & $command & "'." & @CRLF & $usageMessage)
EndSwitch

Func Show($targetWindow)
     Local $activeWindowPos = WinGetPos("[ACTIVE]")
     If @error == 0 Then
	WinMove($targetWindow, "", $activeWindowPos[0], $activeWindowPos[1]);
     EndIf

     WinActivate($targetWindow)
EndFunc

Func Hide($targetWindow)
     WinSetState($targetWindow, "", @SW_MINIMIZE)
EndFunc
