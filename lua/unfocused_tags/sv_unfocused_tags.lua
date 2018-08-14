local net    = net
local util   = util

local PLAYER = FindMetaTable("Player")

local tag    = "focus_tab"

util.AddNetworkString(tag)

function PLAYER:SetFocused(focused)
	self:SetNW2Bool(tag, focused)
end

net.Receive(tag, function(_, ply)
	local focused = net.ReadBool()

	ply:SetFocused(focused)
end)
