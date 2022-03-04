---@diagnostic disable: undefined-global
--
-- tasklist.lua
-- tasklist component
--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local normal_client = helpers.set_foreground(beautiful.tasklist_fg_normal, beautiful.tasklist_normal)
local focus_client = helpers.set_foreground(beautiful.tasklist_fg_focus, beautiful.tasklist_normal)
local minimized_client = helpers.set_foreground(beautiful.tasklist_fg_minimized, beautiful.tasklist_normal)
local floating_client = helpers.set_foreground(beautiful.tasklist_fg_floating, beautiful.tasklist_floating)
local ontop_client = helpers.set_foreground(beautiful.tasklist_fg_floating, beautiful.tasklist_ontop)
local maximized_client = helpers.set_foreground(beautiful.tasklist_fg_floating, beautiful.tasklist_maximized)
local compare = function(a, b)
	return a.window < b.window
end
local get_clients_status = function(screen)
	local res = ""

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
		elseif c.ontop == true then
			res = res .. ontop_client
		elseif c.minimized == true then
			res = res .. minimized_client
		elseif c.maximized == true then
			res = res .. maximized_client
		elseif c.window == current_c.window then
			res = res .. focus_client
		else
			res = res .. normal_client
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
			-- valign = "center",
			-- align = "center",
			markup = beautiful.widget_loading,
			font = beautiful.tasklist_font,
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
	client.connect_signal("property::maximized", function()
		update_widget(widget, screen)
	end)
	client.connect_signal("property::ontop", function()
		update_widget(widget, screen)
	end)
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_widget(widget, screen)
	end)

	return widget
end

return create_widget
