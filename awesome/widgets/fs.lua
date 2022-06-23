local beautiful = require("beautiful")
local helpers = require("helpers")

-- update widget
local update_widget = function(widget, home_fs, root_fs)
	home_fs = home_fs:gsub("\n[^\n]*$", " ")
	root_fs = root_fs:gsub("\n[^\n]*$", " ")
	helpers.update_widget(widget).markup = helpers.set_foreground(beautiful.fs_home_fg, beautiful.fs_home .. home_fs)
		.. helpers.set_foreground(beautiful.fs_root_fg, beautiful.fs_root .. root_fs)
end

-- create widget instance
local create_widget = function(screen)
	local widget = helpers.create_widget()

	awesome.connect_signal("daemon::fs", function(...)
		update_widget(widget, ...)
	end)

	return widget
end

return create_widget
