-- I am cursor.lua and I should live in ~/.config/wezterm/cursor.lua

-- This is the module table that we will export
local module = {}
-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	config.default_cursor_style = "BlinkingBlock"
	config.cursor_blink_rate = 750
	config.animation_fps = 60
end

return module
