@echo off
setlocal
set "desktopPath=%USERPROFILE%\Desktop"
for /F "usebackq tokens=*" %%A in ("%desktopPath%\scriptsToRun.txt") do (
    echo Running %%A...
    start "" "%desktopPath%\%%A"
)
endlocal
