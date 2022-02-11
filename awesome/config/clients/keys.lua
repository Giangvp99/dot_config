local awful = require("awful")
local beautiful = require("beautiful")
local mapkeys = require("config.keys.map")
-- require("awful.autofocus")
local dpi = beautiful.xresources.apply_dpi

local modkey = mapkeys.modkey
local ctrlkey = mapkeys.ctrlkey
local shiftkey = mapkeys.shiftkey
-- local altkey = mapkeys.altkey
--
-- ========================================
-- Movement functions
-- ========================================

-- Move local client
local function move_client(c, direction)
	-- If client is floating, move to edge
	if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
		if direction == "up" then
			c:relative_move(0, -10, 0, 0)
		elseif direction == "down" then
			c:relative_move(0, 10, 0, 0)
		elseif direction == "left" then
			c:relative_move(-10, 0, 0, 0)
		elseif direction == "right" then
			c:relative_move(10, 0, 0, 0)
		end

		-- If maxed layout then swap windows
	elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
		-- Otherwise swap the client in the tiled layout
	else
		awful.client.swap.bydirection(direction, c, nil)
	end
end

-- Resize local client
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
		if direction == "up" then
			c:relative_move(0, 0, 0, -floating_resize_amount)
		elseif direction == "down" then
			c:relative_move(0, 0, 0, floating_resize_amount)
		elseif direction == "left" then
			c:relative_move(0, 0, -floating_resize_amount, 0)
		elseif direction == "right" then
			c:relative_move(0, 0, floating_resize_amount, 0)
		end
	else
		if direction == "up" then
			awful.client.incwfact(-tiling_resize_factor)
		elseif direction == "down" then
			awful.client.incwfact(tiling_resize_factor)
		elseif direction == "left" then
			awful.tag.incmwfact(-tiling_resize_factor)
		elseif direction == "right" then
			awful.tag.incmwfact(tiling_resize_factor)
		end
	end
end

-- Raise focus client
local function raise_client()
	if client.focus then
		client.focus:raise()
	end
end

local clientkeys = awful.util.table.join(
	-- ========================================
	-- Client Keybindings
	-- ========================================
	awful.key({ modkey, shiftkey }, "j", function(c)
		move_client(c, "down")
	end, { description = "move down", group = "client" }),

	awful.key({ modkey, shiftkey }, "k", function(c)
		move_client(c, "up")
	end, { description = "move up", group = "client" }),

	awful.key({ modkey, shiftkey }, "h", function(c)
		move_client(c, "left")
	end, { description = "move left", group = "client" }),

	awful.key({ modkey, shiftkey }, "l", function(c)
		move_client(c, "right")
	end, { description = "move right", group = "client" }),

	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),

	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	awful.key({ modkey, shiftkey }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	awful.key(
		{ modkey, ctrlkey },
		"f",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey }, "j", function()
		if awful.layout.get(mouse.screen) == awful.layout.suit.max then
			awful.client.focus.history.previous()
		else
			awful.client.focus.bydirection("down")
		end

		raise_client()
	end, { description = "focus down", group = "client" }),

	awful.key({ modkey }, "k", function()
		awful.client.focus.bydirection("up")
		raise_client()
	end, { description = "focus up", group = "client" }),

	awful.key({ modkey }, "h", function()
		awful.client.focus.bydirection("left")
		raise_client()
	end, { description = "focus left", group = "client" }),

	awful.key({ modkey }, "l", function()
		awful.client.focus.bydirection("right")
		raise_client()
	end, { description = "focus right", group = "client" }),

	-- ========================================
	-- Client resize
	-- ========================================
	awful.key({ modkey, ctrlkey }, "j", function()
		resize_client(client.focus, "down")
	end, { description = "resize down", group = "client" }),

	awful.key({ modkey, ctrlkey }, "k", function()
		resize_client(client.focus, "up")
	end, { description = "resize up", group = "client" }),

	awful.key({ modkey, ctrlkey }, "h", function()
		resize_client(client.focus, "left")
	end, { description = "resize left", group = "client" }),

	awful.key({ modkey, ctrlkey }, "l", function()
		resize_client(client.focus, "right")
	end, { description = "resize right", group = "client" })
)
return clientkeys
