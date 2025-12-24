local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

-- LDB for Titan Panel
local ldb = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(L["ACCWUI_ADDONNAME_SHORT"], {  
	type = "data source",  
	text = L["ACCWUI_ADDONNAME_SHORT"],  
	icon = "Interface\\Icons\\inv_glyph_primewarrior.blp",  
	--tooltipTitle = L.ACCWUI_ADDONNAME,
	OnClick = function() AccWideUI_CompartmentClick() end,
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

--Addon Compartment
local AccWideUI_Tooltip

function AccWideUI_CompartmentClick(addonName, buttonName)
	if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
		AccWideUIAceAddon:SlashCommand()
	else
		StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
	end
end

function AccWideUI_CompartmentHover(addonName, buttonName)

	if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then

		if (not AccWideUI_Tooltip) then
			AccWideUI_Tooltip = CreateFrame("GameTooltip", "AccWideUI_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
		end
		
		AccWideUI_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
		
		AccWideUI_Tooltip:SetText(L.ACCWUI_ADDONNAME)
		
		AccWideUI_Tooltip:AddLine(" ")
		AccWideUI_Tooltip:AddDoubleLine(L["ACCWUI_ADCOM_CURRENT"] .. ":", AccWideUIAceAddon.db:GetCurrentProfile(), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		
		AccWideUI_Tooltip:AddLine(" ")
		AccWideUI_Tooltip:AddLine(L.ACCWUI_ADCOM_CHANGE,  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		
		AccWideUI_Tooltip:Show()
	
	end
	
end

function AccWideUI_CompartmentLeave(buttonName)
	if (AccWideUIAceAddon.db.global.hasDoneFirstTimeSetup == true) then
		AccWideUI_Tooltip:Hide()
	end
end

