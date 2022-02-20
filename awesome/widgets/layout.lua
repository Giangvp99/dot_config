--
-- layout.lua
-- display currently active layout
--

local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, tag)
	local layout_name = tag.layout.name
	local icon_name = ""
	if layout_name == "max" then
		icon_name = icon_name .. " "
	elseif layout_name == "tile" then
		icon_name = icon_name .. " "
	end

	widget.widget.markup = helpers.set_foreground(beautiful.color.white, icon_name)
	-- widget.tooltip.text = layout.name
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		top = beautiful.clickable_container_padding_y,
		bottom = beautiful.clickable_container_padding_y,
		{
			markup = "勒",
			widget = wibox.widget.textbox,
			font = beautiful.basic_font .. " 14",
			resize = true,
		},
	})

	tag.connect_signal("property::layout", function(t)
		update_widget(widget, t)
	end)
	tag.connect_signal("property::selected", function(t)
		update_widget(widget, t)
	end)

	return widget
end

return create_widget
