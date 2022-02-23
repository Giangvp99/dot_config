local awful = require("awful")
-- local gears = require("gears")
-- ========================================
-- Config
-- ========================================

-- update interval
-- local update_interval = 3

-- script to get current ibus engine
local caplock_script = "bash -c 'sleep 0.2 && xset q'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_caplock = function()
	awful.spawn.easy_async_with_shell(caplock_script, function(stdout)
		if stdout:match("Caps Lock") then
			local status = stdout:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
			awesome.emit_signal("daemon::caplock", status)
		end
	end)
end
emit_caplock()
-- ========================================
-- Initialization
-- ========================================

-- Check engine periodically
-- gears.timer({
-- 	timeout = update_interval,
-- 	autostart = true,
-- 	call_now = true,
-- 	callback = emit_caplock,
-- })
