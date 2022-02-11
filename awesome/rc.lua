--    ___      _____ ___  ___  __  __ _____      ____  __
--   /_\ \    / / __/ __|/ _ \|  \/  | __\ \    / /  \/  |
--  / _ \ \/\/ /| _|\__ \ (_) | |\/| | _| \ \/\/ /| |\/| |
-- /_/ \_\_/\_/ |___|___/\___/|_|  |_|___| \_/\_/ |_|  |_|
--

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

Apps = require("config.basics").Apps

require("startup")
require("theme")
require("layout")
require("config.clients")

local keys = require("config.keys.global")
root.keys(keys.keys)
root.buttons(keys.desktopbuttons)

require("daemons")
require("notifications")
require("components")
-- Reload config when screen geometry change
screen.connect_signal("property::geometry", awesome.restart)

-- Garbage collcetion for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
