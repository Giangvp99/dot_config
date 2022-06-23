--
-- language.lua
-- language widget
--

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("config.keys.map")

-- ========================================
-- Config
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
	helpers.update_widget(widget).markup = helpers.set_foreground(beautiful.language_fg, beautiful.language_icon .. language)

end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::language", function(...)
		update_language(widget, ...)
	end)

	local container = require("widgets.clickable_container")(widget)
	container:buttons(buttons(screen))

	return container
end

return create_widget
