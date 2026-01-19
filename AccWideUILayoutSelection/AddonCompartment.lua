local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")
AccWideUIAceAddon.LDBIcon = LibStub:GetLibrary("LibDBIcon-1.0")


-- LDB for Titan Panel
AccWideUIAceAddon.LDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(L["ACCWUI_ADDONNAME_SHORT"], {  
	type = "data source",  
	text = L["ACCWUI_ADDONNAME_SHORT"],  
	label = L["ACCWUI_ADDONNAME_SHORT"],
	version = C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "Version"),
	notes = L["ACCWUI_OPT_TITLE_DESC"],
	icon = C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "IconTexture"), 
	OnClick = function() 
		if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
			AccWideUIAceAddon:SlashCommand()
		else
			StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
		end
	end,
	OnTooltipShow = function(tooltip)
		if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
			tooltip:SetText(L.ACCWUI_ADDONNAME)
		
			tooltip:AddLine(" ")
			tooltip:AddDoubleLine(L["ACCWUI_ADCOM_CURRENT"] .. ":", AccWideUIAceAddon.db:GetCurrentProfile(), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
			
			tooltip:AddLine(" ")
			tooltip:AddLine(L.ACCWUI_ADCOM_CHANGE,  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		end
	end
});


-- Addon Compartment
if (AddonCompartmentFrame) then

	AddonCompartmentFrame:RegisterAddon({
		text = L["ACCWUI_ADDONNAME_SHORT"],
		icon = C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "IconTexture"),
		notCheckable = true,
		
		func = function(button)
			if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
				AccWideUIAceAddon:SlashCommand()
			else
				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
			end
		end,
		
		funcOnEnter = function(button)
			if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then

				if (not AccWideUIAceAddon.Tooltip) then
					AccWideUIAceAddon.Tooltip = CreateFrame("GameTooltip", "AccWideUIAceAddon.Tooltip_Compartment", UIParent, "GameTooltipTemplate")
				end
				
				AccWideUIAceAddon.Tooltip:SetOwner(button, "ANCHOR_LEFT");
				
				AccWideUIAceAddon.Tooltip:SetText(L.ACCWUI_ADDONNAME)
				
				AccWideUIAceAddon.Tooltip:AddLine(" ")
				AccWideUIAceAddon.Tooltip:AddDoubleLine(L["ACCWUI_ADCOM_CURRENT"] .. ":", AccWideUIAceAddon.db:GetCurrentProfile(), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				
				AccWideUIAceAddon.Tooltip:AddLine(" ")
				AccWideUIAceAddon.Tooltip:AddLine(L.ACCWUI_ADCOM_CHANGE,  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
				
				AccWideUIAceAddon.Tooltip:Show()
			
			end
		end,
		
		funcOnLeave = function(button)
			if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
				AccWideUIAceAddon.Tooltip:Hide()
			end
		end,
	})

end
