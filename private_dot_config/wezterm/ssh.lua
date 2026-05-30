-- I am ssh.lua and I should live in ~/.config/wezterm/ssh.lua

local module = {}

function module.apply_to_config(config)
	config.ssh_domains = {
		{
			name = "omega",
			remote_address = "omega",
			multiplexing = "None",
		},
		{
			name = "pi",
			remote_address = "pi",
			multiplexing = "None",
		},
		{
			name = "psi",
			remote_address = "psi",
			multiplexing = "None",
		},
		{
			name = "theta",
			remote_address = "theta",
			multiplexing = "None",
		},
	}
end

return module
