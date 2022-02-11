from libqtile.config import Click, Drag
from libqtile.lazy import lazy
from .settings import CENTERMOUSE, LEFTMOUSE, MOD, RIGHTMOUSE

mouse = [
    Drag(
        [MOD],
        LEFTMOUSE,
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], RIGHTMOUSE, lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], CENTERMOUSE, lazy.window.bring_to_front()),
]
