#MaxThreadsPerHotkey 1

; Defaults
userToggleKey := "v"
ingameFlashlightKey := "j"
strobeDelay := 50

MsgBox, Welcome. You can customize your keys next. Please use lowercase single letters only. Do not enter "ms", "milliseconds" just the digits.

; Ask for toggle key
InputBox, userToggleKeyInput, Toggle Key, Enter the key you want to use to toggle strobe. (default: V), , 300, 150,,, , %userToggleKey%
if (!ErrorLevel && userToggleKeyInput != "") {
    userToggleKey := userToggleKeyInput
}

; Ask for flashlight key
InputBox, ingameFlashlightInput, In-Game Flashlight Key, Enter the keybind used in-game to activate flashlight. (default: J), , 300, 150,,, , %ingameFlashlightKey%
if (!ErrorLevel && ingameFlashlightInput != "") {
    ingameFlashlightKey := ingameFlashlightInput
}

; Ask for strobe delay
InputBox, strobeDelayInput, Strobe Delay, Enter delay between toggling on/off in milliseconds. (default: 50), , 300, 150,,, , %strobeDelay%
if (!ErrorLevel && strobeDelayInput != "") {
    strobeDelay := strobeDelayInput
}

msg := "Thank you! '" . userToggleKey . "' will toggle '" . ingameFlashlightKey . "'. Strobe delay set to " . strobeDelay . " ms. Press Ctrl+" . ingameFlashlightKey . " to immediately stop the script if needed. Close this message to start."
MsgBox, %msg%

; Initializing
Menu, Tray, Tip, Strobe Status: OFF
toggle := false

; Create dynamic hotkeys
Hotkey, % "$" . userToggleKey, ToggleStrobe, On
Hotkey, ^%ingameFlashlightKey%, PanicExit, On
return

ToggleStrobe:
    toggle := !toggle
    if (toggle) {
        Menu, Tray, Tip, Strobe Status: ON
        SetTimer, DoStrobe, %strobeDelay%
    } else {
        SetTimer, DoStrobe, Off
        Menu, Tray, Tip, Strobe Status: OFF
    }
return

DoStrobe:
    Send, %ingameFlashlightKey%
return

PanicExit:
    SetTimer, DoStrobe, Off
    Menu, Tray, Tip, Strobe Status: OFF
    MsgBox, Cya! Thanks for using. :3 © 2025 Greenstone51
    ExitApp
return
