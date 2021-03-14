#SingleInstance force

windowsState := Object() 
windowsState[1] := "windowsOpen" 

soundState := Object()
soundState[1] := 0

F1::Function()

Function() 
	{ 
	global windowsState 
	global soundState
	
	if (windowsState[1] = "windowsOpen")  		; Windows were open - switch now
		{
		;msgbox, % windowsState[1] "True"
		
		temp = windowsState.Delete(1)
		windowsState[1] := "windowsClosed"
		
		SoundGet, soundLevel					; Gets old sound setting
		soundState[1] := Ceil(soundLevel)			; Saves old sound setting
		
		SoundSet, 0 							; Sets sound to 0
		
		Send, {ALT DOWN}{TAB}
		Send, {ALT UP}
		}
	else {
	
		;msgbox, % windowsState[1] "False"
		
		SoundSet, % soundState[1]				; Returns sound to previous level
		
		temp = windowsState.Delete(1)
		windowsState[1] := "windowsOpen"
		
		Send, {ALT DOWN}{TAB}
		Send, {ALT UP}
		}
	}
