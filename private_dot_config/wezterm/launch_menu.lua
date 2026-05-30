-- I am launch_menu.lua and I should live in ~/.config/wezterm/launch_menu.lua

local wezterm = require("wezterm")

local module = {}

local workspaces = {
	{
		label = "omega: coding",
		domain = "omega",
		sessions = { "utility", "editor", "claude" },
	},
	{
		label = "omega: universal",
		domain = "omega",
		sessions = { "universal" },
	},
	{
		label = "pi: universal",
		domain = "pi",
		sessions = { "universal" },
	},
	{
		label = "psi: universal",
		domain = "psi",
		sessions = { "universal" },
	},
	{
		label = "theta: universal",
		domain = "theta",
		sessions = { "universal" },
	},
}

local function workspace_choices()
	local choices = {}
	for i, ws in ipairs(workspaces) do
		table.insert(choices, { label = ws.label, id = tostring(i) })
	end
	return choices
end

local function attach_tmux(pane, session)
	pane:send_text("tmux a -t " .. session .. "\r")
end

local function open_workspace(workspace)
	local _, first_pane, new_window = wezterm.mux.spawn_window({
		domain = { DomainName = workspace.domain },
	})
	-- delay call for connection and init timing
	wezterm.time.call_after(0.5, function()
		attach_tmux(first_pane, workspace.sessions[1])
	end)
	for i = 2, #workspace.sessions do
		local _, new_pane = new_window:spawn_tab({
			domain = { DomainName = workspace.domain },
		})
		attach_tmux(new_pane, workspace.sessions[i])
	end
end

function module.apply_to_config(config)
	config.keys = config.keys or {}
	table.insert(config.keys, {
		key = "O",
		mods = "CTRL|SHIFT",
		action = wezterm.action.InputSelector({
			title = "Open workspace",
			choices = workspace_choices(),
			action = wezterm.action_callback(function(window, pane, id, label)
				if not id then
					return
				end
				open_workspace(workspaces[tonumber(id)])
			end),
		}),
	})
end

return module
