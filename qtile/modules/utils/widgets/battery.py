from enum import Enum, unique
from typing import NamedTuple
from libqtile import widget
from ..colors import COLS
from ...settings import FONT_PARAMS, BACKGROUND


@unique
class BatteryState(Enum):
    CHARGING = 1
    DISCHARGING = 2
    FULL = 3
    EMPTY = 4
    UNKNOWN = 5


BatteryStatus = NamedTuple(
    "BatteryStatus",
    [
        ("state", BatteryState),
        ("percent", float),
        ("power", float),
        ("time", int),
    ],
)


class MyBattery(widget.Battery):
    def build_string(self, status: BatteryStatus) -> str:
        """Determine the string to return for the given battery state

        Parameters
        ----------
        status:
            The current status of the battery

        Returns
        -------
        str
            The string to display for the current status.
        """
        if self.hide_threshold is not None and status.percent > self.hide_threshold:
            return ""

        if self.layout is not None:
            if (
                status.state == BatteryState.DISCHARGING
                and status.percent < self.low_percentage
            ):
                self.layout.colour = self.low_foreground
                self.background = self.low_background
            else:
                self.layout.colour = self.foreground
                self.background = self.normal_background

        hour = status.time // 3600
        minute = (status.time // 60) % 60
        if status.state == BatteryState.CHARGING:
            char = self.charge_char
            return self.format.format(
                char=char,
                percent=" {:.1f}".format(status.percent * 100),
                watt=status.power,
                hour="",
                min="",
            )
        elif status.state == BatteryState.DISCHARGING:
            char = self.discharge_char
            return self.format.format(
                char=char,
                percent="{:.1f }".format(status.percent * 100),
                watt="",
                hour=str(hour) + " ",
                min=minute,
            )
        elif status.state == BatteryState.FULL:
            if self.show_short_text:
                return "Full"
            char = self.full_char
            return self.format.format(
                char=char,
                percent="",
                watt="",
                hour="",
                min="",
            )
        elif status.state == BatteryState.EMPTY or (
            status.state == BatteryState.UNKNOWN and status.percent == 0
        ):
            if self.show_short_text:
                return "Empty"
            char = self.empty_char
            return self.format.format(
                char=char,
                percent="",
                watt="",
                hour="",
                min="",
            )
        else:
            char = self.unknown_char
            return self.format.format(
                char=char,
                percent="",
                watt="",
                hour="",
                min="",
            )


battery2 = MyBattery(
    **FONT_PARAMS,
    format="{char}{percent}{hour}{min}{watt}",
    background=BACKGROUND,
    foreground=COLS["yellow"],
    unknown_char=" ",
    full_char="",
    empty_char="",
    discharge_char="",
    charge_char="",
)
