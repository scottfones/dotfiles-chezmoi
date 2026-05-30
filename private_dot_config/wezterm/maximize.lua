-- maximize.lua
local wezterm = require("wezterm")

local module = {}
function module.apply_to_config(config)
	local seen = {}
	wezterm.on("window-focus-changed", function(window, pane)
		local wid = window:window_id()
		if not seen[wid] then
			seen[wid] = true
			window:maximize()
		end
	end)
end

return module
