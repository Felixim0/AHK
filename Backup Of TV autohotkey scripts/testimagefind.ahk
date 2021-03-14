
IfNotExist, temp.jpg    MsgBox Error: Your file either doesn't exist or isn't in this location.

ImageSearch, OutputVarX, OutputVarY, 400, 200, 600, 600, ImageFile.png


Loop {
   
    ImageSearch, FoundX, FoundY, 0, 0, [color=red]%A_ScreenWidth%[/color], [color=red]%A_ScreenHeight%[/color], temp.jpg ; These parameters must be in %% signs because they are variables passed in a value parameter.
   
    if ErrorLevel = 0

      {
      
    MsgBox Image found!
	  
    break
	  
    }
   
else if ErrorLevel = 1
      { 
  
	  MsgBox Image could not be found on the screen
      
break
      }

   else if ErrorLevel = 2
      {   
	  
MsgBox, Could not conduct search
      
break
      }

}