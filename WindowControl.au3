#include <Constants.au3>
#include <Utils.au3>
#include <Command/Tray/Start.au3>
#include <Command/Tray/Update.au3>
#include <Command/Tray/Close.au3>
#include <Command/Window/Show.au3>
#include <Command/Window/Hide.au3>

Local $usageMessage = "Usage: WindowControl COMMAND [ COMMAND-SPECIFIC-PARAMETERS ]" & @CRLF & @CRLF & 'COMMAND: show, hide, startTray, updateTray, or closeTray.' & @CRLF
If $CmdLine[0] == 0 Then
   Fail($usageMessage)
EndIf
Local $command = $CmdLine[1]

Switch $command
Case "show"
     ShowWindow()
Case "hide"
     HideWindow()
Case "startTray"
     StartTray()
Case "updateTray"
     UpdateTray()
Case "closeTray"
     CloseTray()
Case Else
     Fail("Unknown command '" & $command & "'." & @CRLF & $usageMessage)
EndSwitch
