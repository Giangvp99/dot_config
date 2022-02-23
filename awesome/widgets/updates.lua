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
local update_widget = function(widget, updates)
	updates = updates:match("%d+")
	if updates == "0" then
		widget.widget.markup = helpers.set_foreground(beautiful.updates_none_fg, beautiful.updates_none)
	else
		widget.widget.markup = helpers.set_foreground(beautiful.updates_normal_fg, beautiful.updates_normal .. updates)
	end
	-- widget.tooltip.text = updates .. " updates avaiable!"
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
	awesome.connect_signal("daemon::updates", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })

	return widget
end

return create_widget
