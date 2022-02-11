from libqtile.widget import base
import psutil

from ..colors import COLS
from ...settings import FONT_PARAMS

# ----------------------------------------------------------------------------------------------
class MyCPU(base.ThreadPoolText):
    defaults = [
        ("update_interval", 2.0, "Update interval for the CPU widget"),
        (
            "format",
            " {load_percent} 龍 {freq_current}GHz",
            "CPU display format",
        ),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(MyCPU.defaults)

    def poll(self):
        variables = dict()

        variables["load_percent"] = "{val:2.1f}".format(val=psutil.cpu_percent())
        freq = psutil.cpu_freq()
        variables["freq_current"] = round(freq.current / 1000, 1)
        variables["freq_max"] = round(freq.max / 1000, 1)
        variables["freq_min"] = round(freq.min / 1000, 1)

        return self.format.format(**variables)


cpu = MyCPU(
    **FONT_PARAMS,
    foreground=COLS["red_hard"],
)
