# Running from the source
```
 /cygdrive/c/Program\ Files/AutoIt3/AutoIt3.exe WindowControl.au3 show "Pomodoro Bash"
```

```
/cygdrive/c/Program\ Files\ \(x86\)/AutoIt3/Aut2Exe/Aut2exe /in SendToTray.au3  && ./SendToTray breakOver
```

# Releasing

1. `git tag`
1. `git tag -a vN.N.N -m "xxxx"`
1. `git push origin --tags`
1. `/cygdrive/c/Program\ Files/AutoIt3/Aut2Exe/Aut2exe.exe /in WindowControl.au3 /x64 /out WindowControl_x64.exe`
1. `/cygdrive/c/Program\ Files/AutoIt3/Aut2Exe/Aut2exe.exe /in WindowControl.au3 /x86`
1. https://help.github.com/articles/creating-releases/
