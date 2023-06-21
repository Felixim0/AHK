toggle := 0

F1::
MouseGetPos, MouseX, MouseY
if toggle := !toggle
 gosub, MoveTheMouse
else
 SetTimer, MoveTheMouse, off
return

MoveTheMouse:
MouseMove, 10,10
SetTimer, MoveTheMouse, -5000  ; every 3 seconds 
MouseMove, 10,11
return