#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 15
toggle := 0  ; Initialize a toggle variable to keep track of the state
Global pnumber
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

  ; Save the variable to a text file named "lastPnumber.txt"
  FileDelete, lastPnumber.txt ; This will delete the file if it exists
  FileAppend, %pnumber%, lastPnumber.txt ; This will create a new file and append the content of the variable

  ; Send the pageup to ensure the page starts at the top
  Send, {PgUp}

  ; Send Control-0 to ensure the zoom level is 0
  Send, ^0

  ; ZOOM OUT 5 times
  MouseMove, 2525, 74, 20  ; Move Mouse to menu
  Click ; Click on menu
  Sleep 200
  MouseMove, 2368, 250, 20 ; Move Mouse to Minus Button
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Send, {Esc} ; Close the Menu

  Sleep, 2000 ; delay before the next send command

  ; Send F11
  Send, {F11}

  ; Scroll Down Once (standardized by pageup at start)
  Click, WheelDown

  Sleep, 1000  ; delay before the next send command

  ; Open Snipping Tool
  Run, snippingtool

  Sleep, 1500  ; delay before the next send command

  ; Send Ctrl+Shift+N for new snip
  Send, ^+n

  Sleep, 1500 ; delay before the next send command

  ; Define hardcoded coordinates for top left and bottom right
  x1 := 3
  y1 := 171
  x2 := 611
  y2 := 1185

  ; Click and drag from (x1,y1) to (x2,y2)
  MouseClickDrag, L, x1, y1, x2, y2

  Sleep, 1000  ; delay before the next send command

  ; Refocus On Edge
  MouseMove, 1977, 461, 15
  Click

  ; Send F11 to toggle full screen
  Send, {F11}

  ; ZOOM Back In 5 times
  MouseMove, 2525, 74, 20  ; Move Mouse to menu
  Click ; Click on menu
  Sleep 200
  MouseMove, 2475, 244, 15 ; Move Mouse to PLUS Button
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Sleep 20
  Click ; Click on menu
  Send, {Esc} ; Close the Menu

  ; Refocus on the Snipping Tool
  WinActivate, Snipping Tool

  ; Send Ctrl+S to save
  Send, ^s
  Sleep, 1000

  ; Enter filename
  Send, PUK-%pnumber%-AQ50Score.jpg
  Sleep, 1000

  ; Send the Enter key to save the file
  Send, {Enter}

  toggle := 1  ; Change the toggle state
}
else  ; If it's the second time "2" is pressed
{
  toggle := 0  ; Reset the toggle state
}
return
