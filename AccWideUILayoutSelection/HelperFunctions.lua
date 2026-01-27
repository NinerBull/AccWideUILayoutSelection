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