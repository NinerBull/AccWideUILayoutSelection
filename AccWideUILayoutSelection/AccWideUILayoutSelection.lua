local AccWideUI_Frame = CreateFrame("Frame")
AccWideUI_Frame:RegisterEvent("ADDON_LOADED")
AccWideUI_Frame:RegisterEvent("PLAYER_LOGIN")
AccWideUI_Frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
AccWideUI_Frame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
AccWideUI_Frame:RegisterEvent("SETTINGS_LOADED")
AccWideUI_Frame:RegisterEvent("PLAYER_LOGOUT")



local AccWideUI_TextName = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("<AccountWideEditMode>")
local AccWideUI_TextSlash = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("/accwideeditmode")



if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then



	hooksecurefunc(C_EditMode, "OnEditModeExit", function()
			
		
		local getLayoutsTable = C_EditMode.GetLayouts()
		local currentActiveLayout = getLayoutsTable["activeLayout"]
		local currentSpec = GetSpecialization()
		

		
		
		if (AccWideUI_CharData[currentSpec] == true) then

			--Set the spec
			AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout
			
			if (AccWideUI_AccountData.enableTextOutput == true) then
				print(AccWideUI_TextName .. " Saved your selected Edit Mode Layout as the Account Wide Layout. (ID " .. AccWideUI_AccountData.accountWideLayoutID .. "). Type " .. AccWideUI_TextSlash .. " to configure.")
			end

		end

			
	end)
	
	
	
	
	

	AccWideUI_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

		if InCombatLockdown() == false then
			-- do nothing if in combat

			if (event == "SETTINGS_LOADED") then
			
			
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				
				
				
				
				--Upgrade
				if (AccWideUIData ~= nil) then
					AccWideUI_AccountData = AccWideUIData
					AccWideUIData = nil
				end
				
				if (AccWideUIDataChar ~= nil) then
					AccWideUI_CharData = AccWideUIDataChar
					AccWideUIDataChar = nil
				end
				
				
				

				if (AccWideUI_AccountData == nil) then
					AccWideUI_AccountData = {}
				end
				
				if (AccWideUI_AccountData.enableAccountWide == nil) then
					AccWideUI_AccountData.enableAccountWide = true
				end
				
				if (AccWideUI_AccountData.accountWideLayoutID == nil) then
					AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout or 1
				end
				
				if (AccWideUI_AccountData.accountWideActionBars == nil) then
					AccWideUI_AccountData.accountWideActionBars = true
				end
				
				if (AccWideUI_AccountData.enableTextOutput == nil) then
					AccWideUI_AccountData.enableTextOutput = true
				end
				
				
				
				
				if (AccWideUI_AccountData.ActionBars == nil) then
					AccWideUI_AccountData.ActionBars = {}
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar2 == nil) then
					AccWideUI_AccountData.ActionBars.Bar2 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_2")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar3 == nil) then
					AccWideUI_AccountData.ActionBars.Bar3 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_3")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar4 == nil) then
					AccWideUI_AccountData.ActionBars.Bar4 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_4")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar5 == nil) then
					AccWideUI_AccountData.ActionBars.Bar5 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_5")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar6 == nil) then
					AccWideUI_AccountData.ActionBars.Bar6 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_6")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar7 == nil) then
					AccWideUI_AccountData.ActionBars.Bar7 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_7")
				end
				
				if (AccWideUI_AccountData.ActionBars.Bar8 == nil) then
					AccWideUI_AccountData.ActionBars.Bar8 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_8")
				end
				
				
				
				
				
				
				
				
				if (AccWideUI_CharData == nil) then
			
					AccWideUI_CharData = {
							[1] = AccWideUI_AccountData.enableAccountWide,
							[2] = AccWideUI_AccountData.enableAccountWide,
							[3] = AccWideUI_AccountData.enableAccountWide,
							[4] = AccWideUI_AccountData.enableAccountWide,
							[5] = AccWideUI_AccountData.enableAccountWide --Temp Spec for fresh chars, adding just in case
					}
				
					if (AccWideUI_AccountData.enableTextOutput == true) then
					
						print(AccWideUI_TextName .. " This is the first time you have logged in to this character with AccountWideEditMode installed.")
						
						if (AccWideUI_AccountData.enableAccountWide == true) then
							print(AccWideUI_TextName .. " Account Wide Edit Mode Layout has been ENABLED by default. Type " .. AccWideUI_TextSlash .. " to configure.")
						else
							print(AccWideUI_TextName .. " Account Wide Edit Mode Layout has been DISABLED by default. Type " .. AccWideUI_TextSlash .. " to configure.")
						end
					
					end
				
				
				else
				
					if (AccWideUI_AccountData.enableTextOutput == true) then
				
						print(AccWideUI_TextName .. " Account Wide Edit Mode Layout Addon Loaded!")
					
					end
				
				end
				
				AccWideUI_Frame.InitializeOptions()
			
			end



			if  (event == "SETTINGS_LOADED") or (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then


				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = GetSpecialization()
				
				if (AccWideUI_CharData[currentSpec] == true) then
					

					--Set the spec
					C_EditMode.SetActiveLayout(AccWideUI_AccountData.accountWideLayoutID)
					
					if (AccWideUI_AccountData.accountWideActionBars == true) then
					
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_2", AccWideUI_AccountData.ActionBars.Bar2)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_3", AccWideUI_AccountData.ActionBars.Bar3)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_4", AccWideUI_AccountData.ActionBars.Bar4)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_5", AccWideUI_AccountData.ActionBars.Bar5)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", AccWideUI_AccountData.ActionBars.Bar6)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_7", AccWideUI_AccountData.ActionBars.Bar7)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", AccWideUI_AccountData.ActionBars.Bar8)
					
					end
					
					
					if (AccWideUI_AccountData.enableTextOutput == true) then
						print(AccWideUI_TextName .. " Changed UI Layout for this Specialization to your Account Wide Layout. (ID " .. AccWideUI_AccountData.accountWideLayoutID .. "). Type " .. AccWideUI_TextSlash .. " to configure.")
					end
					
			
				end

					
			end
			
			
			
			
			
			
			
			
			if  (event == "PLAYER_LOGOUT") then
			
				--Save Shown Action Bars
				if (AccWideUI_AccountData.accountWideActionBars == true) then

					AccWideUI_AccountData.ActionBars.Bar2 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_2")
					AccWideUI_AccountData.ActionBars.Bar3 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_3")
					AccWideUI_AccountData.ActionBars.Bar4 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_4")
					AccWideUI_AccountData.ActionBars.Bar5 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_5")
					AccWideUI_AccountData.ActionBars.Bar6 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_6")
					AccWideUI_AccountData.ActionBars.Bar7 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_7")
					AccWideUI_AccountData.ActionBars.Bar8 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_8")
				
				
				end


			end
			
			
			
		
		end

	end)







	function AccWideUI_Frame:InitializeOptions()
		
			AccWideUI_OptionsPanelFrame = CreateFrame("Frame")
			AccWideUI_OptionsPanelFrame.name = "Account Wide Edit Mode Layout"
			InterfaceOptions_AddCategory(AccWideUI_OptionsPanelFrame) 

			--Title
			local title = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			title:SetJustifyV('TOP')
			title:SetJustifyH('LEFT')
			title:SetPoint('TOPLEFT', 16, -16)
			title:SetText("Account Wide Edit Mode Layout")
			
			--Title2
			local title2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			title2:SetJustifyV('TOP')
			title2:SetJustifyH('LEFT')
			title2:SetPoint('TOPLEFT', 16, -36)
			title2:SetText("Makes your chosen Edit Mode Layout apply for all of your characters and specs.")
			
			-- Add shortcut to Edit Mode
			local b1 = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
			b1:SetSize(140 ,20)
			b1:SetText("Open Edit Mode")
			b1:SetPoint("TOPLEFT",16,-56)
			b1:SetScript("OnClick", function()
				if SettingsPanel:IsShown() then
					HideUIPanel(SettingsPanel)
				end
				ShowUIPanel(EditModeManagerFrame)
			end)
			
			
			--Enable by Default
			local chkEnableDefault = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkEnableDefault:SetPoint("TOPLEFT", 16, -80)
			chkEnableDefault.Text:SetText("Enable by default for all New Characters")
			chkEnableDefault:HookScript("OnClick", function(_, btn, down)
				AccWideUI_AccountData.enableAccountWide = chkEnableDefault:GetChecked()
			end)
			chkEnableDefault:SetChecked(AccWideUI_AccountData.enableAccountWide)
			
			
			-- Save action bars
			local chkSaveActionBar = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveActionBar:SetPoint("TOPLEFT", 16, -105)
			chkSaveActionBar.Text:SetText("Also save which Action Bars are visible")
			chkSaveActionBar:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideActionBars = chkSaveActionBar:GetChecked()
			end)
			chkSaveActionBar:SetChecked(AccWideUI_AccountData.accountWideActionBars)
			
			
			-- Show Text
			local chkShowText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkShowText:SetPoint("TOPLEFT", 16, -130)
			chkShowText.Text:SetText("Output to chat when addon is loaded or UI is changed by this addon.")
			chkShowText:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableTextOutput = chkShowText:GetChecked()
			end)
			chkShowText:SetChecked(AccWideUI_AccountData.enableTextOutput)

		
		

			local classColorString = C_ClassColor.GetClassColor(UnitClass("player"));
			
			--Title for Char Specific
			local titleCS = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			titleCS:SetJustifyV('TOP')
			titleCS:SetJustifyH('LEFT')
			titleCS:SetPoint('TOPLEFT', 16, -190)
			titleCS:SetText(classColorString:WrapTextInColorCode(UnitName("player")) .. " Specific Options")
			
			--Title for Char Specific2
			local titleCS2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			titleCS2:SetJustifyV('TOP')
			titleCS2:SetJustifyH('LEFT')
			titleCS2:SetPoint('TOPLEFT', 16, -212)
			titleCS2:SetText("Select whether to use the Account Wide Layout for this character's Specializations.")
			
			
			
			
			
			--Specialisations
			AccWideUI_SpecName = {}
			AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

			for specx = 1, AccWideUI_NumSpecializations, 1 do
				AccWideUI_SpecName[specx] = GetSpecializationNameForSpecID(select(1, GetSpecializationInfo(specx)))
			end
				

			if (AccWideUI_NumSpecializations >= 1) then
			
				local chkEnableSpec1 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec1:SetPoint("TOPLEFT", 16, -230)
				chkEnableSpec1.Text:SetText(AccWideUI_SpecName[1])
				chkEnableSpec1:HookScript("OnClick", function(_, btn, down)
					AccWideUI_CharData[1] = chkEnableSpec1:GetChecked()
				end)
				chkEnableSpec1:SetChecked(AccWideUI_CharData[1])

			end
			
			if (AccWideUI_NumSpecializations >= 2) then
			
				local chkEnableSpec2 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec2:SetPoint("TOPLEFT", 16, -255)
				chkEnableSpec2.Text:SetText(AccWideUI_SpecName[2])
				chkEnableSpec2:HookScript("OnClick", function(_, btn, down)
					AccWideUI_CharData[2] = chkEnableSpec2:GetChecked()
				end)
				chkEnableSpec2:SetChecked(AccWideUI_CharData[2])

			end
			
			if (AccWideUI_NumSpecializations >= 3) then
			
				local chkEnableSpec3 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec3:SetPoint("TOPLEFT", 16, -280)
				chkEnableSpec3.Text:SetText(AccWideUI_SpecName[3])
				chkEnableSpec3:HookScript("OnClick", function(_, btn, down)
					AccWideUI_CharData[3] = chkEnableSpec3:GetChecked()
				end)
				chkEnableSpec3:SetChecked(AccWideUI_CharData[3])

			end
			
			if (AccWideUI_NumSpecializations >= 4) then
			
				local chkEnableSpec4 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec4:SetPoint("TOPLEFT", 16, -305)
				chkEnableSpec4.Text:SetText(AccWideUI_SpecName[4])
				chkEnableSpec4:HookScript("OnClick", function(_, btn, down)
					AccWideUI_CharData[4] = chkEnableSpec4:GetChecked()
				end)
				chkEnableSpec4:SetChecked(AccWideUI_CharData[4])

			end
			
			if (AccWideUI_NumSpecializations >= 5) then
			
				local chkEnableSpec5 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec5:SetPoint("TOPLEFT", 16, -330)
				chkEnableSpec5.Text:SetText(AccWideUI_SpecName[5])
				chkEnableSpec5:HookScript("OnClick", function(_, btn, down)
					AccWideUI_CharData[5] = chkEnableSpec5:GetChecked()
				end)
				chkEnableSpec5:SetChecked(AccWideUI_CharData[5])

			end
			
			
			
			
		
			
			SLASH_ACCWIDEUI1 = "/accwideui"
			SLASH_ACCWIDEUI2 = "/accwideeditmode"
			function SlashCmdList.ACCWIDEUI(msg)
				InterfaceOptionsFrame_OpenToCategory(AccWideUI_OptionsPanelFrame)
				InterfaceOptionsFrame_OpenToCategory(AccWideUI_OptionsPanelFrame)
			end
			
			
		
	end













	function AccWideUI_CompartmentIsSpecActive(thisSpec)
	
		if (thisSpec == true) then
			return("|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t")
		else
			return("|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t")
		end	
	
	end
	
	

	
	
	
	
	--Addon Compartment
	local AccWideUI_Tooltip

	function AccWideUI_CompartmentClick(addonName, buttonName)
		InterfaceOptionsFrame_OpenToCategory("Account Wide Edit Mode Layout")
		InterfaceOptionsFrame_OpenToCategory("Account Wide Edit Mode Layout")
	end

	function AccWideUI_CompartmentHover(addonName, buttonName)
		if (not AccWideUI_Tooltip) then
			AccWideUI_Tooltip = CreateFrame("GameTooltip", "AccWideUI_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
		end
		
		local classColorString = C_ClassColor.GetClassColor(UnitClass("player"));
		
		AccWideUI_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
		AccWideUI_Tooltip:SetText("Account Wide Edit Mode Layout")
		
		AccWideUI_Tooltip:AddLine(" ")
		AccWideUI_Tooltip:AddLine("Current Settings for " .. classColorString:WrapTextInColorCode(UnitName("player")) .. ":",  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		AccWideUI_Tooltip:AddLine(" ")
		
		--Specialisations
		AccWideUI_SpecName = {}
		AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

		for specx = 1, AccWideUI_NumSpecializations, 1 do
			AccWideUI_SpecName[specx] = GetSpecializationNameForSpecID(select(1, GetSpecializationInfo(specx)))
		end
		
		if (AccWideUI_NumSpecializations >= 1) then
			AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[1] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUI_CharData[1]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUI_NumSpecializations >= 2) then
			AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[2] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUI_CharData[2]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUI_NumSpecializations >= 3) then
			AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[3] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUI_CharData[3]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUI_NumSpecializations >= 4) then
			AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[4] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUI_CharData[4]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUI_NumSpecializations >= 5) then
			AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[5] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUI_CharData[5]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		AccWideUI_Tooltip:AddLine(" ")
		AccWideUI_Tooltip:AddLine("Click to change settings.",  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		
		AccWideUI_Tooltip:Show()
	end

	function AccWideUI_CompartmentLeave(buttonName)
		AccWideUI_Tooltip:Hide()
	end






else



	print(AccWideUI_TextName .. " This addon only works in Retail WoW.")
	
	

end
