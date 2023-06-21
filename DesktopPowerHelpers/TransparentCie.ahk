#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

>^Up::  ; When Right Control+Up is pressed
WinGetActiveTitle, Title  ; Get the title of the active window
WinGet, currentTransparency, Transparent, %Title%  ; Get the current transparency of the window
currentTransparency += 20  ; Increase the transparency by 20
if (currentTransparency > 255)  ; If the transparency is above the maximum
    currentTransparency := 255  ; Set the transparency to the maximum
WinSet, Transparent, %currentTransparency%, %Title%  ; Set the new transparency
return  ; End of hotkey

>^Down::  ; When Right Control+Down is pressed
WinGetActiveTitle, Title  ; Get the title of the active window
WinGet, currentTransparency, Transparent, %Title%  ; Get the current transparency of the window
if (currentTransparency == 255)  ; If the transparency is at the maximum (initial state)
    currentTransparency := 128  ; Set the transparency to 50% opacity
else
    currentTransparency -= 20  ; Decrease the transparency by 20
if (currentTransparency < 40)  ; If the transparency is below the minimum
    currentTransparency := 40  ; Set the transparency to the minimum
WinSet, Transparent, %currentTransparency%, %Title%  ; Set the new transparency
return  ; End of hotkey
