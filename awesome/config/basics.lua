return {
	-- define default apps
	Apps = {
		terminal = "alacritty",
		launcher = "rofi -show drun",
		web_browser = "brave",
		volume_manager = "pavucontrol",
		network_manager = "nm-connection-editor",
		power_manager = "xfce4-power-manager",
		bluetooth_manager = "blueman-manager",
		screenshot = "maim",
		filebrowser = "thunar",
	},

	-- network interfaces
	Network_Interfaces = {
		wlan = "wlp1s0",
		lan = "enp42s0",
	},

	-- language mappings
	Languages = {
		{ lang = "en", engine = "xkb:au::eng" },
		{ lang = "ru", engine = "xkb:ru::rus" },
		{ lang = "vn", engine = "Bamboo::Us" },
	},
}
