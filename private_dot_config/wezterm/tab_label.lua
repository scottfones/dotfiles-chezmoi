-- tab_label.lua
local glyphs = require("glyph_identifiers")

local M = {}

local SENTINEL = "wzt|"

-- Parse a stamped tmux title. Returns (session, content).
function M.parse_title(raw)
	raw = raw or ""
	if raw:sub(1, #SENTINEL) ~= SENTINEL then
		return nil, raw
	end
	local rest = raw:sub(#SENTINEL + 1)
	local colon = rest:find(":", 1, true)
	if not colon then
		return nil, rest
	end
	return rest:sub(1, colon - 1), rest:sub(colon + 1)
end

-- Host key source the wezterm domain, local tabs the hostname.
function M.host_key(domain, hostname)
	if domain and domain ~= "" and domain ~= "local" then
		return domain
	end
	-- wezterm.hostname() returns an FQDN
	-- key based on the short name before the first dot
	return hostname and hostname:match("^[^.]+") or hostname
end

-- Produce the logical label segments.
function M.segments(tab_index, domain, hostname, raw_title)
	local session, content = M.parse_title(raw_title)
	return {
		index = tostring(tab_index),
		host = glyphs.lookup(glyphs.host, M.host_key(domain, hostname)),
		session = glyphs.lookup(glyphs.session, session),
		content = content or "",
	}
end

return M
