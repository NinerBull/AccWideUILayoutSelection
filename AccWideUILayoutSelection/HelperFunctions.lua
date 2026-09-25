local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:ToBoolean(str)
	local bool = false
	if (str == "true" or str == true) then
		bool = true
	end
	return bool
end

function AccWideUIAceAddon:GetPlayerName()
	
	local thisFirstName, thisLastName = UnitNameUnmodified("player")
	
	if (thisLastName) then
		return (thisFirstName .. " " .. thisLastName)
	else
		return (thisFirstName)
	end

end

function AccWideUIAceAddon:GetInterfaceVersion()
	local thisInterface, _, _ = select(4, GetBuildInfo())
	return thisInterface
end


function AccWideUIAceAddon:IsStandard() -- Retail
	return (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and self:GetInterfaceVersion() >= 120001) or false
end

function AccWideUIAceAddon:IsForever() -- Forever
	return (self:GetInterfaceVersion() >= 16001 and self:GetInterfaceVersion() < 20000) or false
end

function AccWideUIAceAddon:IsMainline() -- Mainline, either Retail or Forever
	return (self:IsStandard() or self:IsForever())
end

function AccWideUIAceAddon:IsClassicAny() -- Not Retail
	return (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) or false
end

function AccWideUIAceAddon:IsClassicProgression() -- MoP Classic
	return (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicWrath() -- Wrath Classic
	return (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicTBC() -- TBC Classic
	return (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicVanilla() -- Era
	return (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicEra() -- Era
	return (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or false
end


-- China WoW Specific
function AccWideUIAceAddon:IsClassicWrathChina()
	return (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC and self:GetInterfaceVersion() < 30800) or false
end
-- EO China WoW Specific


function AccWideUIAceAddon:SupportsGameFunction(functionName)
	-- Should return True if the game supports a particular function and therefore can be synced. 
	-- Only things that are not in all clients (e.g. Arena) should be listed here.
	
	if (functionName == "editModeLayout") then -- Edit Mode (C_EditMode)
		return (C_AddOns.DoesAddOnExist("Blizzard_EditMode"))
	elseif (functionName == "arenaFrames") then -- Arena Frames
		return (not self:IsClassicEra() and not self:IsForever())
	elseif (functionName == "spellOverlay") then -- Spell Overlay (C_SpellActivationOverlay)
		return (not self:IsClassicTBC() and not self:IsClassicEra())
	elseif (functionName == "empowerTap") then -- Empower Tap
		return (self:IsMainline())
	elseif (functionName == "assistedCombat") then -- Rotation Assist (C_AssistedCombat)
		return (self:IsStandard())
	elseif (functionName == "locationVisibility") then -- Location Visibility Toggle (SetAllowRecentAlliesSeeLocation)
		return (self:IsMainline())
	elseif (functionName == "blockNeighborhoodInvites") then -- Block Neighborhood Invites (SetAutoDeclineNeighborhoodInvites)
		return (self:IsStandard())
	elseif (functionName == "bagOrganisation") then -- Bag Organisation (C_Container.SetBankAutosortDisabled)
		return (self:IsStandard())
	elseif (functionName == "damageMeter") then -- Damage Meter (C_DamageMeter)
		return (self:IsMainline())
	elseif (functionName == "cooldownViewer") then -- Cooldown Manager (C_CooldownViewer)
		return (self:IsMainline())
	elseif (functionName == "externalDefensives") then -- External Defensives
		return (self:IsMainline())
	elseif (functionName == "encounterTimeline") then -- Encounter Timeline
		return (self:IsStandard())
	elseif (functionName == "gamepad") then -- Gamepad
		return (self:IsForever())
	else
		return true
	end

end
