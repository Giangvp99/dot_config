--
-- language.lua
-- language widget
--

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("config.keys.map")

-- ========================================
-- Config
-- ========================================

-- ========================================
-- Definition
-- ========================================

-- define buttons
local buttons = function(screen)
	return gears.table.join(
		awful.button({}, keys.leftclick, helpers.switch_language),
		awful.button({}, keys.rightclick, function()
			awful.spawn("ibus-setup")
		end)
	)
end

-- update language
local update_language = function(widget, language)
	widget.markup = "<span foreground='" .. beautiful.color.lightpurple .. "'> " .. language .. "</span>"

	-- widget.tooltip.text = language == "unknown" and "Keyboard layout unknown"
	-- or "Keyboard layout is set to " .. language
end

-- create widget instance
local create_widget = function(screen)
	local widget = wibox.widget({
		markup = "",
		widget = wibox.widget.textbox,
	})
	awesome.connect_signal("daemon::language", function(...)
		update_language(widget, ...)
	end)

	local container = require("widgets.clickable_container")(widget)
	container:buttons(buttons(screen))

	-- widget.tooltip = require("widgets.tooltip")({ container })
	-- widget.tooltip.text = "Keyboard layout unknown"

	return container
end

return create_widget
