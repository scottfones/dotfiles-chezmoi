-- I am launch_menu.lua and I should live in ~/.config/wezterm/launch_menu.lua

local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

-- Hosts offered by the "new tab" entries.
local hosts = { "local", "omega", "pi", "psi", "theta" }

-- Quote session names that come from the prompt.
local function attach(pane, session)
	local quoted = "'" .. session:gsub("'", [['\'']]) .. "'"
	pane:send_text("tmux new-session -A -D -s " .. quoted .. "\r")
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
		-- Delay for command processing.
		wezterm.time.call_after(0.5, function()
			attach(new_pane, session)
		end)
	end
end

-- Build the baseline into the current window.
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

-- Prompt for a session name, then attach it on the given domain.
local prompt_session = {}
for _, domain in ipairs(hosts) do
	prompt_session[domain] = act.PromptInputLine({
		description = "tmux session on " .. domain,
		initial_value = "terminal",
		action = wezterm.action_callback(function(window, _, line)
			if line and line ~= "" then
				spawn_attached(window:mux_window(), domain, line)
			end
		end),
	})
end

-- Menu entries. Each action receives (window, pane).
local menu = {
	{ label = "baseline", action = build_baseline },
	{ label = "coding (omega)", action = open_coding },
}

for _, domain in ipairs(hosts) do
	table.insert(menu, {
		label = "new tab: " .. domain,
		action = function(window, pane)
			window:perform_action(prompt_session[domain], pane)
		end,
	})
end

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
		action = act.InputSelector({
			title = "Launch",
			choices = menu_choices(),
			action = wezterm.action_callback(function(window, pane, id)
				if not id then
					return
				end
				menu[tonumber(id)].action(window, pane)
			end),
		}),
	})
end

return module
