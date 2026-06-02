-- I am tabbar.lua and I should live in ~/.config/wezterm/tabbar.lua
local wezterm = require("wezterm")
local tab_label = require("tab_label")

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

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local pane = tab.active_pane
		local seg = tab_label.segments(tab.tab_index + 1, pane.domain_name, wezterm.hostname(), pane.title)

		-- Identifier prefix: "[i] [HOST session] " (session bracket omitted when nil)
		local ident
		if seg.session then
			ident = string.format("[%s] [%s %s] ", seg.index, seg.host, seg.session)
		else
			ident = string.format("[%s] [%s] ", seg.index, seg.host)
		end

		-- Slot width (unchanged from prior logic)
		local mux_tab = wezterm.mux.get_tab(tab.tab_id)
		local cols = mux_tab and mux_tab:get_size().cols or (max_width * #tabs)
		local base_slot = cols // #tabs
		local remainder = cols - base_slot * #tabs
		local slot = base_slot
		if tab.tab_index < remainder then
			slot = base_slot + 1
		end

		-- Protect the identifier; truncate only the content to the remaining width.
		local ident_w = wezterm.column_width(ident)
		local avail = slot - ident_w
		if avail < 0 then
			avail = 0
		end
		local content = wezterm.truncate_right(seg.content, avail)

		-- Center the whole line within the slot.
		local line_w = ident_w + wezterm.column_width(content)
		local pad_left = (slot - line_w) // 2
		if pad_left < 0 then
			pad_left = 0
		end
		local pad_right = slot - line_w - pad_left
		if pad_right < 0 then
			pad_right = 0
		end

		-- Emphasis: identifiers recede, content leads; layered on active/inactive color.
		local content_color = tab.is_active and "#FBF1C7" or "#458588"
		local ident_color = tab.is_active and "#bdae93" or "#458588"
		local content_intensity = tab.is_active and "Bold" or "Normal"
		local ident_intensity = tab.is_active and "Normal" or "Half"
		if hover and not tab.is_active then
			content_color = "#FBF1C7"
			ident_color = "#bdae93"
		end

		return {
			{ Background = { Color = "#333333" } },
			{ Text = string.rep(" ", pad_left) },
			{ Foreground = { Color = ident_color } },
			{ Attribute = { Intensity = ident_intensity } },
			{ Text = ident },
			{ Foreground = { Color = content_color } },
			{ Attribute = { Intensity = content_intensity } },
			{ Text = content },
			"ResetAttributes",
			{ Background = { Color = "#333333" } },
			{ Text = string.rep(" ", pad_right) },
		}
	end)
end

return module
