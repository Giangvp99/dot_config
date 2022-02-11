--
-- tasklist.lua
-- tasklist component
--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("theme.color")
-- get minimized clients
local get_minimized_clients = function(screen)
	local clients = {}

	for _, c in ipairs(screen.hidden_clients) do
		if
			not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type == "dock" or c.type == "desktop")
			and c.minimized
			and awful.widget.tasklist.filter.currenttags(c, awful.screen.focused())
		then
			table.insert(clients, c)
		end
	end

	return #clients
end
-- get hidden/visible client counts
local get_clients_status = function(screen)
	local visible_clients = #screen.clients
	local hidden_clients = get_minimized_clients(screen)

	return string.format(
		"<span foreground='" .. color.darkblue .. "'>%s%s</span> <span foreground='" .. color.black2 .. "'>%s%s</span>",
		beautiful.tasklist_icon_visible,
		visible_clients,
		beautiful.tasklist_icon_hidden,
		hidden_clients
	)
end

-- update widget info
local update_widget = function(widget, screen)
	widget.widget.markup = get_clients_status(screen)
end

-- create taglist widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		{
			valign = "center",
			align = "center",
			markup = "勒",
			widget = wibox.widget.textbox,
		},
	})

	client.connect_signal("unmanage", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("manage", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("untagged", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("property::minimized", function()
		update_widget(widget, screen)
	end)
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_widget(widget, screen)
	end)

	return widget
end

return create_widget
