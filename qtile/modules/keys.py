from libqtile.lazy import lazy
from libqtile.config import Key, KeyChord
from .groups import *
from .settings import (
    BRIGHTNESSDOWN,
    BRIGHTNESSUP,
    BROWSER,
    LOWERVOLUME,
    MOD,
    ROFI,
    RAISEVOLUME,
    MUTEVOLUME,
)

keys = [
    *[
        Key(key[0], key[1], *key[2:])
        for key in [
            # Switch between windows
            ([MOD], "h", lazy.layout.left()),
            ([MOD], "l", lazy.layout.right()),
            ([MOD], "j", lazy.layout.down()),
            ([MOD], "k", lazy.layout.up()),
            (
                [MOD, "shift"],
                "Return",
                lazy.layout.toggle_split(),
            ),
            ([MOD], "apostrophe", lazy.spawn(ROFI)),
            ([MOD], "b", lazy.spawn(BROWSER)),
            ([MOD], "Tab", lazy.next_layout()),
            ([MOD, "shift"], "space", lazy.layout.flip()),
            ([MOD], "Return", lazy.group["scratchpad"].dropdown_toggle("term")),
            (
                [MOD],
                "f",
                lazy.spawn('notify-send $(curl "wttr.in?T0")'),
            ),
            ([], "XF86AudioRaiseVolume", lazy.spawn(RAISEVOLUME)),
            ([], "XF86AudioLowerVolume", lazy.spawn(LOWERVOLUME)),
            ([], "XF86AudioMute", lazy.spawn(MUTEVOLUME)),
            ([], "XF86MonBrightnessUp", lazy.spawn(BRIGHTNESSUP)),
            ([], "XF86MonBrightnessDown", lazy.spawn(BRIGHTNESSDOWN)),
        ]
    ],
    KeyChord(
        [MOD],
        "q",
        [
            Key(key[0], key[1], *key[2:])
            for key in [
                ([], "r", lazy.restart()),
                ([], "q", lazy.shutdown()),
            ]
        ],
        mode="Qtile",
    ),
    KeyChord(
        [MOD],
        "w",
        [
            Key(key[0], key[1], *key[2:])
            for key in [
                ([], "h", lazy.layout.grow_left()),
                ([], "l", lazy.layout.grow_right()),
                ([], "j", lazy.layout.grow_down()),
                ([], "k", lazy.layout.grow_up()),
                ([], "n", lazy.layout.normalize()),
                (
                    [],
                    "f",
                    lazy.window.toggle_floating(),
                ),
                (
                    [],
                    "m",
                    lazy.layout.maximize(),
                ),
                (
                    ["shift"],
                    "h",
                    lazy.layout.shuffle_left(),
                ),
                (
                    ["shift"],
                    "l",
                    lazy.layout.shuffle_right(),
                ),
                (["shift"], "j", lazy.layout.shuffle_down()),
                (["shift"], "k", lazy.layout.shuffle_up()),
                ([], "a", lazy.layout.swap_column_left()),
                ([], "d", lazy.layout.swap_column_right()),
                ([], "q", lazy.window.kill()),
            ]
        ],
        mode="Windows",
    ),
]
for i in groups[:-1]:
    keys.extend(
        [
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),
            ),
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
            ),
        ]
    )
