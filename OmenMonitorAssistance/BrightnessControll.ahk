#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; Initialize the brightness variable to 50
brightness := 50
brightnessChange := 30

; Hotkey to increase brightness when NumPad6 is pressed
NumPad6::
    brightness += brightnessChange
    if (brightness > 100)
        brightness := 100  ; Ensure brightness doesn't exceed 100
    ChangeBrightness()
return

; Hotkey to decrease brightness when NumPad3 is pressed
NumPad3::
    brightness -= brightnessChange
    if (brightness < 0)
        brightness := 0  ; Ensure brightness doesn't go below 0
    ChangeBrightness()
return

; Function to change brightness
ChangeBrightness() {
    global brightness
    ; Construct the command with the brightness variable
    cmd := "python .\seperatescreenbrightnesscontroll.py " . brightness
    RunWait, %cmd%,, Hide
}
