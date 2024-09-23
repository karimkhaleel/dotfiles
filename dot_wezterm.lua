-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font("FiraMono Nerd Font", { weight = "Medium" })

config.font_size = 12
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

act = wezterm.action

config.keys = {
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "b",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "a",
		mods = "LEADER",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
	},
	-- Sesh
	{
		key = "k",
		mods = "CTRL",
		action = act.Multiple({
			act.SendKey({ key = "a", mods = "CTRL" }),
			act.SendKey({ key = "t", mods = "SHIFT" }),
		}),
	},
	-- Nav
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
	{
		key = "RightArrow",
		mods = "SUPER",
		action = act.SendKey({ key = "End" }),
	},
	{
		key = "LeftArrow",
		mods = "SUPER",
		action = act.SendKey({ key = "Home" }),
	},
}

-- and finally, return the configuration to wezterm
return config
