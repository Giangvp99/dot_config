local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

awful.screen.connect_for_each_screen(function(s)
    s.leftbar = wibox({
        screen = s,
        visible = true,
        x = s.geometry.x + beautiful.topbar_margin * 2,
        y = s.geometry.y + beautiful.topbar_margin * 2,
        width = beautiful.leftbar_width,
        height = s.geometry.height,
        shape = helpers.rrect,
    })
    s.leftbar:struts({
        left = beautiful.leftbar_width,
    })
    s.leftbar:setup({
        widget = wibox.container.margin,
        top = beautiful.topbar_padding_x,
        bottom = beautiful.topbar_padding_x,
        {
            layout = wibox.layout.align.vertical,
            expand = "none",

            -- Left/Top widgets
            {
                layout = wibox.layout.fixed.vertical,
                -- require("widgets.taglist")(s),
                -- require("widgets.fs")(s),
                -- require("widgets.network")(s),
                -- require("widgets.speednet")(s),
            },

            -- Middle widgets
            {
                layout = wibox.layout.fixed.vertical,
                -- require("widgets.calendar")(s),
            },

            -- Right/Bottom widgets
            {
                layout = wibox.layout.fixed.vertical,
                -- require("widgets.systray")(s),
                -- require("widgets.tasklist")(s),
                require("widgets.updates")(s),
                require("widgets.memory")(s),
                require("widgets.cpu")(s),
                -- require("widgets.volume")(s),
                -- require("widgets.caplock")(s),
                -- require("widgets.language")(s),
                -- require("widgets.brightness")(s),
                -- require("widgets.battery")(s),
                -- require("widgets.layout")(s),
            },
        },
    })
end)
