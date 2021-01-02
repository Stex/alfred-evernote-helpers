#!/usr/bin/env osascript

on run argv
    tell application "System Events" to tell process "Evernote"	
        set frontmost to true
        click menu item "Export note…" of menu "File" of menu bar item "File" of menu bar 1
        repeat until (exists first sheet of first window)
            delay 1
        end repeat
        
        tell first sheet of first window
            # CMD + SHIFT + G opens the "Go to path" modal inside the save sheet
            keystroke "G" using {command down, shift down}
            
            # Wait for the new modal to open
            repeat until (exists first sheet)
                delay 1
            end repeat
            
            # The path text field is pre-focused, we just need to start typing
            keystroke "~/Downloads"

            # Wait a bit for the previous keystrokes to settle... 
            # otherwise, parts of the text might go into the file name field.
            delay 1
            keystroke return

            # Keep track of the file name evernote chose in the save dialog. 
            # No need to change it as it's the note's title we'll use later for the PDF.
            set filename to value of text field "Save As:"

            # Close the save dialog
            click button "Save"
        end tell
            
        # Wait for the export to be finished... 
        # Maybe it's possible to actually check for the generated file instead, but in
        # my tests, everything was exported in 2 seconds.
        delay 2

        # Close the "Exported note to..." box, it's almost impossible to
        # access its button regularly.
        keystroke return

        return "~/Downloads/" & filename
    end tell 
end run