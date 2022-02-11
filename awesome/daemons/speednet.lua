-- Signals:
-- daemon::fs
--   fs (string)
--

local awful = require("awful")
local gears = require("gears")
-- ========================================
-- Config
-- ========================================

-- update interval
local update_interval = 3

-- script to get current ibus engine
local speed_script = "python ~/.config/scripts/data.py | awk '{print}'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_speednet = function()
	awful.spawn.easy_async_with_shell(speed_script, function(stdout)
		awesome.emit_signal("daemon::speednet", stdout)
	end)
end

-- ========================================
-- Initialization
-- ========================================

-- Check engine periodically
gears.timer({
	timeout = update_interval,
	autostart = true,
	call_now = true,
	callback = emit_speednet,
})
