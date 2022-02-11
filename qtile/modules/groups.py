from libqtile.config import Group, Match, ScratchPad, DropDown

groups = [
    Group("1", label=" "),
    Group(
        "2", label=" ", layout="max", matches=[Match(wm_class=["kitty", "neovim"])]
    ),
    Group("3", label="爵", matches=[Match(wm_class=["firefox"])]),
    Group("4", label="  ", matches=[Match(wm_class=["Thunar"])]),
    Group("5", label=" ", matches=[]),
    Group("6", label=" ", matches=[]),
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term",
                "alacritty",
                x=0.15,
                y=0,
                width=0.7,
                height=0.6,
                opacity=0.9,
            ),
        ],
    ),
]
