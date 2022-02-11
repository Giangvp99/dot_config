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
local update_widget = function(widget, updates)
	updates = updates:match("%d+")
	widget.widget.markup = "<span foreground='" .. beautiful.color.lightyellow .. "'> " .. updates .. "</span>"
	-- widget.tooltip.text = updates .. " updates avaiable!"
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
	awesome.connect_signal("daemon::updates", function(...)
		update_widget(widget, ...)
	end)

	-- local container = require("widgets.clickable_container")(widget)

	-- widget.tooltip = require("widgets.tooltip")({ container })

	return widget
end

return create_widget
