local hook    = hook
local table   = table
local net     = net
local surface = surface
local cam     = cam
local system  = system
local timer   = timer
local Msg     = Msg
local print   = print
local CreateClientConVar = CreateClientConVar

local tag = "unfocused_tags"
local fancyTag = "UnfocusedTags"

local shoulddraw = CreateClientConVar("cl_" .. tag, "1")

local function debugPrint(str)
	Msg("[" .. fancyTag .. "] ") print(str)

	return false
end

local function sendNet(bool)
	net.Start(tag)
		net.WriteBool(bool)
	net.SendToServer()
end

if system.IsLinux() then 
	sendNet(true)
	return debugPrint("Disabled on Linux due to issues???")
end

surface.CreateFont(tag, {
	font      = "Helvetica",
	size      = 90,
	weight    = 900,
	antialias = true
})

local lply         = LocalPlayer()
local fake_players = {}

timer.Create(tag, 1, 0, function()
	if shoulddraw and not shoulddraw:GetBool() then return end
	if not lply:IsValid() then return end

	local focused = system.HasFocus()
	fake_players  = player.GetHumans()
	table.sort(fake_players, function(a, b)
		return a:GetPos():DistToSqr(lply:GetPos()) < b:GetPos():DistToSqr(lply:GetPos())
	end)

	if focused ~= (lply.HasFocus and lply:HasFocus()) then
		sendNet(focused)
	end
end)

local convar  = GetConVar("sv_" .. tag .. "_text")
local afktext = convar and convar:GetString() or "Unfocused"
hook.Add("PostDrawTranslucentRenderables", tag, function()
	if shoulddraw and not shoulddraw:GetBool() then return end
	if not lply:IsValid() then lply = LocalPlayer() return end

	local eyeang = lply:EyeAngles()

	eyeang:RotateAroundAxis(eyeang:Up(),     -90)
	eyeang:RotateAroundAxis(eyeang:Forward(), 90)

	for _, ply in ipairs(fake_players) do
		if not ply:IsValid() then continue end

		if lply == ply then continue end

		if lply:GetPos():DistToSqr(ply:GetPos()) > 350000 then continue end

		local hasfocus = ply:HasFocus()
		if hasfocus then continue end

		local ret = hook.Run("ShouldDrawUnfocus", ply)
		if ret == false then continue end

		ply = not ply:Alive() and ply:GetRagdollEntity():IsValid() and ply:GetRagdollEntity() or ply
		local att = ply:GetAttachment(ply:LookupAttachment("eyes"))
		if att then		
			local alpha = 400 / lply:GetPos():DistToSqr(ply:GetPos())
			
			local pos = att.Pos
			pos = pos + eyeang:Right() * -11

			cam.Start3D2D(pos, eyeang, 0.03)
				surface.SetFont(tag)
				local x, y = surface.GetTextSize(afktext)

				surface.SetTextColor(200, 50, 50, 200 - (alpha * 200))
				surface.SetTextPos(-x * 0.5, 0)
				surface.DrawText(afktext)
			cam.End3D2D()
		end
	end
end)