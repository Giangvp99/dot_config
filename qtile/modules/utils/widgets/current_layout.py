from libqtile import hook
from libqtile.widget import base
from ...settings import FONT
from ..colors import COLS

# ----------------------------------------------------------------------------------------------
class MyCurrentLayout(base._TextBox):
    def __init__(self, **config):
        base._TextBox.__init__(self, "", **config)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        # layout_id = self.bar.screen.group.current_layout
        self.setup_hooks()
        # self.text = self.bar.screen.group.layouts[layout_id].name

        self.add_callbacks({})

    def setup_hooks(self):
        def hook_response(layout, group):
            if group.screen is not None and group.screen == self.bar.screen:
                if layout.name == "max":
                    self.text = "ﱢ"
                elif layout.name == "columns":
                    self.text = "﩯"
                elif layout.name == "treetab":
                    self.text = "况"
                else:
                    self.text = "勒"
                self.bar.draw()

        hook.subscribe.layout_change(hook_response)


# 类 離 恵

current_layout = MyCurrentLayout(font=FONT, fontsize=16, foreground=COLS["white"])
