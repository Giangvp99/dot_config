from libqtile import widget
from ..colors import COLS
from ...settings import FONT_PARAMS

# ----------------------------------------------------------------------------------------------
class MyBacklight(widget.Backlight):
    def poll(self):
        try:
            percent = super()._get_info()
        except RuntimeError as e:
            return "Error: {}".format(e)

        return self.format.format(percent=percent * 100)


backlight = MyBacklight(
    **FONT_PARAMS,
    foreground=COLS["orange"],
    backlight_name="amdgpu_bl0",
    format="{percent:2.0f}",
    fmt=" {}",
)
