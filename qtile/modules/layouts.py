from libqtile import layout
from libqtile.config import Match
from .settings import BACKGROUND

layout_theme = {
    "border_width": 2,
    "border_focus": "#3e65a3",
    "border_normal": BACKGROUND,
}

layouts = [
    layout.Columns(
        **layout_theme,
        margin=[8, 4, 6, 4],
        margin_on_single=[10, 5, 10, 5],
    ),
    layout.Max(),
    # layout.TreeTab(
    #     panel_width=10,
    #     margin_left=0,
    #     margin_y=0,
    #     padding_left=5,
    #     padding_x=10,
    #     padding_y=30,
    #     section_top=10,
    #     section_left=0,
    #     section_bottom=0,
    #     section_padding=0,
    #     border_width=0,
    #     vspace=15,
    #     section_fontsize=0,
    #     fontsize=0,
    #     bg_color=BACKGROUND,
    #     active_bg="#416f73",
    #     section_fg="#232829",
    #     previous_on_rm=True,
    # ),
]

floating_layout = layout.Floating(
    border_width=2,
    border_focus="#3e65a3",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)
