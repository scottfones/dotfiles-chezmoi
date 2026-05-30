-- I am keymaps.lua and I should live in ~/.config/wezterm/keymaps.lua
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
	config.keys = {
		{
			key = "<",
			mods = "CTRL|SHIFT",
			action = wezterm.action.MoveTabRelative(-1),
		},
		{
			key = ">",
			mods = "CTRL|SHIFT",
			action = wezterm.action.MoveTabRelative(1),
		},
		{
			key = "LeftArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "RightArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateTabRelative(1),
		},
		-- Line return for claude
		{
			key = "Enter",
			mods = "SHIFT",
			action = wezterm.action({ SendString = "\x1b\r" }),
		},
	}
end

return module
