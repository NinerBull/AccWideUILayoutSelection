local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:ToBoolean(str)
	local bool = false
	if (str == "true" or str == true) then
		bool = true
	end
	return bool
end

function AccWideUIAceAddon:GetPlayerName()
	if (NameUtil and NameUtil.GetUnmodifiedUnitFullName) then
		return(NameUtil.GetUnmodifiedUnitFullName("player"))
	else
		return(UnitNameUnmodified("player") .. "-" .. GetNormalizedRealmName())
	end
end

function AccWideUIAceAddon:GetInterfaceVersion()
	local thisInterface, _, _ = select(4, GetBuildInfo())
	return thisInterface
end

function AccWideUIAceAddon:IsRetail() -- Retail
	return (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or false
end

function AccWideUIAceAddon:IsForever() -- Forever
	return (WOW_PROJECT_ID == WOW_PROJECT_CAMELOT) or false
end

function AccWideUIAceAddon:IsModern() -- Mainline, either Retail or Forever
	return (self:IsRetail() or self:IsForever())
end

function AccWideUIAceAddon:IsMainline() -- Alias for above
	return (self:IsModern())
end

function AccWideUIAceAddon:IsClassicAny() -- Not Retail or Forever
	return (not self:IsModern()) or false
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


function AccWideUIAceAddon:IsUsingGamepadUI()
	return(C_InputInterfaceStyle and C_InputInterfaceStyle.GetCurrentStyle and C_InputInterfaceStyle.GetCurrentStyle() == 1)
end


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
		return (self:IsModern())
	elseif (functionName == "assistedCombat") then -- Rotation Assist (C_AssistedCombat)
		return (self:IsRetail())
	elseif (functionName == "locationVisibility") then -- Location Visibility Toggle (SetAllowRecentAlliesSeeLocation)
		return (self:IsModern())
	elseif (functionName == "blockNeighborhoodInvites") then -- Block Neighborhood Invites (SetAutoDeclineNeighborhoodInvites)
		return (self:IsRetail())
	elseif (functionName == "bagOrganisation") then -- Bag Organisation (C_Container.SetBankAutosortDisabled)
		return (self:IsRetail())
	elseif (functionName == "damageMeter") then -- Damage Meter (C_DamageMeter)
		return (self:IsModern())
	elseif (functionName == "cooldownViewer") then -- Cooldown Manager (C_CooldownViewer)
		return (self:IsModern())
	elseif (functionName == "externalDefensives") then -- External Defensives
		return (self:IsModern())
	elseif (functionName == "encounterTimeline") then -- Encounter Timeline
		return (self:IsRetail())
	elseif (functionName == "gamepad") then -- Gamepad
		return (self:IsForever())
	elseif (functionName == "actionBars") then
		return (not self:IsUsingGamepadUI()) -- Modifying action bars breaks if Gamepad UI is enabled
	else
		return true
	end

end
