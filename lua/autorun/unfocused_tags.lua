local path = "unfocused_tags/"

include(path .. "sh_unfocused_tags.lua")
if SERVER then
	AddCSLuaFile(path .. "sh_unfocused_tags.lua")
	AddCSLuaFile(path .. "cl_unfocused_tags.lua")

	include(path .. "sv_unfocused_tags.lua")
else
	include(path .. "cl_unfocused_tags.lua")
end
