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

    ; Send the pageup to ensure the page starts at the top
    Send, {PgUp}

    ; Send Control-0 to ensure the zoom level is 0
    Send, ^0

    ; ZOOM OUT 5 times
    MouseMove, 1879, 70, 5  ; Move Mouse to menu
    Click ; Click on menu
    Sleep 100
    MouseMove, 1743, 241, 5 ; Move Mouse to Minus Button
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

    Sleep, 600 ; delay before the next send command

    ; Send F11
    Send, {F11}

    ; Scroll Down Once (standardized by pageup at start)
    Click, WheelDown

    Sleep, 500  ; delay before the next send command

    ; Open Snipping Tool
    Run, snippingtool

    Sleep, 1000  ; delay before the next send command

    ; Send Ctrl+Shift+N for new snip
    Send, ^+n

    Sleep, 600 ; delay before the next send command

    ; Define hardcoded coordinates for top left and bottom right
    x1 := 0
    y1 := 0
    x2 := 592
    y2 := 1000

    ; Click and drag from (x1,y1) to (x2,y2)
    MouseClickDrag, L, x1, y1, x2, y2

    Sleep, 1000  ; delay before the next send command

    ; Refocus On Edge
    MouseMove, 1879, 70, 5
    Click

    ; Send F11 to toggle full screen
    Send, {F11}

    ; ZOOM Back In 5 times
    MouseMove, 1879, 70, 5  ; Move Mouse to menu
    Click ; Click on menu
    Sleep 100
    MouseMove, 1831, 235, 5 ; Move Mouse to Minus Button
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

    ; Refocus on the Snipping Tool
    WinActivate, Snipping Tool

    ; Send Ctrl+S to save
    Send, ^s
    Sleep, 300

    ; Enter filename
    Send, PUK-%pnumber%-AQ50Score.jpg
    Sleep, 300

    ; Send the Enter key to save the file
    Send, {Enter}

    ; Now save the score
    Send, !{Tab} ; Go back to EDGE

    ; Finish the form, tab to "mark" then "enter"
    Sleep, 100
    Send {Tab}
    Send, {Enter}

    ; Open Snipping Tool
    Run, snippingtool

    ; Send Ctrl+Shift+N for new snip
    Send, ^+n

    Sleep, 600 ; delay before the next send command

    ; Define hardcoded coordinates for top left and bottom right
    Sx1 := 981
    Sy1 := 214
    Sx2 := 1793
    Sy2 := 510

    ; Click and drag from (Sx1,Sy1) to (Sx2,Sy2)
    MouseClickDrag, L, Sx1, Sy1, Sx2, Sy2

    Sleep, 1000  ; delay before the next send command

    ; Refocus on the Snipping Tool
    WinActivate, Snipping Tool

    ; Send Ctrl+S to save
    Send, ^s
    Sleep, 300

    ; Enter filename
    Send, PUK-%pnumber%-AQ50Results.jpg

    toggle := 1  ; Change the toggle state
}
else  ; If it's the second time "2" is pressed
{
    toggle := 0  ; Reset the toggle state
}
return
