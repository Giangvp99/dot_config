local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, stdout)
	local recv, r, sent, s = string.match(stdout, "(%d+)(%a)%s(%d+)(%a).?")
	helpers.update_widget(widget).markup = helpers.set_foreground(
		beautiful.speednet_fg,
		beautiful.speednet_icon .. string.format("%3d", recv) .. r .. " " .. string.format("%3d", sent) .. s
	)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::speednet", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
