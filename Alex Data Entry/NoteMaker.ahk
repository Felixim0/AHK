#Persistent  ; This keeps the script running
SetTimer, UpdateToolTip, 15
toggle := 0  ; Initialize a toggle variable to keep track of the state
CoordMode, Mouse, Screen ; makes mouse coordinates to be relative to screen.

UpdateToolTip:
if (toggle = 1)  ; Only show the tooltip if the "5" key has been pressed once.
{
    MouseGetPos, xpos, ypos
    ToolTip, notemaker, xpos+10, ypos+10
}
else
{
    ToolTip  ; Remove the tooltip when the toggle is off
}
return

^+5::  ; When number "5" is pressed
if (toggle = 0)  ; Check if it's the first time "5" is pressed
{
    Sleep, 400 ; delay
    Send, !{Tab} ; Alt + Tab
    Sleep, 400 ; delay
    Send, {F5} ; Refresh key
    Sleep, 3000 ; additional delay for page load
    Send, {F12} ; Send F12 key
    Sleep, 4000 ; Wait for developer options to load

    ; FOCUS ON CONSOLE
    MouseMove, 820, 194, 5
    Click
    Sleep, 400

    ; Create the new note so that the DOM elements will exist in a second
    Clipboard =
    (
        const x = document.querySelector('[data-testid="buttonNewNote"]');
        x.click();
    )
    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 900 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key

    ; SELECT THE DROPDOWNS, nOTE SUBJECT, RICH TECT SETTINGS, CREATE TASK BUTTON
    Clipboard =
    (
        const dropdown = document.querySelector('[data-testid="noteType"]');
        dropdown.click();
        setTimeout(() => {
            const adminOption = Array.from(document.querySelectorAll('.ant-select-dropdown-menu-item'))
                                    .find(el => el.textContent.trim() === "Admin");
            if (adminOption) {
                adminOption.click();
            }
        }, 200);

        const dropdownNoteSubject = document.querySelector('[data-testid="noteSubject"]');
        dropdownNoteSubject.click();
        setTimeout(() => {
            const messageOption = Array.from(document.querySelectorAll('.ant-select-dropdown-menu-item'))
                                     .find(el => el.textContent.trim().toLowerCase() === "message");
            if (messageOption) {
                messageOption.click();
            }
        }, 200);

        const richTextEditor = document.querySelector('[data-testid="Notes"] .ql-editor');
        richTextEditor.innerHTML = 'AQ50 Scored.';

        const x = document.querySelectorAll('.ant-radio-wrapper > span:not(.ant-radio)');
        const lastItem = x[x.length - 1];
        lastItem.click();

        const checkCreateTaskButton = document.querySelector('#createTaskFromNote');
        checkCreateTaskButton.click();
    )
    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 500 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key

    ; Select the upload button and click
    Clipboard =
    (
        const buttonElement = document.querySelector('button.ant-btn .anticon-upload + span');
        buttonElement.click();
    )
    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 500 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key



    ; Now select the files from the file selector
    Sleep 3000

    ; Read the content of the file
    FileRead, lastPnumber, %A_ScriptDir%\lastPnumber.txt

    ; Trim any possible newline or space characters that might be read from the file
    lastPnumber := Trim(lastPnumber)

    ; Format the strings with quotation marks
    firstString := """PUK-" . lastPnumber . "-AQ50Score"""
    secondString := """PUK-" . lastPnumber . "-AQ50Results1"""

    ; Combine both strings with a space
    finalString := firstString . " " . secondString

    ; Set the finalString to the clipboard
    Clipboard := finalString





    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 600 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key

    Sleep, 2000

    ; Save the form (triggers opening new form)
    Clipboard =
    (
        const divContainer = document.querySelector('div.ant-col.ant-col-24[style="display: flex; align-items: center; justify-content: center;"]');
        const saveButton = divContainer.querySelector('button.ant-btn.ant-btn-primary');
        saveButton.click();
    )
    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 600 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key

    Sleep, 4000

    ; Fill in the form
    Clipboard =
    (
        const assignedToTypeahead = document.querySelector('input[data-testid="assign-task-to-user-search"]');
        assignedToTypeahead.value="ASD Triage Team";
        const taskTypeTypeahead = document.querySelector('input[data-testid="task-type-search"]');
        taskTypeTypeahead.value="AQ Scored";

        const callendar = document.querySelector('input[name="dueDate"][placeholder="Select date"]');
        let today = new Date();
        today.setDate(today.getDate() + 7);  // Add 7 days
        let dd = String(today.getDate()).padStart(2, '0');
        let mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
        let yyyy = today.getFullYear();
        let dateOneWeekFromNow = dd + '/' + mm + '/' + yyyy;
        callendar.value = dateOneWeekFromNow;
    )
    Sleep 600
    Send, ^v ; Paste (Ctrl + V)
    Sleep, 500 ; Short delay before sending the next command
    Send, {Enter} ; Send Enter key


    Send, {F12} ; Send F12 key

    toggle := 1  ; Change the toggle state
}
else  ; If it's the second time "5" is pressed
{
    toggle := 0  ; Reset the toggle state
}
return
