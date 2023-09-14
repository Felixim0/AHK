#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 10
toggle := 0  ; Initialize a toggle variable to keep track of the state

UpdateToolTip:
if (toggle = 1)  ; Only show the tooltip if the "3" key has been pressed once.
{
    MouseGetPos, xpos, ypos
    ToolTip, PHRASES, xpos+10, ypos+10
}
else
{
    ToolTip  ; Remove the tooltip when the toggle is off
}
return


^+3::  ; When number "3" is pressed
if (toggle = 0)  ; Check if it's the first time "3" is pressed
{
    toggle := 1  ; Change the toggle state

    Hotkey, $a, triageMessage, On
    Hotkey, $s, sendRepeate, On
}
else  ; If it's the second time "3" is pressed
{
    toggle := 0  ; Reset the toggle state

    Hotkey, a, Off
    Hotkey, s, Off
}
return

triageMessage:
SendRaw "Please triage"
return

sendRepeate:
SendRaw AU5n Seoked
return
