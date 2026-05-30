-- I am fonts.lua and I should live in ~/.config/wezterm/fonts.lua
local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}
-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	config.font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font Propo", weight = "Medium" },
		{ family = "MonaspiceNe Nerd Font Propo", weight = "Medium" },
		{ family = "MonaspiceKr Nerd Font Propo", weight = "Medium" },
		{ family = "MonaspiceAr Nerd Font Propo", weight = "Medium" },
		{ family = "MonaspiceXe Nerd Font Propo", weight = "Medium" },
		{ family = "Hack Nerd Font Propo", weight = "Regular" },
		{ family = "Maple Mono NF CN", weight = "Medium" },
		{ family = "Symbols Nerd Font", weight = "Regular" },
		{ family = "Symbols Nerd Font Mono", weight = "Regular" },
		{ family = "Inconsolata LGC Nerd Font Propo", weight = "Regular" },
	})
	config.font_size = 14.0

	-- Tab bar font configuration
	config.window_frame = {
		font = wezterm.font_with_fallback({
			{ family = "AdwaitaMono Nerd Font Propo", weight = "Regular" },
			{ family = "MonaspiceNe Nerd Font Propo", weight = "Regular" },
			{ family = "Symbols Nerd Font", weight = "Regular" },
			{ family = "Symbols Nerd Font Mono", weight = "Regular" },
			{ family = "Inconsolata LGC Nerd Font Propo", weight = "Regular" },
		}),
		font_size = 14.0,
	}
end

return module
