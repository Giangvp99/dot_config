local beautiful = require("beautiful")
local set_foreground = require("helpers").set_foreground
local create_widget = require("helpers").create_widget
local update_widget = require("helpers").update_widget

-- update widget
local update_widget = function(widget, status)
	if status == "on" then
		update_widget(widget).markup = set_foreground(beautiful.capslock_on_fg, beautiful.capslock_icon)
	else
		update_widget(widget).markup = set_foreground(beautiful.capslock_off_fg, beautiful.capslock_icon)
	end
end

-- create widget instance
local create_widget = function(screen)
	local widget = create_widget()

	awesome.connect_signal("daemon::caplock", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
