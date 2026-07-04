local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:ToBoolean(str)
	local bool = false
	if (str == "true" or str == true) then
		bool = true
	end
	return bool
end

function AccWideUIAceAddon:IsMainline()
	return (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or false
end

function AccWideUIAceAddon:IsClassicAny()
	return (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) or false
end

function AccWideUIAceAddon:IsClassicProgression()
	return (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicWrath()
	return (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicTBC()
	return (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicVanilla()
	return (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicEra()
	return (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or false
end

function AccWideUIAceAddon:SupportsGameFunction(functionName)
	-- Should return True if the game supports a particular function and therefore can be synced. 
	-- Only things that are not in all clients (e.g. Arena) should be listed here.
	
	if (functionName == "editModeLayout") then -- Edit Mode
		return (self:IsMainline() or self:IsClassicWrath() or self:IsClassicTBC() or self:IsClassicProgression())
	elseif (functionName == "lossOfControl") then -- Loss of Control Banners
		return (self:IsMainline() or self:IsClassicWrath() or self:IsClassicTBC() or self:IsClassicProgression())
	elseif (functionName == "mouseoverCast") then -- Mouseover Cast
		return (self:IsMainline() or self:IsClassicWrath() or self:IsClassicTBC() or self:IsClassicProgression())
	elseif (functionName == "arenaFrames") then -- Arena Frames
		return (not self:IsClassicEra())
	elseif (functionName == "spellOverlay") then -- Spell Overlay
		return (not self:IsClassicEra())
	elseif (functionName == "empowerTap") then -- Empower Tap
		return (self:IsMainline())
	elseif (functionName == "assistedCombat") then -- 1 Button Assist
		return (self:IsMainline())
	elseif (functionName == "locationVisibility") then -- Location Visibility Toggle
		return (self:IsMainline())
	elseif (functionName == "blockNeighborhoodInvites") then -- Block Neighborhood Invites
		return (self:IsMainline())
	elseif (functionName == "bagOrganisation") then -- Bag Organisation
		return (self:IsMainline())
	elseif (functionName == "nameplateSizeFunc") then -- New Nameplate Size Func
		return (self:IsMainline())
	else
		return true
	end

end