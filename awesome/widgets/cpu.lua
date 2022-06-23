local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, stdout)
	local cpu = string.match(stdout, "(%d+).?")
	helpers.update_widget(widget).markup = helpers.set_foreground(
		beautiful.cpu_fg,
		beautiful.cpu_icon .. string.format("%02.0f", cpu)
	)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::cpu", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
