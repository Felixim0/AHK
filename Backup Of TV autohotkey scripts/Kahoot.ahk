#SingleInstance IGNORE

Sleep, 2000

Send {Esc}
Sleep, 2000

MouseMove, 1883, 12, 50
Click

Run, http://getkahoot.com/
sleep, 2000
MouseMove 1327,160,60
click 
sleep, 4000

MouseMove 456,122,60
click
sleep, 4000
MouseMove 676,389,60
click

FileReadLine, line1, C:\Users\Local User\Desktop\textFile.txt,1 ; Essentially reads the 1st line of the e-mail

SendRaw, %line1%

Send {Enter}

FileReadLine, line2, C:\Users\Local User\Desktop\textFile.txt,2 ; Essentially reads the 2nd line of the e-mail

Sleep, 5000 ; Lets the website load

