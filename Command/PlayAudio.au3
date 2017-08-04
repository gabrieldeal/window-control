#include-once <../../Utils.au3>
#include <AutoItConstants.au3>
#include <Sound.au3>

Func PlayAudio()
    If $CmdLine[0] <> 2 Then
        Fail("Usage: WindowControl playAudio AUDIO_FILE")
    EndIf

    Local $audioFile = $CmdLine[2]


    Local $sound = _SoundOpen($audioFile)
    If @error <> 0 Then
       Fail("Got error " & @error & " when opening " & $audioFile)
    EndIf

    _SoundPlay($sound, 1)
    If @error <> 0 Then
       Fail("Got error " & @error & " when playing " & $audioFile)
    EndIf

    _SoundClose($sound)
EndFunc
