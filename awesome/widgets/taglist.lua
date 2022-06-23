local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- determine icon to show for each tag
local update_tag_icon = function(widget, tag)
	local icon = nil
	if #tag:clients() > 0 then
		if tag.selected then
			icon = helpers.set_foreground(beautiful.taglist_fg_focus, beautiful.taglist_focus)
		elseif tag.urgent then
			icon = helpers.set_foreground(beautiful.taglist_fg_urgent, beautiful.taglist_hidden)
		else
			icon = helpers.set_foreground(beautiful.taglist_fg_occupied, beautiful.taglist_hidden)
		end
	else --empty
		if tag.selected then
			icon = helpers.set_foreground(beautiful.taglist_fg_focus, beautiful.taglist_focus)
		elseif tag.urgent then
			icon = helpers.set_foreground(beautiful.taglist_fg_urgent, beautiful.taglist_empty)
		else
			icon = helpers.set_foreground(beautiful.taglist_fg_empty, beautiful.taglist_empty)
		end
	end

	widget.markup = icon
end

-- create taglist widget instance
local create_widget = function(screen)
	return wibox.widget({
		widget = wibox.container.margin,
		left = beautiful.clickable_container_padding_x,
		right = beautiful.clickable_container_padding_x,
		awful.widget.taglist({
			screen = screen,
			filter = awful.widget.taglist.filter.all,
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.taglist_spacing,
			font = beautiful.taglist_font,
			widget_template = {
				widget = wibox.widget.textbox,
				valign = "center",
				align = "center",
				create_callback = update_tag_icon,
				update_callback = update_tag_icon,
			},
		}),
	})
end

return create_widget
