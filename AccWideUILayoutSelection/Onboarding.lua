local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

-- Popups for first time set up
StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP"] = {
	text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L["ACCWUI_ADDONNAME"] .. "\n--------------------------------") .. "\n\n" .. L["ACCWUI_FIRSTTIME_LINE1"] .. "\n" .. L["ACCWUI_FIRSTTIME_LINE2"],
	button1 = string.format(L["ACCWUI_FIRSTTIME_BTN1"], UnitName("player")),
	button2 = L["ACCWUI_FIRSTTIME_BTN2"],
	verticalButtonLayout = true,
	OnAccept  = function()
		AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup = true
		AccWideUIAceAddon:SaveUISettings()
		AccWideUIAceAddon.TempData.HasDoneInitialLoad = true
		if (AccWideUIAceAddon:IsMainline()) then
			AccWideUIAceAddon:SaveEditModeSettings()
		end
		C_Timer.After(0.1, function() 
			StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP_ACCEPTED")
		end)
	end,
	OnCancel = function()
		C_Timer.After(0.1, function() 
			StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP_DECLINED")
		end)
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = false,
}

StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP_ACCEPTED"] = {
	text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L["ACCWUI_ADDONNAME"] .. "\n--------------------------------") .. "\n\n" .. L["ACCWUI_FIRSTTIME_ACCEPTED_LINE1"] .. "\n" .. string.format(L["ACCWUI_FIRSTTIME_ACCEPTED_LINE2"], AccWideUIAceAddon.TempData.TextSlash),
	button1 = OKAY,
	timeout = 0,
	sound = SOUNDKIT.GS_CHARACTER_CREATION_CREATE_CHAR,
	whileDead = true,
	hideOnEscape = false,
}

StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP_DECLINED"] = {
	text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L["ACCWUI_ADDONNAME"] .. "\n--------------------------------") .. "\n\n" .. L["ACCWUI_FIRSTTIME_DECLINED_LINE1"],
	button1 = OKAY,
	timeout = 0,
	sound = SOUNDKIT.LOOT_WINDOW_OPEN_EMPTY,
	whileDead = true,
	hideOnEscape = false,
	OnAccept  = function()
		AccWideUIAceAddon.TempData.HasDimissedFTPAlready = true
	end,
}