local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:ToBoolean(str)
	local bool = false
	if (str == "true" or str == true) then
		bool = true
	end
	return bool
end

function AccWideUIAceAddon:IsMidnight() -- Temp for Beta
	return (LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_MIDNIGHT) or false
	--return true
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
	return (LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING) or false
end

function AccWideUIAceAddon:IsClassicTBC()
	return (LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE) or false
end

function AccWideUIAceAddon:IsClassicVanilla()
	return (LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CLASSIC) or false
end

function AccWideUIAceAddon:IsClassicEra()
	return (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or false
end