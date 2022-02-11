from libqtile.config import Screen
from libqtile import bar
from .widgets import *
from .utils.widgets.index import *

screens = [
    Screen(
        top=bar.Bar(
            [
                group_box,
                sep10,
                chord,
                sep10,
                window_tabs,
                sep20,
                net,
                sep20,
                wlan,
                sep20,
                wttr,
                widget.Spacer(),
                clock,
                widget.Spacer(),
                updates,
                sep20,
                cpu,
                sep20,
                memory,
                sep20,
                home,
                sep20,
                root,
                sep20,
                kbd,
                sep5,
                pulsevolume,
                sep5,
                backlight,
                sep5,
                battery2,
                sep5,
                current_layout,
                sep5,
            ],
            32,
            background=BACKGROUND,
        ),
    ),
]
