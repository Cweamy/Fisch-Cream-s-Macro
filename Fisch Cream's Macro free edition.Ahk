#SingleInstance, force  ; Ensures only one instance of the script is running at a time
Coordmode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, Tooltip, Screen
SetMouseDelay, -1       ; Disables mouse movement delay for faster execution
SetBatchLines, -1       ; Disables batch line delays for faster execution
Try { ; Traffic Check
    whr := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	whr.Open("GET", "https://pastebin.com/raw/NMUzDRLR")
	whr.Send()
}
if (A_ScreenDPI * 100 // 96 != 100) {
	Run, ms-settings:display
	msgbox, 0x1030, WARNING!!, % "Your Display Scale seems to be a value other than 100`%. This means the macro will NOT work correctly!`n`nTo change this, right-click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Scale to 100`% -> Close and Restart Roblox before starting the macro.", 60
	ExitApp
}
; Define the message to display in the message box
message= 
(
This is Fisch Cream's Macro (FREE VERSION). There is no need for configuration - no more searching for the "best config" for fishing. Simply set the control value of your rod in the settings.ini file.

A friendly reminder: this macro will never ask for Admin access. If you obtained the file from anywhere other than the official source, https://github.com/Cweamy/Fisch-Cream-s-Macro, you are likely being scammed.
)

; Display the message in a message box with a timeout of 60 seconds
msgbox, , Fisch Cream's Macro, % message, 60


message= 
(
Quick Tutorial: To use this macro, ensure you're in full-screen mode on Roblox and have Roblox Camera mode enabled.

Support the original creator by purchasing the paid macro available on our Discord server.

Current version: 3.
)

; Display the message in a message box with a timeout of 60 seconds
msgbox, , Fisch Cream's Macro, % message, 60


/*
; Read the "sub_confirmation" value from the Settings.ini file (default is 0)
IniRead, sub_confirmation, Settings.ini, Fisch, sub_confirmation, 0

; If "sub_confirmation" is not set (0), prompt user to subscribe to the channel
If (!sub_confirmation) {
    Run, % "https://discord.gg/FischMacro"
    Sleep 3000  ; Wait for 3 seconds before showing the next message box
    ; Open the subscription URL for the user to subscribe
    Run, % "https://www.youtube.com/@VivaceConfetti?sub_confirmation=1"
    Sleep 5000
    ; Display a message box asking the user to subscribe
    MsgBox, 4, Fisch Cream's Macro, Pls sub, 60
    ; If user presses "No", exit the macro
    IfMsgBox, No 
    {
        ExitApp
    }
    Sleep 1000
}

; If user has subscribed, write "1" to "sub_confirmation" in the settings.ini
IniWrite, 1, Settings.ini, Fisch, sub_confirmation
*/
; Read the "Control" value from the Settings.ini (default is 0) and set it for the macro's control parameter
;IniRead, Control, Settings.ini, Fisch, Control, 0 
;IniWrite, %Control%, Settings.ini, Fisch, Control ; Autosave for Control

; Activate the Roblox window for the macro to work with
WinActivate, Roblox ahk_exe RobloxPlayerBeta.exe
Sleep 1000
; If Roblox doesn't activate, show an error message
If !WinActive("Roblox ahk_exe RobloxPlayerBeta.exe") {
    Msgbox Failed to activate Roblox
    ExitApp
}
; = = = = = = = = = = = = = = = = = = = = 
; Get the position and dimensions of the Roblox window
WinGetPos,,, RobloxWidth,RobloxHeight, Roblox ahk_exe RobloxPlayerBeta.exe
if (RobloxWidth < A_ScreenWidth && RobloxHeight < A_ScreenHeight) {
    Send {f11}
    Sleep 1000
}
WinGetPos,,, RobloxWidth,RobloxHeight, Roblox ahk_exe RobloxPlayerBeta.exe
; = = = = = = = = = = = = = = = = = = = =
ColorUI := {"0xffdcac": 10, "0x3d381b": 10, "0xfffde4": 10}
IngameUiXLeft := Round((RobloxWidth / 2560) * 2260)  ; Left X coordinate for ingame-ui
IngameUiYLeft := Round((RobloxHeight / 1080) * 980)  ; Left Y coordinate for ingame-ui
IngameUiXRight := Round((RobloxWidth / 2560) * 2560) ; Right X coordinate for ingame-ui
IngameUiYRight := Round((RobloxHeight / 1080) * 1080) ; Right Y coordinate for ingame-ui
Loop, 5 {
    For Color, Variation in ColorUI {
        PixelSearch,,, %IngameUiXLeft%, %IngameUiYLeft%, %IngameUiXRight%, %IngameUiXRight%, %Color%, %Variation%, Fast RGB 
        If (ErrorLevel = 0) {
            Tooltip, Pls Open Camera Mode
            Sleep 1000
            X := Round((RobloxWidth / 2560) * 2525)
            If (RobloxWidth >= A_ScreenWidth) && (RobloxHeight >= A_ScreenHeight) {
                Click, %X%, 35
            } else {
                Click, %X%, 65
            }
            Sleep 1000
            Break
        }
    }
}

; Calculate the bar size based on the Roblox window width (scaled for 800px width)
;Global Control := Round((RobloxWidth/800) * ((320 * Control) + 97)) ; Bar Size Calculator

; = = = = = = = = = = = = = = = = = = = = 
; Define coordinates for the mini-game area
Global MiniGameXLeft := Round((RobloxWidth / 2560) * 763)  ; Left X coordinate for mini-game
Global MiniGameYLeft := Round((RobloxHeight / 1080) * 899)  ; Left Y coordinate for mini-game
Global MiniGameXRight := Round((RobloxWidth / 2560) * 1796) ; Right X coordinate for mini-game
Global MiniGameYRight := Round((RobloxHeight / 1080) * 939) ; Right Y coordinate for mini-game

; = = = = = = = = = = = = = = = = = = = = 
; Define coordinates for the shake area (used to detect screen shake)
Global ShakeXLeft  := Round((RobloxWidth / 800) * 100)   ; Left X coordinate for shake detection
Global ShakeYLeft  := Round((RobloxHeight / 800) * 175)  ; Left Y coordinate for shake detection
Global ShakeXRight := Round((RobloxWidth / 800) * 700)   ; Right X coordinate for shake detection
Global ShakeYRight := Round((RobloxHeight / 800) * 675)  ; Right Y coordinate for shake detection

; = = = = = = = = = = = = = = = = = = = = 
; Define color targets for different screen elements (fish, white, and bar)
Global Color_Fish := {"0x434b5b": 3, "0x4a4a5c": 4, "0x47515d": 4}  ; Color for fish (with variation)
Global Color_White := {"0xFFFFFF": 15} ; Color for white (used for detecting certain screen regions)
Global Color_Bar := {"0x848587": 4, "0x787773": 4, "0x7a7873": 4} ; Colors for bar (with variations)
; = = = = = = = = = = = = = = = = = = = = 
; Calculation for Tooltip
Loop, 20 {
    TooltipPosY%A_Index% := (RobloxHeight / 1080) * 400 + (A_Index * 25)
}
SetTimer, UpdateTooltip, 1000 ; Updates the tooltip every second.
RunTime := A_TickCount ; Stores the script's start time.
UpdateTooltip() {
    global RunTime, TooltipPosY2
    Elapsed := A_TickCount - RunTime
    Hours := Floor(Elapsed / 3600000)
    Minutes := Floor((Elapsed - Hours * 3600000) / 60000)
    Seconds := Floor((Elapsed - Hours * 3600000 - Minutes * 60000) / 1000)
    Tooltip, Runtime: %Hours%h %Minutes%m %Seconds%s, 100, %TooltipPosY2%, 2
}
tooltip, Made By Cweamya, 100, %TooltipPosY1%, 1
tooltip, Runtime: 0h 0m 0s, 100, %TooltipPosY2%, 2
tooltip, Press "Space" to Exit, 100, %TooltipPosY4%, 3
Reels()
LastShakeTimer := A_TickCount
Loop {
    WinActivate, Roblox ahk_exe RobloxPlayerBeta.exe
    ; If a click shake is detected, update the last shake time
    If ClickShake(X, Y) {
        tooltip, Current Task: Shaking, 100, %TooltipPosY6%, 4
        tooltip, Click X: %X%, 100, %TooltipPosY7%, 5
        tooltip, Click Y: %Y%, 100, %TooltipPosY8%, 6
        ClickCount++
        tooltip, Click Count: %ClickCount%, 100, %TooltipPosY9%, 7
        LastShakeTimer := A_TickCount
    }
    
    ; If 7 seconds have passed since the last shake, trigger the Reels function
    If (A_TickCount - LastShakeTimer > 7000) {
        tooltip, Current Task: FailSave Activated, 100, %TooltipPosY6%, 4
        FailSave++
        tooltip, FailSave Count: %FailSave%, 100, %TooltipPosY9%, 7
        Send m
        Sleep 250
        Reels()
    }

    ; If the fish and white color are found, proceed with fishing actions
    If (Search(Color_Fish) && Search(Color_White)) {
        If (!Control) {
            Loop, 50 {
                PixelSearch, BarX, , MiniGameXLeft, MiniGameYLeft, MiniGameXRight, MiniGameYRight, 0xFFFFFF, 15, Fast RGB
                if (ErrorLevel = 0) {
                    Control := (MiniGameXRight - (BarX - MiniGameXLeft)) - BarX
                    Break
                }
            }
            If (Control <= 0) {
                IniRead, Control, Settings.ini, Fisch, Control, 0 
                IniWrite, %Control%, Settings.ini, Fisch, Control ; Autosave for Control
                Control := Round((RobloxWidth/800) * ((320 * Control) + 97))
            }
        }
        tooltip,,,, 7
        tooltip,,,, 5
        tooltip,,,, 6
        tooltip, Current Task: Playing Bar Minigame, 100, %TooltipPosY6%, 4
        tooltip, |, MiniGameXLeft + (Control * 0.8), (RobloxHeight * 1080) * 1015, 11
        tooltip, |, MiniGameXRight - (Control * 0.8), (RobloxHeight * 1080) * 1015, 12
        Loop {
            ; Get the current position of the fish
            FishPos := Search(Color_Fish) 
            tooltip, ., FishPos, (RobloxHeight * 1080) * 1015, 13
            tooltip,,,, 7
            ; If no fish is found, exit the loop
            If (!FishPos) {
                Break
            }
            tooltip,,,, 14
            ; If fish is on the left side of the control bar, stop clicking (Mouse(0))
            if (FishPos < MiniGameXLeft + (Control * 0.8)) {
                Mouse(0)
                tooltip, Direction: Max Left, 100, TooltipPosY8, 6
                tooltip, <, MiniGameXLeft + (Control * 0.8), (RobloxHeight * 1080) * 1015, 11
                Continue
            } 
            ; If fish is on the right side of the control bar, start clicking (Mouse(1))
            else if (FishPos > MiniGameXRight - (Control * 0.8)) {
                Mouse(1)
                tooltip, Direction: Max Right, 100, TooltipPosY8, 6
                tooltip, >, MiniGameXRight - (Control * 0.8), (RobloxHeight * 1080) * 1015, 12
                Continue
            }
            tooltip, |, MiniGameXLeft + (Control * 0.8), (RobloxHeight * 1080) * 1015, 11
            tooltip, |, MiniGameXRight - (Control * 0.8), (RobloxHeight * 1080) * 1015, 12
            
            ; Search for the white bar and adjust position, or search for the fallback bar color
            Bar := Search(Color_White) ? Search(Color_White) + Round(Control * 0.5) : Search(Color_Bar)
            ; If no bar is found, output a debug message and continue
            if !Bar {
                OutputDebug, Didn't Find Any Bar Color
                Continue
            }

            ; Calculate the range between the fish and the bar
            Range := FishPos - Bar

            ; If the fish is within the valid range, hold the mouse button
            If (Range >= 0) {
                tooltip, >, Bar, (RobloxHeight * 1080) * 1015, 14
                tooltip, Direction: >, 100, TooltipPosY8, 6
                Mouse(1)
                HoldTimer := A_TickCount
                OriginalPos := Bar
                Loop {
                    ; Continuously check the fish position and calculate the range
                    FishPos := Search(Color_Fish)
                    tooltip, ., FishPos, (RobloxHeight * 1080) * 1015, 13
                    Range := FishPos - OriginalPos
                    Hold := HoldFormula(Range)
                    
                    ; If holding conditions are met or fish position is invalid, exit the loop
                    if (!Hold || !FishPos || (A_TickCount - HoldTimer >= Hold) || Wait(10)) {
                        Success := (A_TickCount - HoldTimer >= Hold)
                        Break
                    }
                }
                
                ; If the action was successful, release the mouse and wait for the next action
                if (Success) {
                    Mouse(0)
                    Wait((A_TickCount - HoldTimer) * 0.6)
                }
            } else {
                tooltip, <, Bar, (RobloxHeight * 1080) * 1015, 14
                tooltip, Direction: <, 100, TooltipPosY8, 6
                ; If the fish is outside the range, release the mouse and adjust accordingly
                HoldTimer := A_TickCount
                Mouse(0)
                Range := Abs(Range)
                ContinueNow := False

                ; Wait for the required hold time and continue if conditions are met
                if (Wait(HoldFormula(Range) * 0.7)) {
                    Continue
                }
                tooltip,,,, 7
                Loop {
                    ; Search for the fish position
                    FishPos := Search(Color_Fish)
                    tooltip, ., FishPos, (RobloxHeight * 1080) * 1015, 13
                    ; Break if the fish is not found or the white bar is detected
                    if (!FishPos || Search(Color_White)) {
                        Break
                    }

                    ; If conditions are met, continue the loop
                    if (Wait(10)) {
                        ContinueNow := True
                        Break
                    }
                    
                    ; Adjust the current position of the bar and check if the fish is in range
                    CurrentPosition := Search(Color_Bar) - ((RobloxWidth / 800) * 30)
                    if (CurrentPosition <= FishPos) {
                        Break
                    }
                }

                ; If the action should continue, skip the rest of the code
                if (ContinueNow) {
                    Continue
                }

                ; Start holding the mouse and wait for the next action
                Mouse(1)
                if (Wait(A_TickCount - HoldTimer)) {
                    Mouse(0)
                    Continue
                }
                
                ; Release the mouse after the action
                Mouse(0)
            }
        }
        tooltip, Current Task: Minigame Ended Preparing to restart, 100, %TooltipPosY6%, 4
        tooltip,,,, 6
        tooltip,,,, 7
        tooltip,,,, 11
        tooltip,,,, 12
        tooltip,,,, 13
        tooltip,,,, 14
        CatchTotal++
        tooltip, Catch Total: %CatchTotal%, 100, %TooltipPosY3%, 20 
        ; Wait for 3 seconds before repeating the loop and trigger the Reels action
        Sleep 3000
        Reels()

        ; Reset the last shake time
        LastShakeTimer := A_TickCount
        
    }
}
Return

; Wait function that waits for a specific condition based on the fish's position and time
Wait(Time) {
    SleepTimer := A_TickCount  ; Save the current time as SleepTimer
    Loop {
        ; Search for the fish position
        FishPos := Search(Color_Fish)
        
        ; If no fish is found or the fish is outside the valid range, return the result (True if found, False if not)
        if !FishPos || (FishPos < MiniGameXLeft || FishPos > MiniGameXRight)
            return !!FishPos
        
        ; If the elapsed time exceeds the given time, break the loop
        if (A_TickCount - SleepTimer > Time)
            break
    }
    return False  ; If the loop finishes without a break, return False
}

; Function to search for a color within a defined area and return the X position
Search(Target) {
    ; Loop through each color and variation pair in the target list
    for Color, Variation in Target {
        ; Perform pixel search to find the color in the specified area
        PixelSearch, XPosition,, MiniGameXLeft, MiniGameYLeft, MiniGameXRight, MiniGameYRight, Color, Variation, Fast RGB
        if !ErrorLevel  ; If the color is found (ErrorLevel is 0)
            return XPosition  ; Return the X position of the found color
    }
    return False  ; Return False if no matching color is found
}

; Function to simulate mouse button press (down or up) based on the state
Mouse(State) {
    ; Check if the current mouse button state (down/up) matches the requested state
    If (GetKeyState("LButton", "P") != State) {
        ; If not, click the mouse down or up depending on the requested state
        Click, % State ? "Down" : "Up"
    }
}

; Function to handle the Reels action (reeling the fishing line)
Reels() {
    global 
    tooltip, Current Task: Casting Rod, 100, %TooltipPosY6%, 4
    ; Move the mouse to a specific position
    MouseMove, 80, 400
    
    ; Send the 'm' key to indicate the reeling action
    Send m
    ; Hold the left mouse button down for 2 seconds to reel in
    Click, Down
    Sleep Random(600, 1200)
    Click, Up  ; Release the mouse button
    tooltip, Current Task: Wait for the bobber to appear, 100, %TooltipPosY6%, 4
    Sleep Random(1000, 1200)
    ClickCount := 0
}
Random(Min, Max) {
    Random, i, Min, Max
    Return i
}
; Function to detect a "shake" action by checking if the pixel position has changed
ClickShake(ByRef ClickX, ByRef ClickY) {
    static MemoryX, MemoryY  ; Declare that variables that will be used here only
    ; Search for a white pixel within a specific area (shake detection)
    PixelSearch, ClickX, ClickY, %ShakeXLeft%, %ShakeYLeft%, %ShakeXRight%, %ShakeYRight%, 0xFFFFFF, 15, Fast
    If (ErrorLevel = 0) {  ; If the pixel is found
        ; If the pixel position has changed, perform a click at the new position
        if (ClickX != MemoryX || ClickY != MemoryY) {
            Click, %ClickX%, %ClickY%
            MemoryX := ClickX, MemoryY := ClickY  ; Save the new position to memory
            Sleep 100
            Return True  ; Return True to indicate a successful shake detection
        }
    }
    Return False  ; Return False if no shake was detected
}

; Hotkey to exit the script when the spacebar is pressed
$space::exitapp

; Function to calculate hold time based on pixel distance (for Cream's Macro)
HoldFormula(pixel) {
    global RobloxWidth, TooltipPosY9  ; Use the global RobloxWidth variable
    ; Define a set of data pairs for calculating hold times
    data := [[0, 0], [16, 0], [132, 1], [217, 5], [365, 29], [450, 54], [534, 91], [632, 151], [736, 234], [817, 310], [900, 382], [997, 469], [1081, 541], [1164, 613], [1250, 686], [1347, 711], [1448, 721], [1531, 724], [1531, 9999]]
    
    ; Adjust data based on Roblox width (scaling based on screen width)
    for i, pair in data {
        pair[2] := Floor(pair[2] * (RobloxWidth / 800))  ; Scale the third value of each pair
        if (pixel < pair[2]) {
            lower := data[i - 1], upper := pair  ; Find the lower and upper pairs for interpolation
            break
        }
    }
    
    hold := lower[1] + (pixel - lower[2]) * (upper[1] - lower[1]) / (upper[2] - lower[2])
    tooltip, Hold: %hold%ms, 100, TooltipPosY9, 7
    ; Perform linear interpolation to calculate the hold time based on the pixel distance
    return % hold
}
