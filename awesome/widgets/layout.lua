local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, tag)
	local layout_name = tag.layout.name
	local icon_name = ""
	if layout_name == "max" then
		icon_name = icon_name .. beautiful.layout_max
	elseif layout_name == "tile" then
		icon_name = icon_name .. beautiful.layout_tile
	end

	helpers.update_widget(widget).markup = helpers.set_foreground(beautiful.layout_fg, icon_name)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	tag.connect_signal("property::layout", function(t)
		update_widget(widget, t)
	end)

	tag.connect_signal("property::selected", function(t)
		update_widget(widget, t)
	end)

	return widget
end

return create_widget
