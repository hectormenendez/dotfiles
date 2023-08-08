import os
import subprocess

from libqtile.lazy import lazy
from libqtile.config import Key, Rule, Match
from libqtile import hook

# -- local imports
from graphical_notifications import Notifier

# plugin that acts as notification server and draws notification windows
# there are keybindings to handle the notifications, but I haven't enabled them.
notifier = Notifier()

# run these commands at startup (not on restarts)
@hook.subscribe.startup_once
def autostart():
    if os.environ.get("QTILE_XEPHYR"): return # not when testing tho
    subprocess.Popen([os.path.expanduser("~/.config/qtile/autostart.sh")])    

# the main modifier key mod4 is super mod1 is alt
mod = "mod4"

# java-based apps compatibility
wmname = "LG3D"

# apps cannot go fullscreen themselves
auto_fullscreen = True

# apps cannot minimize themselves
auto_minimize = False

# floating windos are kept always-on-top (X11-only)
floats_kept_above = True

# whenever the mouse goes, the focus goes
follow_mouse_focus = True

keys = [
    # --- base 

    # keep our options opened
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Quit") ,
    # because shit happens
    Key([mod, "shift"], "r", lazy.reload_config(), lazy.restart(), desc="Reload"),
    # now we have the basics covered
    Key([mod, "shift"], "Return", lazy.spawn("kitty"), desc="Terminal"),

    # --- managing apps

    Key([mod], "q", lazy.window.kill(), desc="Quit Current App"),
    Key([mod], "space", lazy.spawn("rofi -show combi -show calc -show emoji -show filebrowser")), 
    Key([mod], "tab", lazy.spawn("rofi -show window")),
    Key([mod, "shift"], "space", lazy.spawn("rofimoji")),

    # --- managing layout
    Key([mod], "escape", lazy.window.toggle_floating(), desc="Toggle Floating"),

    Key([mod], "l", lazy.layout.right()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),

    Key([mod, "shift"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key([mod, "shift"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key([mod, "shift"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key([mod, "shift"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),

    # --- managing computer
]

