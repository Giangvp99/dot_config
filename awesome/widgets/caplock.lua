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
local update_widget = function(widget, status)
	if status == "on" then
		widget.widget.markup = set_foreground(beautiful.capslock_on_fg, beautiful.capslock_icon)
	else
		widget.widget.markup = set_foreground(beautiful.capslock_off_fg, beautiful.capslock_icon)
	end
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		{
			markup = beautiful.widget_loading,
			font = beautiful.capslock_font,
			widget = wibox.widget.textbox,
		},
	})
	awesome.connect_signal("daemon::caplock", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Brightness status unknown"

	return widget
end

return create_widget
