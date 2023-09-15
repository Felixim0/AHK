#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 10
toggle := 0  ; Initialize a toggle variable to keep track of the state
CoordMode, Mouse, Screen ; makes mouse coordinates to be relative to screen.

UpdateToolTip:
if (toggle = 1)  ; Only show the tooltip if the "2" key has been pressed once.
{
    MouseGetPos, xpos, ypos
    ToolTip, form filler, xpos+10, ypos+10
}
else
{
    ToolTip  ; Remove the tooltip when the toggle is off
}
return

^+2::  ; When number "2" is pressed
if (toggle = 0)  ; Check if it's the first time "2" is pressed
{
    ; Store the current clipboard content into a variable
    pnumber := Clipboard

    ; ZOOM OUT 5 times
    MouseMove, 1879, 70, 20, R  ; Move Mouse to menu
    Click ; Click on menu
    Sleep 100
    MouseMove, 1743, 241, 10, R ; Move Mouse to Minus Button
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Send, {Esc} ; Close the Menu

    Sleep, 1000  ; delay before the next send command

    ; Send F11
    Send, {F11}

    Sleep, 500  ; delay before the next send command

    ; Open Snipping Tool
    Run, snippingtool

    Sleep, 1000  ; delay before the next send command

    ; Send Ctrl+Shift+N for new snip
    Send, ^+n

    Sleep, 1000  ; delay before the next send command

    ; Define hardcoded coordinates for top left and bottom right
    x1 := 0
    y1 := 0
    x2 := 592
    y2 := 986

    ; Click and drag from (x1,y1) to (x2,y2)
    MouseClickDrag, L, x1, y1, x2, y2

    Sleep, 1000  ; delay before the next send command


    ; ZOOM Back In 5 times
    MouseMove, 1879, 70, 20, R  ; Move Mouse to menu
    Click ; Click on menu
    Sleep 100
    MouseMove, 1831, 235, 10, R ; Move Mouse to Minus Button
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Sleep 10
    Click ; Click on menu
    Send, {Esc} ; Close the Menu

    ; Send F11 to toggle full screen
    Send, {F11}

    Sleep, 1000  ; delay before the next send command

    ; Refocus on the Snipping Tool
    WinActivate, Snipping Tool

    ; Send Ctrl+S to save
    Send, ^s
    Sleep, 500

    ; Enter filename
    Send, PUK-%pnumber%-AQ50Score.jpg
    Sleep, 500

    ; Send the Enter key to save the file
    Send, {Enter}

    toggle := 1  ; Change the toggle state
}
else  ; If it's the second time "2" is pressed
{
    toggle := 0  ; Reset the toggle state
}
return
