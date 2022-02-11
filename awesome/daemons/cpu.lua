local awful = require("awful")
local gears = require("gears")
-- ========================================
-- Config
-- ========================================

-- update interval
local update_interval = 2

-- script to get current ibus engine
local cpu_script = "python ~/.config/scripts/cpu.py | awk '{print}'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_cpu = function()
	awful.spawn.easy_async_with_shell(cpu_script, function(stdout)
		awesome.emit_signal("daemon::cpu", stdout)
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
	callback = emit_cpu,
})
