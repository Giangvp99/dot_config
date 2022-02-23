--
-- brightness.lua
-- brightness widget
--
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- update widget
local update_widget = function(widget, used, total)
	used = tonumber(used) / 1024
	total = tonumber(total) / 1024
	widget.widget.markup = helpers.set_foreground(
		beautiful.memory_fg,
		string.format(beautiful.memory_icon .. "%02.0f", used / total * 100)
	)
	-- widget.tooltip.text = used .. total
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		{
			markup = beautiful.widget_loading,
			widget = wibox.widget.textbox,
		},
	})
	awesome.connect_signal("daemon::memory", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Brightness status unknown"

	return widget
end

return create_widget
