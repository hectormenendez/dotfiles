
import XMonad
import XMonad.Hooks.EwmhDesktops(fullscreenEventHook)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce(spawnOnce)
import XMonad.Util.EZConfig(additionalKeysP)

_startup = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --config ~/.picom &"

-- xmproc <- spawnPipe "xmobar"
main = xmonad $ defaultConfig
    {
        startupHook = _startup,
        -- How many workspaces?
        workspaces = ["1", "2", "3"],
        -- The default terminal emulator
        terminal = "alacritty",
        -- Configure border surrounding the window
        borderWidth = 2,
        normalBorderColor = "#333344",
        focusedBorderColor = "#ffCC66",
        -- Use super instead of alt ad modifier key
        modMask = mod4Mask,
        -- Automatically focus window by passing the mouse over
        focusFollowsMouse = True,
        -- Fixes an issue with videos in Google Chrome
        handleEventHook = fullscreenEventHook
    }
    `additionalKeysP` [
    	-- use the custom-built dmenu_run on ~/Source/AUR/dmenu
        ( "M-p", spawn "rofi -show combi" )
    ]
