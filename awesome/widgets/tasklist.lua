--
-- tasklist.lua
-- tasklist component
--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("theme.color")
local naughty = require("naughty")
-- Old tasklist
-- get minimized clients
-- local get_minimized_clients = function(screen)
-- 	local clients = {}
--
-- 	for _, c in ipairs(screen.hidden_clients) do
-- 		if
-- 			not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type == "dock" or c.type == "desktop")
-- 			and c.minimized
-- 			and awful.widget.tasklist.filter.currenttags(c, awful.screen.focused())
-- 		then
-- 			table.insert(clients, c)
-- 		end
-- 	end
--
-- 	return #clients
-- end
-- get hidden/visible client counts
-- local get_clients_status = function(screen)
-- 	local visible_clients = #screen.clients
-- 	local hidden_clients = get_minimized_clients(screen)
--
-- 	return string.format(
-- 		"<span foreground='" .. color.darkblue .. "'>%s%s</span> <span foreground='" .. color.black2 .. "'>%s%s</span>",
-- 		beautiful.tasklist_icon_visible,
-- 		visible_clients,
-- 		beautiful.tasklist_icon_hidden,
-- 		hidden_clients
-- 	)
-- end
-- New tasklist
local compare = function(a, b)
	return a.window < b.window
end
local get_clients_status = function(screen)
	local res = ""
	local visible_client = "<span foreground='" .. color.black2 .. "'> </span>"
	local current_client = "<span foreground='" .. color.lightorange .. "'> </span>"
	local minimized_client = "<span foreground='" .. color.black1 .. "'> </span>"
	local floating_client = "<span foreground='" .. color.lightorange .. "'> </span>"
	local current_c = client.focus or { window = -1 }
	local clients = {}
	for _, c in ipairs(screen.clients) do
		table.insert(clients, c)
	end

	for _, c in ipairs(screen.hidden_clients) do
		if
			not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type == "dock" or c.type == "desktop")
			and c.minimized
			and awful.widget.tasklist.filter.currenttags(c, awful.screen.focused())
		then
			table.insert(clients, c)
		end
	end

	table.sort(clients, compare)
	for _, c in ipairs(clients) do
		if c.floating == true then
			res = res .. floating_client
		elseif c.minimized == true then
			res = res .. minimized_client
		elseif c.window == current_c.window then
			res = res .. current_client
		else
			res = res .. visible_client
		end
	end
	return res
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
			font = beautiful.basic_font .. 9,
			widget = wibox.widget.textbox,
		},
	})

	client.connect_signal("unmanage", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("manage", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("focus", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("swapped", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("property::minimized", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("property::floating", function()
		update_widget(widget, screen)
	end)
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_widget(widget, screen)
	end)

	return widget
end

return create_widget
