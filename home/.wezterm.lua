-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_scroll_bar = true

config.font = wezterm.font({
	family = "jetbrains mono light",
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "jetbrains mono light",
		}),
	},
}

config.hide_tab_bar_if_only_one_tab = true
-- config.font = wezterm.font("MonoLisa")
config.font_size = 12.0
-- config.color_scheme = "AdventureTime"
-- and finally, return the configuration to wezterm
return config
