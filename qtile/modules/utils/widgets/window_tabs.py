from libqtile import widget, hook, bar
from libqtile.log_utils import logger
from libqtile.widget import base
from ..colors import COLS
from ...settings import FONT_PARAMS

# ----------------------------------------------------------------------------------------------
class MyWindowTabs(widget.WindowTabs):
    defaults = [
        ("separator", " | ", "Task separator text."),
        ("selected", ("<b>", "</b>"), "Selected task indicator"),
        (
            "parse_text",
            None,
            "Function to parse and modify window names. "
            "e.g. function in config that removes excess "
            "strings from window name: "
            "def my_func(text)"
            '    for string in [" - Chromium", " - Firefox"]:'
            '        text = text.replace(string, "")'
            "   return text"
            "then set option parse_text=my_func",
        ),
    ]

    def __init__(self, **config):
        base._TextBox.__init__(self, width=bar.CALCULATED, **config)
        self.add_defaults(MyWindowTabs.defaults)
        if not isinstance(self.selected, (tuple, list)):
            self.selected = (self.selected, self.selected)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        hook.subscribe.client_name_updated(self.update)
        hook.subscribe.focus_change(self.update)
        hook.subscribe.float_change(self.update)
        self.add_callbacks({"Button1": self.bar.screen.group.cmd_next_window})

    def update(self):
        names = []
        for w in self.bar.screen.group.windows:
            # state = ""
            # if w.maximized:
            # state = "[] "
            # elif w.minimized:
            # state = "_ "
            # elif w.floating:
            # state = "a "
            task = "" if w and w.name else ""
            if w is self.bar.screen.group.current_window:
                if w.floating:
                    task = " ".join(self.selected)
                elif w.minimized:
                    task = "絛".join(self.selected)
                else:
                    task = task.join(self.selected)
            names.append(task)
        self.text = self.separator.join(names)
        if callable(self.parse_text):
            try:
                self.text = self.parse_text(self.text)
            except:  # noqa: E722
                logger.exception("parse_text function failed:")
        self.bar.draw()


window_tabs = MyWindowTabs(
    **FONT_PARAMS,
    separator=" ",
    foreground=COLS["white_hard_2"],
    selected=("<span foreground='#f92'>", "</span>"),
)
