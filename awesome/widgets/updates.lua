local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, updates)
	updates = updates:match("%d+")
	if updates == "0" then
		helpers.update_widget(widget).markup = helpers.set_foreground(
			beautiful.updates_none_fg,
			beautiful.updates_none
		)
	else
		helpers.update_widget(widget).markup = helpers.set_foreground(
			beautiful.updates_normal_fg,
			beautiful.updates_normal .. updates
		)
	end
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::updates", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
