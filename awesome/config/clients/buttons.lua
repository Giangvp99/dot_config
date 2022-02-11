local awful = require("awful")
local modkey = require("config.keys.map").modkey

local leftclick = 1
local rightclick = 3

-- Mouse buttons on client
local clientbuttons = awful.util.table.join(
	awful.button({}, leftclick, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, leftclick, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, rightclick, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

return clientbuttons
