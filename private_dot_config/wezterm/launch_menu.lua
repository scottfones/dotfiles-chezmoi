-- I am launch_menu.lua and I should live in ~/.config/wezterm/launch_menu.lua

local wezterm = require("wezterm")

local module = {}

local function attach(pane, session)
	pane:send_text("tmux new-session -A -D -s " .. session .. "\r")
end

-- Baseline window.
local baseline = {
	{ domain = "local", session = "dev" },
	{ domain = "local", session = "terminal" },
	{ domain = "local", session = "media" },
	{ domain = "theta", session = "terminal" },
	{ domain = "pi", session = "terminal" },
	{ domain = "psi", session = "terminal" },
	{ domain = "omega", session = "terminal" },
}

-- Coding window.
local coding_domain = "omega"
local coding = { "utility", "editor", "claude" }

-- Spawn a tab in mux_win on the given domain and attach the session.
local function spawn_attached(mux_win, domain, session)
	local spawn_args = {}
	if domain ~= "local" then
		spawn_args.domain = { DomainName = domain }
	end
	local _, new_pane = mux_win:spawn_tab(spawn_args)
	if domain == "local" then
		attach(new_pane, session)
	else
		wezterm.time.call_after(0.5, function()
			attach(new_pane, session)
		end)
	end
end

-- Build the baseline into the current window.
-- Reuses the active pane as tab 1.
local function build_baseline(window, pane)
	local mux_win = window:mux_window()
	attach(pane, baseline[1].session)
	for i = 2, #baseline do
		spawn_attached(mux_win, baseline[i].domain, baseline[i].session)
	end
end

-- Open the coding window and tabs.
local function open_coding()
	local _, first_pane, new_window = wezterm.mux.spawn_window({
		domain = { DomainName = coding_domain },
	})
	wezterm.time.call_after(0.5, function()
		attach(first_pane, coding[1])
	end)
	for i = 2, #coding do
		spawn_attached(new_window, coding_domain, coding[i])
	end
end

-- Spawn a remote terminal session.
local function new_tab_on(window, domain)
	spawn_attached(window:mux_window(), domain, "terminal")
end

-- Menu entries. Each action receives (window, pane).
local menu = {
	{ label = "baseline", action = build_baseline },
	{
		label = "coding (omega)",
		action = function()
			open_coding()
		end,
	},
	{
		label = "new tab: omega",
		action = function(w)
			new_tab_on(w, "omega")
		end,
	},
	{
		label = "new tab: pi",
		action = function(w)
			new_tab_on(w, "pi")
		end,
	},
	{
		label = "new tab: psi",
		action = function(w)
			new_tab_on(w, "psi")
		end,
	},
	{
		label = "new tab: theta",
		action = function(w)
			new_tab_on(w, "theta")
		end,
	},
}

local function menu_choices()
	local choices = {}
	for i, entry in ipairs(menu) do
		table.insert(choices, { label = entry.label, id = tostring(i) })
	end
	return choices
end

function module.apply_to_config(config)
	config.keys = config.keys or {}
	table.insert(config.keys, {
		key = "O",
		mods = "CTRL|SHIFT",
		action = wezterm.action.InputSelector({
			title = "Launch",
			choices = menu_choices(),
			action = wezterm.action_callback(function(window, pane, id, label)
				if not id then
					return
				end
				menu[tonumber(id)].action(window, pane)
			end),
		}),
	})
end

return module
