#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Initialize global variable
Global filePath := "C:\Users\Felix Gaming\Documents\githubProjects"

; Hotkey for Windows + Shift + E
#+e::
InputBox, filePath, Enter File Path, Please enter the file path.
Return

; Hotkey for Windows + E
$#e::
if (filePath = "")
{
    MsgBox, You need to specify a file path first using Windows + Shift + E.
}
else
{
    Run, explorer.exe "%filePath%"
}
Return
