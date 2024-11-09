#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; Initialize the brightness variable to 50
brightness := 50

; Variable to control the amount of brightness change
brightnessChange := 30

; Hotkey to increase brightness when NumPad6 is pressed (NumLock On)
NumPad6::
IncreaseBrightness()
return

; Hotkey to increase brightness when NumPadRight is pressed (NumLock Off)
NumPadRight::
IncreaseBrightness()
return

; Hotkey to decrease brightness when NumPad3 is pressed (NumLock On)
NumPad3::
DecreaseBrightness()
return

; Hotkey to decrease brightness when NumPadPgDn is pressed (NumLock Off)
NumPadPgDn::
DecreaseBrightness()
return

; Function to increase brightness
IncreaseBrightness() {
    global brightness, brightnessChange
    brightness += brightnessChange
    if (brightness > 100)
        brightness := 100  ; Ensure brightness doesn't exceed 100
    ChangeBrightness()
}

; Function to decrease brightness
DecreaseBrightness() {
    global brightness, brightnessChange
    brightness -= brightnessChange
    if (brightness < 0)
        brightness := 0  ; Ensure brightness doesn't go below 0
    ChangeBrightness()
}

; Function to change brightness
ChangeBrightness() {
    global brightness
    ; Construct the command with the brightness variable
    cmd := "python .\seperatescreenbrightnesscontroll.py " . brightness
    ; Run the command hidden to prevent the console window from appearing
    RunWait, %cmd%,, Hide
}
