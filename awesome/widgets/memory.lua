local beautiful = require("beautiful")
local helpers = require("helpers")
-- ========================================
-- Config
-- ========================================

-- update widget
local update_widget = function(widget, used, total)
	used = tonumber(used) / 1024
	total = tonumber(total) / 1024
	helpers.update_widget(widget).markup = helpers.set_foreground(
		beautiful.memory_fg,
		string.format(beautiful.memory_icon .. "%02.0f", used / total * 100)
	)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()
	awesome.connect_signal("daemon::memory", function(...)
		update_widget(widget, ...)
	end)
	return widget
end

return create_widget
