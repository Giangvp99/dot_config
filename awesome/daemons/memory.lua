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
local update_interval = 2

-- script to get current ibus engine
local mem_script = "free -m | grep 'Mem' | awk '{print $2,$3}'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_memory = function()
	awful.spawn.easy_async_with_shell(mem_script, function(stdout)
		local total = stdout:match("%d+")
		local used = stdout:match("[ ]%d+")
		awesome.emit_signal("daemon::memory", used, total)
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
	callback = emit_memory,
})
