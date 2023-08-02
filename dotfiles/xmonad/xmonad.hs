import qualified Data.Map as Map
import qualified System.IO(putStrLn)

import qualified XMonad as X

import qualified XMonad.StackSet as StackSet

import qualified XMonad.Layout.ToggleLayouts as ToggleLayouts
import qualified XMonad.Layout.ThreeColumns as Layout3Col

import XMonad.Util.EZConfig(removeKeysP,additionalKeysP)
import XMonad.Util.SpawnOnce(spawnOnce)

import qualified XMonad.Hooks.EwmhDesktops as Desktops
import XMonad.Hooks.ManageDocks(avoidStruts,manageDocks)
import XMonad.Hooks.ManageHelpers(doRectFloat)
import XMonad.Hooks.SetWMName(setWMName)

-- How many workspaces?
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7"]

-- The default terminal emulator
myTerminal = "alacritty"

-- What modifier keys are we going to use
myMaskMod = X.mod4Mask

-- Automatically focus window by passing the mouse over
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Configure border surrounding the window
myBorderWidth = 1
myBorderColorNormal = "#000000"
myBorderColorFocused = "#666666"

-- Wrap layouts so there's automatic spacing for docks,panels, trays
myLayout =
    avoidStruts $
    ToggleLayouts.toggleLayouts layoutFull -- sets the default layout to full
    (
        layoutTiled X.|||
        layout3Col X.|||
        layoutFull
    ) where
        layoutFull = X.Full
        layoutTiled = X.Tall 1 (3/100) (1/2)
        layout3Col = Layout3Col.ThreeCol 1 (3/100) (1/2)

-- myLayout = ThreeColMid 1 (3/100) (1/2) ||| master tall ||| Full
--     where
--         tall = Tall 1 (3/100) (1/2)
--         master = masterWindowGaps tall

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
            X.className X.=? "1Password" X.--> doRectFloat (StackSet.RationalRect 0.25 0.25 0.5 0.5),
            X.manageHook X.def X.<+> manageDocks
        ],
        X.modMask = myMaskMod,
        X.workspaces = myWorkspaces,
        X.terminal = myTerminal,
        X.borderWidth = myBorderWidth,
        X.normalBorderColor = myBorderColorNormal,
        X.focusedBorderColor = myBorderColorFocused,
        X.focusFollowsMouse = myFocusFollowsMouse,
        X.layoutHook = myLayout
    }

    `removeKeysP` [
        -- Used by vscode
        "M-p",
        "M-S-p",
        "M-,",
        "M-j",
        "M-S-e",
        -- additionalKeys
        "<Print>",
        "M-S-q",
        "M-q",
        "M-<Backspace>",
        "M-<Space>",
        "M-<Tab>",
        "M-S-<Space>",
        "M-S-`"
    ]

    `additionalKeysP` [
        ( "<Print>", X.spawn "scrot --select '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Downloads/'"),
        ( "M-S-q", X.spawn "killall xmonad-x86_64-linux" ),
        ( "M-q", X.kill ),
        ( "M-<Backspace>", X.withFocused toggleFloat),
        ( "M-<Space>", X.spawn "rofi -show combi -show calc -show emoji -show filebrowser" ),
        ( "M-<Tab>", X.spawn "rofi -show window" ),
        ( "M-S-<Space>", X.spawn "rofimoji" ),
        ( "M-S-`", X.sendMessage ToggleLayouts.ToggleLayout)
    ]

    where
        toggleFloat win = X.windows (\s ->
            if Map.member win (StackSet.floating s)
            then StackSet.sink win s
            else StackSet.float win (StackSet.RationalRect 0.25 0.25 0.5 0.5) s)

    -- X.layoutHook X.def


-- myLayout =
-- 	avoidStruts $
-- 	smartBorders $
-- 	toggleLayouts Full
-- 	(tiled ||| ThreeColMid 1 (3/100) (1/3) ||| Mirror tiled ||| tabbedLayout ||| gimpLayout)
-- 	where
-- 		tiled = Tall nmaster delta ratio
-- 		nmaster = 1
-- 		delta = 3/100
-- 		ratio = toRational(2/(1+sqrt(5)::Double))

-- 		gimpLayout = named "Gimp" (
-- 			withIM (0.15) (Role "gimp-toolbox") $
-- 			reflectHoriz $
-- 			withIM (0.2) (Role "gimp-dock") Full
-- 			)
-- 		tabbedLayout = named "Tabbed" (tabbedBottom shrinkText myTabConfig)
-- 		myTabConfig = defaultTheme
-- 			{ activeColor = "#1a1a1a"
-- 			, inactiveColor = "#000000"
-- 			, urgentColor = "#1a1a1a"
-- 			, activeTextColor = "#00ffff"
-- 			, inactiveTextColor = "#ffbe33"
-- 			, urgentTextColor = "#ff00ff"
-- 			, activeBorderColor = "#000000"
-- 			, inactiveBorderColor = "#1a1a1a"
-- 			, urgentBorderColor = "#000000"
-- 			}

