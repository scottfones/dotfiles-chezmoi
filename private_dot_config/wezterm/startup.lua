-- I am startup.lua and I should live in ~/.config/wezterm/startup.lua

-- This is the module table that we will export
local module = {}
-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	-- Spawn a fish shell in login mode
	config.default_prog = { "/usr/bin/fish", "-l" }
	-- config.default_prog = { "/bin/bash", "-l" }

	config.enable_wayland = true

	-- config.color_scheme = "kanagawabones"
	-- config.color_scheme = "GitHub Dark (Gogh)"
	-- config.color_scheme = "GruvboxDarkHard"
	-- config.color_scheme = "Gruvbox dark, hard (base16)"
	-- config.color_scheme = "Google Dark (base16)"
	-- config.color_scheme = "Gruvbox Material (Gogh)"
end

return module
