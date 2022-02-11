--
-- brightness.lua
-- brightness widget
--
local wibox = require("wibox")
local beautiful = require("beautiful")
local set_foreground = require("helpers").set_foreground
-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- update widget
local update_widget = function(widget, stdout)
	local recv, r, sent, s = string.match(stdout, "(%d+)(%a)%s(%d+)(%a).?")
	widget.widget.markup = set_foreground(
		beautiful.color.darkyellow,
		"龍 " .. string.format("%3d", recv) .. r .. " " .. string.format("%3d", sent) .. s
	)
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		{
			markup = "勒",
			widget = wibox.widget.textbox,
		},
	})
	awesome.connect_signal("daemon::speednet", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Brightness status unknown"

	return widget
end

return create_widget
