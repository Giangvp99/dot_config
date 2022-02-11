--
-- taglist.lua
-- taglist component
--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("theme.color")

-- determine icon to show for each tag
local update_tag_icon = function(widget, tag)
	local icon = nil
	if #tag:clients() > 0 then
		if tag.selected then
			icon = "<span foreground='" .. color.lightaqua .. "'> </span>"
		elseif tag.urgent then
			icon = "<span foreground='" .. color.lightred .. "'> </span>"
		else
			icon = "<span foreground='" .. color.white2 .. "'> </span>"
		end
	else --empty
		if tag.selected then
			icon = "<span foreground='" .. color.lightaqua .. "'> </span>"
		elseif tag.urgent then
			icon = "<span foreground='" .. color.lightred .. "'> </span>"
		else
			icon = "<span foreground='" .. color.black2 .. "'> </span>"
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
		top = beautiful.clickable_container_padding_y,
		bottom = beautiful.clickable_container_padding_y,
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
