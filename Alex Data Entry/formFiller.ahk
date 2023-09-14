#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 10
toggle := 0  ; Initialize a toggle variable to keep track of the state

UpdateToolTip:
if (toggle = 1)  ; Only show the tooltip if the "1" key has been pressed once.
{
    MouseGetPos, xpos, ypos
    ToolTip, form filler, xpos+10, ypos+10
}
else
{
    ToolTip  ; Remove the tooltip when the toggle is off
}
return

1::  ; When number "1" is pressed
if (toggle = 0)  ; Check if it's the first time "1" is pressed
{
    Send, {Tab 5}  ; Send the "Tab" key 5 times
    toggle := 1  ; Change the toggle state

    Hotkey, z, SendTab, On
    Hotkey, x, SendRightTab, On
    Hotkey, c, SendRight2Tab, On
    Hotkey, v, SendRight3Tab, On
}
else  ; If it's the second time "1" is pressed
{
    toggle := 0  ; Reset the toggle state

    Hotkey, z, Off
    Hotkey, x, Off
    Hotkey, c, Off
    Hotkey, v, Off
}
return

SendTab:
Send, {Right}{Left}{Tab}
return

SendRightTab:
Send, {Right}{Tab}
return

SendRight2Tab:
Send, {Right 2}{Tab}
return

SendRight3Tab:
Send, {Right 3}{Tab}
return
