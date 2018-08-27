local tag     = "unfocused_tags"

local PLAYER  = FindMetaTable("Player")

CreateConVar("sv_" .. tag .. "_text", "Unfocused", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Change the to be displayed text on the clients.")

local function IsFocused(ply)
	return ply:GetNW2Bool(tag)
end
PLAYER.GetFocus  = IsFocused
PLAYER.HasFocus  = IsFocused
