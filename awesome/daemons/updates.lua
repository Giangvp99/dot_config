local awful = require("awful")
local gears = require("gears")
-- ========================================
-- Config
-- ========================================

-- update interval
local update_interval = 3600

-- script to get current ibus engine
local updates_script = "yay -Qu | wc -l| awk '{print}'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_updates = function()
	awful.spawn.easy_async_with_shell(updates_script, function(stdout)
		awesome.emit_signal("daemon::updates", stdout)
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
	callback = emit_updates,
})
