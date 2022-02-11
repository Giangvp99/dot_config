from libqtile import widget
import os
from .utils.colors import COLS
from .settings import BACKGROUND, FONT, FONT_PARAMS

widget_defaults = dict(
    font=FONT,
    fontsize=12,
    padding=3,
    background=BACKGROUND,
)
extension_defaults = widget_defaults.copy()


# ----------------------------------------------------------------------------------------------
spacer = widget.Spacer()
sep30 = widget.Sep(linewidth=0, padding=30)
sep20 = widget.Sep(linewidth=0, padding=20)
sep10 = widget.Sep(linewidth=0, padding=10)
sep5 = widget.Sep(linewidth=0, padding=5)

# ----------------------------------------------------------------------------------------------
group_box = widget.GroupBox(
    font=FONT,
    fontsize=16,
    highlight_method="text",
    this_current_screen_border=COLS["ws_current"],
    active=COLS["ws_active"],
    inactive=COLS["ws_inactive"],
    mouse_callbacks={
        "Button1": None,
        "Button2": None,
        "Button3": None,
        "Button4": None,
        "Button5": None,
    },
)
# ----------------------------------------------------------------------------------------------
clock = widget.Clock(
    **FONT_PARAMS,
    format=" %d-%m %a  <b>%H:%M</b>",
    foreground=COLS["aqua"],
)
# ----------------------------------------------------------------------------------------------
updates = widget.CheckUpdates(
    **FONT_PARAMS,
    update_interval=1800,
    distro="Arch_yay",
    display_format=" {updates}",
    colour_have_updates=COLS["aqua"],
    colour_no_updates=COLS["aqua"],
)

# ----------------------------------------------------------------------------------------------
memory = widget.Memory(
    **FONT_PARAMS,
    format=" {MemUsed:.1f}{MemTotal:.1f}",
    measure_mem="G",
    foreground=COLS["red"],
)
# ----------------------------------------------------------------------------------------------
kbd = widget.KeyboardLayout(
    **FONT_PARAMS,
    configured_keyboards=["au", "us", "ru"],
    display_map={"au": "US", "us": "VN"},
    fmt=" {}",
    foreground=COLS["purple"],
    mouse_callbacks={"Button1": None},
)
# ----------------------------------------------------------------------------------------------
layout_icons = widget.CurrentLayoutIcon(
    custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
    padding=5,
    scale=0.6,
)
# ----------------------------------------------------------------------------------------------
window_name = widget.WindowName(**FONT_PARAMS, foreground=COLS["white_hard"])
# ----------------------------------------------------------------------------------------------
wttr = widget.Wttr(
    font=FONT,
    fontsize=14,
    location={"Moscow": "Moscow"},
    format="%c%t %w",
    foreground=COLS["cyan"],
)
# ----------------------------------------------------------------------------------------------
wlan = widget.Wlan(
    format="直 {essid}",
    interface="wlp1s0",
    **FONT_PARAMS,
    foreground=COLS["orange_hard"],
)
# ----------------------------------------------------------------------------------------------
net = widget.Net(
    font=FONT,
    fontsize=14,
    format="{down}   {up}",
    foreground=COLS["yellow_hard"],
)
# ----------------------------------------------------------------------------------------------
bluetooth = widget.Bluetooth(
    **FONT_PARAMS,
)
# ----------------------------------------------------------------------------------------------
chord = widget.Chord(
    name_transform=lambda a: "者" if a == "Windows" else "蘆",
    font=FONT,
    fontsize=16,
    foreground=COLS["aqua_hard"],
)
# ----------------------------------------------------------------------------------------------
home = widget.DF(
    visible_on_warn=False,
    partition="/home",
    format=" {uf}{m}-{r:.0f}",
    font=FONT,
    fontsize=14,
    foreground=COLS["yellow"],
)
root = widget.DF(
    visible_on_warn=False,
    partition="/",
    format=" {uf}{m}-{r:.0f}",
    font=FONT,
    fontsize=14,
    foreground=COLS["green"],
)
# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------
