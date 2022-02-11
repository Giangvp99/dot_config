local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end

	-- Set rounded corners for windows
	c.shape = helpers.rrect
end)

-- Set border color of focused client
client.connect_signal("focus", function(c)
	if c.class ~= "kitty" and c.class ~= "Alacritty" then
		c.border_color = beautiful.border_focus
	else
		c.border_color = beautiful.border_normal
	end
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- Focus clients under mouse
require("awful.autofocus")
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- client.connect_signal("property::maximized", function(c)
-- c.border_width = c.maximized and 0 or beautiful.border_width
-- end)
