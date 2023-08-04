import os
import subprocess

from libqtile.lazy import lazy
from libqtile.config import Key, Rule, Match
from libqtile import hook

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
# TODO: Test with youtube
auto_fullscreen = False

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

    # --- switching apps

    Key([mod], "space", lazy.spawn("rofi -show combi -show calc -show emoji -show filebrowser")), 
    Key([mod], "tab", lazy.spawn("rofi -show window")),
    Key([mod, "shift"], "space", lazy.spawn("rofimoji")),
]

