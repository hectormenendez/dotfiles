import qualified Data.Map as Map
import qualified System.IO(putStrLn)

import qualified XMonad as X
import qualified XMonad.StackSet as SS
import qualified XMonad.Hooks.EwmhDesktops as Desktops
import qualified XMonad.Hooks.ManageDocks as ManageDocks
import qualified XMonad.Layout.ToggleLayouts as ToggleLayouts
import qualified XMonad.Layout.ThreeColumns as Layout3Col
import qualified XMonad.Layout.Spiral as LayoutSpiral
import qualified XMonad.Layout.Grid as LayoutGrid
import qualified XMonad.Layout.LayoutCombinators as L

import XMonad.Util.EZConfig(removeKeysP,additionalKeysP)
import XMonad.Util.SpawnOnce(spawnOnce)
import XMonad.Hooks.ManageDocks(avoidStruts,manageDocks)
import XMonad.Hooks.ManageHelpers(doRectFloat)
import XMonad.Hooks.SetWMName(setWMName)

-- How many workspaces?
myWorkspaces = ["1", "2", "3", "4", "5", "6"]

-- The default terminal emulator
myTerminal = "kitty"

-- What modifier keys are we going to use
myMaskMod = X.mod4Mask

-- Automatically focus window by passing the mouse over
--myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Configure border surrounding the window
myBorderWidth = 1
myBorderColorNormal = "#000000"
myBorderColorFocused = "#666666"

-- The initial number of windows to present in each layout
myAmountScreens = 1

mySizeUnit = (3 / 100) -- Resize amount percentage when resizing windows
mySizeHalf = (1 / 2) -- Represents half the screen
mySizeGolden = (6 / 7) -- 0.856, the golden ratio

-- Establish the default layout and the cycling order
myHookLayout = (
    -- A three-column layout where windows are arranged in three columns on the screen.
    Layout3Col.ThreeCol myAmountScreens mySizeUnit mySizeHalf L.||| 
    -- A every window has the same dimensions
    LayoutGrid.Grid L.||| 
    -- A tiling layout where each window is split evenly across the screen.
    X.Tall myAmountScreens mySizeUnit mySizeHalf L.|||
    -- A layout where each window takes up the entire screen.
    X.Full L.|||
    -- A simulation of the golden ratio, mostly useless, but fun.
    LayoutSpiral.spiral mySizeGolden)

-- NOTE: ewmhFullscreen: Fixes an issue with videos in Google Chrome
main = X.xmonad $ Desktops.ewmhFullscreen . Desktops.ewmh $ X.def
    {
        -- Run these on startup
        X.startupHook = do
            -- Compatibility with JAVA applications (GUI)
            setWMName "LG3D"
            -- Background manager
            spawnOnce "nitrogen --restore &"
            -- Widgets (used for performance widget on bottom)
            spawnOnce "conky -c $HOME/.config/conky/default.conkyrc",
        X.manageHook = X.composeAll [
            X.className X.=? "1Password" X.--> doRectFloat (SS.RationalRect 0.25 0.25 0.5 0.5),
            X.manageHook X.def X.<+> manageDocks
        ],
        X.modMask = myMaskMod,
        X.workspaces = myWorkspaces,
        X.terminal = myTerminal,
        X.borderWidth = myBorderWidth,
        X.normalBorderColor = myBorderColorNormal,
        X.focusedBorderColor = myBorderColorFocused,
        X.focusFollowsMouse = myFocusFollowsMouse,
        X.layoutHook = myHookLayout
    }

    -- XMonad is sneaky with the keybindings, lets unset everything just to be sure.
    `removeKeysP` [
        "M-S-<Return>", -- Launch terminal
        "M-S-/", -- Run xmessage with a summary of the default keybindings (useful for beginners)
        "M-p", -- Launch dmenu
        "M-S-p", -- Launch gmrun
        "M-S-c", -- Close the focused window
        "M-S-q", -- Quit xmonad
        "M-q", -- Restart xmonad
        "M-<Space>", -- Rotate through the available layout algorithms
        "M-S-<Space>", -- Reset the layouts on the current workspace to default
        "M-n", -- Resize viewed windows to the correct size
        "M-<Tab>", -- Move focus to the next window
        "M-S-<Tab>", -- Move focus to the previous window
        "M-j", -- Move focus to the next window
        "M-k", -- Move focus to the previous window
        "M-m", -- Move focus to the master window
        "M-<Return>", -- Swap the focused window and the master window
        "M-S-j", -- Swap the focused window with the next window
        "M-S-k", -- Swap the focused window with the previous window
        "M-h", -- Shrink the master area
        "M-l", -- Expand the master area
        "M-t", -- Push window back into tiling
        "M-,", -- Increment the number of windows in the master area
        "M-.", -- Deincrement the number of windows in the master area
--        "M-1", -- Switch to workspace 1
--        "M-2", -- Switch to workspace 2
--        "M-3", -- Switch to workspace 3
--        "M-4", -- Switch to workspace 4
--        "M-5", -- Switch to workspace 5
--        "M-6", -- Switch to workspace 6
--        "M-7", -- Switch to workspace 7
--        "M-8", -- Switch to workspace 8
--        "M-9", -- Switch to workspace 9
--        "M-S-1", -- Move client to workspace 1
--        "M-S-2", -- Move client to workspace 2
--        "M-S-3", -- Move client to workspace 3
--        "M-S-4", -- Move client to workspace 4
--        "M-S-5", -- Move client to workspace 5
--        "M-S-6", -- Move client to workspace 6
--        "M-S-7", -- Move client to workspace 7
--        "M-S-8", -- Move client to workspace 8
--        "M-S-9", -- Move client to workspace 9
        "M-w", -- Switch to screen 1
        "M-e", -- Switch to screen 2
        "M-r", -- Switch to screen 3
        "M-S-w", -- Move client to screens 1
        "M-S-e", -- Move client to screens 2
        "M-S-r" -- Move client to screens 3
    ]

    -- NOTE:
    -- 'X.spawn' runs a shell command, 
    `additionalKeysP` [

        ------------------------------------------ Controlling XMonad
        
        -- quit
        ("M-S-q", X.spawn "killall xmonad-x86_64-linux"),

        -- restart
        ("M-S-r", X.spawn "xmonad --recompile && xmonad --restart"), 
    

        ------------------------------------------ External Apps
        
        -- open default terminal
        ("M-S-<Return>", X.spawn myTerminal),

        ("M-<Space>", X.spawn "rofi -show combi -show calc -show emoji -show filebrowser"),
        ("M-S-<Space>", X.spawn "rofimoji" ),
        ("<Print>", X.spawn "scrot --select '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Downloads/'"),

        ------------------------------------------ Controlling Windows

        -- quit current window
        ("M-q", X.kill ),

        -- toggle floating current window
        ("M-<Backspace>", X.withFocused toggleFloat),

        -- refresh windows to their original size
        ("M-=", X.refresh),

        -- focus next window
        ("M-<Tab>", X.windows SS.focusDown),

        -- focus previous window
        ("M-S-<Tab>", X.windows SS.focusUp),

        -- make window smaller
        ("M-h", X.sendMessage X.Shrink),

        -- make window bigger
        ("M-l", X.sendMessage X.Expand),

        -- swap with next window
        ("M-S-h", X.windows SS.swapDown),

        -- swap with next window
        ("M-S-l", X.windows SS.swapUp),

        ------------------------------------------ Controlling Layouts

        -- rotate through the available layout algorithms
        ("M-`", X.sendMessage X.NextLayout),

        -- switch directly to full layout
        -- https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Layout-LayoutCombinators.html
        ("M-S-`", X.sendMessage $ X.JumpToLayout "Full")

    ]

    where
        toggleFloat win = X.windows (\s ->
            if Map.member win (SS.floating s)
            then SS.sink win s
            else SS.float win (SS.RationalRect 0.25 0.25 0.5 0.5) s)


-- ORIGINAL BINDINGS:

-- `additionalKeysP` [
--     -- swap the focused window with the next window.
--     ("M-S-j", X.windows W.swapDown),
-- 
--     -- swap the focused window with the previous window.
--     ("M-S-k", X.windows W.swapUp),
-- 
--     -- shrink the master area.
--     ("M-h", X.sendMessage Shrink),
-- 
--     -- expand the master area.
--     ("M-l", X.sendMessage Expand),
-- 
--     -- push window back into tiling.
--     -- 'withFocused' runs a function with the currently focused window,
--     -- 'windows . W.sink' makes the window go back to its place in the tiling layout.
--     ("M-t", withFocused $ windows . W.sink),
-- 
--     -- increment the number of windows in the master area.
--     ("M-,", X.sendMessage (IncMasterN 1)),
-- 
--     -- decrement the number of windows in the master area.
--     ("M-.", X.sendMessage (IncMasterN (-1))),
-- 
--     -- quit xmonad. 'X.io' performs an IO action, 'exitSuccess' terminates the program.
--     ("M-S-q", X.io exitSuccess),
-- 
--     -- restart xmonad. The command recompiles and restarts xmonad.
--     ("M-q", X.spawn "xmonad --recompile; xmonad --restart"),
-- 
--     -- run xmessage with a summary of the default keybindings.
--     -- 'xmessage' is a tool to show a message box with some text.
--     ("M-S-/", X.spawn "xmessage help"),
-- 
--     -- Generate keybindings for workspaces.
--     -- This is a list comprehension that generates a list of keybindings.
--     -- For every pair (i, k) in the zip of workspace names and keys from 1 to 9,
--     -- and for every pair (f, m) of functions and masks, generate a keybinding.
--     -- The generated keybinding is:
--     --   if "Mod+m, k" is pressed, apply function f to workspace i.
--     -- The functions are:
--     --   'W.greedyView' (switch to workspace)
--     --   'W.shift' (move focused window to workspace).
--     [
--         ("M-" ++ [k], windows $ f i) |
--         (i, k) <- zip (XMonad.workspaces conf) ['1'..'9'],
--         (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
--     ],
-- 
--     -- Generate keybindings for screens.
--     -- This is another list comprehension that generates a list of keybindings.
--     -- For every pair (key, sc) of keys ('w', 'e', 'r') and screen numbers (0, 1, 2),
--     -- and for every pair (f, m) of functions and masks, generate a keybinding.
--     -- The generated keybinding is:
--     --   if "Mod+m, key" is pressed, apply function f to screen sc.
--     --   The functions are:
--     --   W.view' (switch to screen)
--     --   'W.shift' (move focused window to screen).
--     [
--         ("M-" ++ [key], screenWorkspace sc >>= flip whenJust (windows . f)) |
--         (key, sc) <- zip ['w', 'e', 'r'] [0..],
--         (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
--     ]
-- ]
