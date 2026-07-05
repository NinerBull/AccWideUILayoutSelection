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
	
	if (functionName == "editModeLayout") then -- Edit Mode (C_EditMode)
		return (not self:IsClassicEra())
	elseif (functionName == "lossOfControl") then -- Loss of Control Banners (C_LossOfControl)
		return (not self:IsClassicEra())
	elseif (functionName == "mouseoverCast") then -- Mouseover Cast
		return (not self:IsClassicEra())
	elseif (functionName == "arenaFrames") then -- Arena Frames
		return (not self:IsClassicEra())
	elseif (functionName == "spellOverlay") then -- Spell Overlay (C_SpellActivationOverlay)
		return (not self:IsClassicTBC() and not self:IsClassicEra()
	elseif (functionName == "empowerTap") then -- Empower Tap
		return (self:IsMainline())
	elseif (functionName == "assistedCombat") then -- Rotation Assist (C_AssistedCombat)
		return (self:IsMainline())
	elseif (functionName == "locationVisibility") then -- Location Visibility Toggle (SetAllowRecentAlliesSeeLocation)
		return (self:IsMainline())
	elseif (functionName == "blockNeighborhoodInvites") then -- Block Neighborhood Invites (SetAutoDeclineNeighborhoodInvites)
		return (self:IsMainline())
	elseif (functionName == "bagOrganisation") then -- Bag Organisation (C_Container.SetBankAutosortDisabled)
		return (self:IsMainline())
	elseif (functionName == "damageMeter") then -- Damage Meter (C_DamageMeter)
		return (self:IsMainline())
	elseif (functionName == "cooldownViewer") then -- Cooldown Manager (C_CooldownViewer)
		return (self:IsMainline())
	elseif (functionName == "externalDefensives") then -- External Defensives
		return (self:IsMainline())
	else
		return true
	end

end