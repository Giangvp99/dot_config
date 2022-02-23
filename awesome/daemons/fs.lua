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
local update_interval = 3600

-- script to get current ibus engine
local home_fs_script = "df -h /home/giangvp99/ | grep '^/' | awk '{print $3,$2}'"
local root_fs_script = "df -h / | grep '^/' | awk '{print $3,$2}'"

-- ========================================
-- Logic
-- ========================================

-- Main script
local emit_home_fs = function()
	awful.spawn.easy_async_with_shell(home_fs_script, function(home_stdout)
		awful.spawn.easy_async_with_shell(root_fs_script, function(root_stdout)
			awesome.emit_signal("daemon::fs", home_stdout, root_stdout)
		end)
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
	callback = emit_home_fs,
})
