--
-- brightness.lua
-- brightness widget
--
local wibox = require("wibox")
local beautiful = require("beautiful")
-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- update widget
local update_widget = function(widget, home_fs, root_fs)
	home_fs = home_fs:gsub("\n[^\n]*$", " ")
	root_fs = root_fs:gsub("\n[^\n]*$", " ")
	widget.widget.markup = "<span foreground='"
		.. beautiful.color.lightgreen
		.. "'> "
		.. home_fs
		.. "</span><span foreground='"
		.. beautiful.color.darkgreen
		.. "'> "
		.. root_fs
		.. "</span>"
	-- widget.tooltip.text = home_fs .. root_fs
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
	awesome.connect_signal("daemon::fs", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Brightness status unknown"

	return widget
end

return create_widget
