#Persistent

SetTimer, UpdateToolTip, 10
toggle := 0  ; Initialize a toggle variable to keep track of the global state
shortcuts := {}  ; Initialize an empty associative array (object) for key-text pairs

; Read the plaintext file
FileRead, myShortcuts, myShortcuts.txt

; Split the file into lines
lines := StrSplit(myShortcuts, "`n", "`r")

; Process each line to extract key and corresponding text
for index, line in lines
{
    parts := StrSplit(line, ":")
    if (parts.length() >= 2)  ; Ensure that there's both a key and text
    {
        shortcuts[parts[1]] := parts[2]  ; Store the text in the object
    }
}

; This hotkey function will send the associated text if the global toggle is on
SendShortcutText:
    key := SubStr(A_ThisHotkey, 2)
    if (toggle = 1 && key in %shortcuts%)
    {
        SendRaw, % shortcuts[key]
    }
return

UpdateToolTip:
    if (toggle = 1)  ; Only show the tooltip if the "3" key has been pressed once
    {
        MouseGetPos, xpos, ypos
        ToolTip, PHRASES, xpos+10, ypos+10
    }
    else
    {
        ToolTip  ; Remove the tooltip when the toggle is off
    }
return

^+3::  ; When Ctrl + Shift + number "3" is pressed
    if (toggle = 0)  ; Check if it's the first time "3" is pressed
    {
        toggle := 1  ; Change the toggle state
        ; Enable all dynamic hotkeys
        for key, text in shortcuts
        {
            Hotkey, % "$" key, SendShortcutText, On
        }
        ; Enable hardcoded hotkeys here (e.g., Hotkey, $a, triageMessage, On)
    }
    else  ; If it's the second time "3" is pressed
    {
        toggle := 0  ; Reset the toggle state
        ; Disable all dynamic hotkeys
        for key, text in shortcuts
        {
            Hotkey, % key, Off
        }
        ; Disable hardcoded hotkeys here (e.g., Hotkey, a, Off)
    }
return
