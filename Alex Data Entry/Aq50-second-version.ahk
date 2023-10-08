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

^+4::  ; When number "4" is pressed
if (toggle = 0)  ; Check if it's the first time "4" is pressed
{
  ; Load the contents of the lastPnumber file as pnumber
  if FileExist("lastPnumber.txt")
  {
      ; If the file exists, read its contents into the pnumber variable
      FileRead, pnumber, lastPnumber.txt
  }

  ; Open Snipping Tool
  Run, snippingtool

  Sleep, 800 ; delay before the next send command

  ; Send Ctrl+Shift+N for new snip
  Send, ^+n

  Sleep, 800 ; delay before the next send command

  ; Define hardcoded coordinates for top left and bottom right
  Sx1 := 1543
  Sy1 := 227
  Sx2 := 2277
  Sy2 := 509

  ; Click and drag from (Sx1,Sy1) to (Sx2,Sy2)
  MouseClickDrag, L, Sx1, Sy1, Sx2, Sy2

  Sleep, 5000  ; delay before the next send command

  ; Refocus on the Snipping Tool
  WinActivate, Snipping Tool

  ; Send Ctrl+S to save
  Send, ^s
  Sleep, 2000

  ; Enter filename
  Send, PUK-%pnumber%-AQ50Results1.jpg

  ; Send the Enter key to save the file
  Send, {Enter}

  toggle := 1  ; Change the toggle state
}
else  ; If it's the second time "4" is pressed
{
  toggle := 0  ; Reset the toggle state
}
return
