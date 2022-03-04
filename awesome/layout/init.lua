local awful = require("awful")
local helpers = require("helpers")

-- layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	-- awful.layout.suit.floating,
	awful.layout.suit.max,
}

-- tag configs
Tags = {
	{ name = "main", layout = awful.layout.layouts[1] },
	{ name = "web", layout = awful.layout.layouts[1] },
	{ name = "code", layout = awful.layout.layouts[2] },
	{ name = "media", layout = awful.layout.layouts[1] },
	-- { name = "chat", layout = awful.layout.layouts[1] },
}

-- ========================================
-- Tags
-- ========================================

local tag_names = {}
local tag_layouts = {}

for i, tag in ipairs(Tags) do
	tag_names[i] = tag.name
	tag_layouts[i] = tag.layout
end

-- Each screen has its own tag table.
awful.screen.connect_for_each_screen(function(s)
	awful.tag(tag_names, s, tag_layouts)
end)

-- Remove gaps if layout is set to max
tag.connect_signal("property::layout", function(t)
	helpers.set_gaps(t.screen, t)
end)
-- Layout might change in different tag
-- so update again when switched to another tag
tag.connect_signal("property::selected", function(t)
	helpers.set_gaps(t.screen, t)
end)
