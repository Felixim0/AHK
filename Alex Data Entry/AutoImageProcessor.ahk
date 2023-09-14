#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 10
toggle := 0  ; Initialize a toggle variable to keep track of the state

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

2::  ; When number "2" is pressed
if (toggle = 0)  ; Check if it's the first time "2" is pressed
{
    ; Store the current clipboard content into a variable
    pnumber := Clipboard

    ; Send Ctrl Down
    Send, ^{Down}

    ; Wait for 100ms
    Sleep, 100

    ; Scroll Down 5 times (for zooming out)
    Loop, 5
    {
        Send, {WheelDown}
        Sleep, 100  ; 100ms delay between send commands
    }

    ; Release Ctrl key
    Send, ^{Up}

    Sleep, 100  ; 100ms delay before the next send command

    ; Send F11
    Send, {F11}

    ; Open Snipping Tool
    Run, snippingtool

    ; Give some time for the snipping tool to open
    Sleep, 1000

    ; Send Ctrl+Shift+N for new snip
    Send, ^+n

    Sleep, 500  ; Give some time for snip mode to activate

    ; Define coordinates for top left and bottom 30%
    SysGet, MonitorHeight, 1  ; Get monitor height
    EndY := MonitorHeight * 0.7  ; Compute 70% of the monitor's height

    ; Click and drag from top left to bottom 30%
    MouseClickDrag, L, 0, 0, A_ScreenWidth, EndY

    Sleep, 500  ; Give some time for snip to be captured

    ; Zoom out (i.e., scroll up) 5 times
    Send, ^{Down}
    Sleep, 100
    Loop, 5
    {
        Send, {WheelUp}
        Sleep, 100
    }

    ; Send F11 to toggle full screen
    Send, {F11}
    Sleep, 500

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
