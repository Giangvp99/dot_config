from .utils.colors import COLS

ALT = "mod1"
MOD = "mod4"
FONT = "FiraCode Nerd Font"
FONTSIZEBAR = 14
BACKGROUND = COLS["bg"]
FONT_PARAMS = {
    "font": FONT,
    "fontsize": FONTSIZEBAR,
}
# -------------------------------------------------------------
TERMINAL = "alacritty"
BROWSER = "firefox"
ROFI = "rofi -show combi"
# -------------------------------------------------------------
RAISEVOLUME = "amixer -q sset Master 5%+"
LOWERVOLUME = "amixer -q sset Master 5%-"
MUTEVOLUME = "amixer -D pulse sset Master toggle -q"
BRIGHTNESSUP = "light -A 5"
BRIGHTNESSDOWN = "light -U 5"
# -------------------------------------------------------------
LEFTMOUSE = "Button1"
CENTERMOUSE = "Button2"
RIGHTMOUSE = "Button3"
