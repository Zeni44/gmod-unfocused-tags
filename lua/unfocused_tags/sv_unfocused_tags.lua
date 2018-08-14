local net    = net
local util   = util

local PLAYER = FindMetaTable("Player")

local tag    = "unfocused_tags"

util.AddNetworkString(tag)

function PLAYER:SetFocused(focused)
	self:SetNW2Bool(tag, focused)
end

net.Receive(tag, function(_, ply)
	local focused = net.ReadBool()

	ply:SetFocused(focused)
end)
