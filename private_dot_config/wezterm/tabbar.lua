-- I am tabbar.lua and I should live in ~/.config/wezterm/tabbar.lua

local module = {}

function module.apply_to_config(config)
	-- reset window decorations because of tabline override
	config.window_decorations = "NONE"
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 999

	config.colors = {
		tab_bar = {
			-- The active tab is the one that has focus in the window
			active_tab = {
				bg_color = "#333333",
				fg_color = "#FBF1C7",
				intensity = "Bold",

				underline = "None",
				italic = false,
				strikethrough = false,
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = "#333333",
				fg_color = "#458588",
				intensity = "Half",
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = "#333333",
				fg_color = "#FBF1C7",
				intensity = "Bold",
				italic = true,
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = "#1b1032",
				fg_color = "#808080",

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#909090",
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	}
end

return module
