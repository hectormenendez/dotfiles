import Data.Map as Map

import XMonad as X

import XMonad.StackSet as StackSet

import XMonad.Util.EZConfig as EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce(spawnOnce)

import XMonad.Hooks.EwmhDesktops(fullscreenEventHook)
import XMonad.Hooks.ManageDocks(avoidStruts,manageDocks)
import XMonad.Hooks.ManageHelpers(doRectFloat)
import XMonad.Hooks.SetWMName

import XMonad.Actions.GridSelect as GridSelect
import XMonad.Actions.Minimize as Minimize

-- xmproc <- spawnPipe "xmobar"
main = xmonad $ defaultConfig
    {
        -- Run these on startup
        X.startupHook = do
            -- Compatibility with JAVA applications (GUI)
            setWMName "LG3D"
            -- Composition manager (animation)
            spawnOnce "picom --config ~/.picom --experimental-backends &"
            -- Background manager
            spawnOnce "nitrogen --restore &"
            -- Widgets and niceties
            spawnOnce "conky -c $HOME/.config/conky/default.conkyrc",
        -- Wrap layouts so there's automatic spacing for docks,panels, trays
        X.layoutHook = avoidStruts $ X.layoutHook defaultConfig,
        X.manageHook = composeAll [
            className =? "1Password" --> doRectFloat (StackSet.RationalRect 0.25 0.25 0.5 0.5),
            X.manageHook defaultConfig <+> manageDocks
        ],
        -- How many workspaces?
        X.workspaces = ["1", "2", "3", "4", "5"],
        -- The default terminal emulator
        X.terminal = "alacritty",
        -- Configure border surrounding the window
        X.borderWidth = 1,
        X.normalBorderColor = "#000000",
        X.focusedBorderColor = "#666666",
        -- Use super as Modifier key
        X.modMask = mod4Mask,
        -- Automatically focus window by passing the mouse over
        X.focusFollowsMouse = True,
        -- Fixes an issue with videos in Google Chrome
        X.handleEventHook = fullscreenEventHook
    }
    `EZConfig.removeKeysP` [
        -- start additionalKeys
        "M-<Space>",
        "M-q",
        "M-<Shift>-q",
        "M-`",
        "M-<Shift>-r",
        "M-g",
        "M-<Backspace>",
        "M-m",
        "M-<Shift>-m",
        -- end additionalKeys
        "M-p", -- used for VSCode
        "M-S-p", -- used for VSCode
        "M-,", -- used for Settings TODO: findout what this key did
        "M-w", -- used for closing tabs TODO: findout whats this key did
        "M-S-w" -- used for reopening tabs TODO: findout whats this key did
    ]
    `EZConfig.additionalKeysP` [
        -- use the custom-built dmenu_run on ~/Source/AUR/dmenu
        ( "M-<Space>", spawn "rofi -show combi" ),
        ( "M-q", kill ),
        ( "M-<Shift>-q", spawn "killall xmonad" ),
        ( "M-`", spawn "xset dpms force off"), -- turn off screen
        ( "M-<Shift>-r", spawn "xmonad --recompile; xmonad --restart" ),
        ( "M-g", GridSelect.goToSelected GridSelect.defaultGSConfig ),
        ( "M-<Backspace>", withFocused _toggleFloat),
        ( "M-m", withFocused minimizeWindow ),
        ( "M-<Shift>-m", Minimize.withLastMinimized Minimize.maximizeWindowAndFocus ),
        ( "M-<Alt>-<Ctrl>-p", spawn "1password"),
        ( "<Print>", spawn "scrot --select '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Downloads/'")
    ]
    where
        _toggleFloat w = windows (\s ->
            if Map.member w (StackSet.floating s)
            then StackSet.sink w s
            else StackSet.float w (StackSet.RationalRect 0.25 0.25 0.5 0.5) s)
