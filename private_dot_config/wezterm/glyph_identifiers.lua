-- glyph_identifiers.lua
local glyphs = {}

-- Hosts = Uppercase Greek (hostname or wezterm domain_name)
glyphs.host = {
	zeta = utf8.char(0x0396), -- Zeta
	theta = utf8.char(0x0398), -- Theta
	pi = utf8.char(0x03A0), -- Pi
	psi = utf8.char(0x03A8), -- Psi
	omega = utf8.char(0x03A9), -- Omega
}

-- Session = Lowercase Greek (tmux #S)
glyphs.session = {
	terminal = utf8.char(0x03C4), -- tau
	debug = utf8.char(0x03B4), -- delta
	media = utf8.char(0x03BD), -- nu
	utility = utf8.char(0x03BA), -- kappa
	editor = utf8.char(0x03B5), -- epsilon
	claude = utf8.char(0x03B1), -- alpha
}

-- Return the glyph for key.
function glyphs.lookup(tbl, key)
	if key == nil then
		return nil
	end
	return tbl[key] or key
end

return glyphs
