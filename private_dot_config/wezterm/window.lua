-- I am window.lua and I should live in ~/.config/wezterm/window.lua

local module = {}

function module.apply_to_config(config)
	config.window_background_opacity = 0.75
	config.window_decorations = "NONE"

	config.initial_rows = 80
	config.initial_cols = 300
end

return module
