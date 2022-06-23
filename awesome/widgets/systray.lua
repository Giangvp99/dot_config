local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local keys = require("config.keys.map")

-- icons path
local icons_path = beautiful.icons_path .. "systray/"

-- update widget
local update_widget = function(widget)
	widget.systray.visible = widget.show_systray
end

-- toggle systray visibility
local toggle_systray = function(widget)
	widget.show_systray = not widget.show_systray
	update_widget(widget)
end

-- define buttons
local buttons = function(screen, widget)
	return gears.table.join(awful.button({}, keys.leftclick, function()
		toggle_systray(widget)
	end))
end

-- create widget instance
local create_widget = function(screen)
	local button = wibox.widget({
		image = icons_path .. "systray_show.svg",
		widget = wibox.widget.imagebox,
	})

	local systray = wibox.widget({
		widget = wibox.container.margin,
		top = beautiful.clickable_container_padding_y,
		bottom = beautiful.clickable_container_padding_y,
		right = beautiful.clickable_container_padding_x,
		wibox.widget.systray(),
	})

	-- local button_container = require("widgets.clickable_container")(button)

	local wrapper = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		systray = systray,
		show_systray = false,
		systray,
	})

	-- button_container:buttons(buttons(screen, wrapper))

	systray.visible = false

	awesome.connect_signal("widget::systray::toggle", function()
		toggle_systray(wrapper)
	end)

	return wrapper
end

return create_widget
