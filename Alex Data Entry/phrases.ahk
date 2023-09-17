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

global preparedMessage ; Declare a global variable to store the prepared message

PrepareHelloWithFutureDate:
    if (toggle = 1)
    {
        ; Temporarily disable the hotkeys
        for key, text in shortcuts
        {
            Hotkey, % key, Off
        }
        Hotkey, x, Off
        Hotkey, z, Off

        ; Adjust the date first
        futureDateTime := A_Now
        futureDateTime += 14, Days  ; Add 2 weeks

        ; Then format the adjusted date
        FormatTime, futureDate, % futureDateTime, MMMM d, yyyy

        InputBox, name, Enter Name, Please enter your name:, , 300, 150

        ; Reactivate the hotkeys
        for key, text in shortcuts
        {
            Hotkey, % "$" key, SendShortcutText, On
        }
        Hotkey, x, PrepareHelloWithFutureDate, On
        Hotkey, z, SendPreparedMessage, On

        if !ErrorLevel ; Ensure the user didn't press Cancel
        {
            preparedMessage := "hello " name "`nThe future Date is: " futureDate    
        }
    }
return

SendPreparedMessage:
    if (toggle = 1 && preparedMessage) ; Only send if toggle is active and there is a prepared message
    {
        ; Store the current clipboard content
        originalClipboard := ClipboardAll

        ; Set the clipboard to the prepared message
        Clipboard := preparedMessage

        ; Wait for the clipboard to contain the data
        ClipWait, 1

        ; Send Ctrl+V to paste the prepared message
        Send ^v

        ; Restore the original clipboard content
        Clipboard := originalClipboard
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
        Hotkey, x, PrepareHelloWithFutureDate, On  ; Bind "x" key to PrepareHelloWithFutureDate
        Hotkey, z, SendPreparedMessage, On  ; Bind "z" key to SendPreparedMessage
    }
    else  ; If it's the second time "3" is pressed
    {
        toggle := 0  ; Reset the toggle state
        ; Disable all dynamic hotkeys
        for key, text in shortcuts
        {
            Hotkey, % key, Off
        }
        Hotkey, x, Off  ; Unbind "x" key from PrepareHelloWithFutureDate
        Hotkey, z, Off  ; Unbind "z" key from SendPreparedMessage
    }
return
