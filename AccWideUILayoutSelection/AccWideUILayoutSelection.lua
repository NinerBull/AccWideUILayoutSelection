local AccWideUIFrame = CreateFrame("Frame")
AccWideUIFrame:RegisterEvent("ADDON_LOADED")
AccWideUIFrame:RegisterEvent("PLAYER_LOGIN")
AccWideUIFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
AccWideUIFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
AccWideUIFrame:RegisterEvent("SETTINGS_LOADED")
AccWideUIFrame:RegisterEvent("PLAYER_LOGOUT")



if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

	

	hooksecurefunc(C_EditMode, "OnEditModeExit", function()
			
		
		local getLayoutsTable = C_EditMode.GetLayouts()
		local currentActiveLayout = getLayoutsTable["activeLayout"]
		local currentSpec = GetSpecialization()
		

		
		
		if (AccWideUIDataChar[currentSpec] == true) then

			--Set the spec
			AccWideUIData.accountWideLayoutID = currentActiveLayout
			
			if (AccWideUIData.enableTextOutput == true) then
				print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r Saved your Account Wide Edit Mode to the selected Layout. (ID " .. AccWideUIData.accountWideLayoutID .. "). Type |cnITEM_LEGENDARY_COLOR:/accwideeditmode|r to configure.")
			end

		end

			
	end)
	
	
	
	
	

	AccWideUIFrame:SetScript("OnEvent", function(self, event, arg1, arg2)

		if InCombatLockdown() == false then
			-- do nothing if in combat

			if (event == "SETTINGS_LOADED") then
			
			
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				

				if (AccWideUIData == nil) then
					AccWideUIData = {}
				end
				
				if (AccWideUIData.enableAccountWide == nil) then
					AccWideUIData.enableAccountWide = true
				end
				
				if (AccWideUIData.accountWideLayoutID == nil) then
					AccWideUIData.accountWideLayoutID = currentActiveLayout or 1
				end
				
				if (AccWideUIData.accountWideActionBars == nil) then
					AccWideUIData.accountWideActionBars = true
				end
				
				if (AccWideUIData.enableTextOutput == nil) then
					AccWideUIData.enableTextOutput = true
				end
				
				
				
				
				if (AccWideUIData.ActionBars == nil) then
					AccWideUIData.ActionBars = {}
				end
				
				if (AccWideUIData.ActionBars.Bar2 == nil) then
					AccWideUIData.ActionBars.Bar2 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_2")
				end
				
				if (AccWideUIData.ActionBars.Bar3 == nil) then
					AccWideUIData.ActionBars.Bar3 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_3")
				end
				
				if (AccWideUIData.ActionBars.Bar4 == nil) then
					AccWideUIData.ActionBars.Bar4 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_4")
				end
				
				if (AccWideUIData.ActionBars.Bar5 == nil) then
					AccWideUIData.ActionBars.Bar5 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_5")
				end
				
				if (AccWideUIData.ActionBars.Bar6 == nil) then
					AccWideUIData.ActionBars.Bar6 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_6")
				end
				
				if (AccWideUIData.ActionBars.Bar7 == nil) then
					AccWideUIData.ActionBars.Bar7 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_7")
				end
				
				if (AccWideUIData.ActionBars.Bar8 == nil) then
					AccWideUIData.ActionBars.Bar8 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_8")
				end
				
				
				
				
				
				
				
				
				if (AccWideUIDataChar == nil) then
			
					AccWideUIDataChar = {
							[1] = AccWideUIData.enableAccountWide,
							[2] = AccWideUIData.enableAccountWide,
							[3] = AccWideUIData.enableAccountWide,
							[4] = AccWideUIData.enableAccountWide,
							[5] = AccWideUIData.enableAccountWide --Temp Spec for fresh chars, adding just in case
					}
				
					if (AccWideUIData.enableTextOutput == true) then
					
						print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r This is the first time you have logged in to this character with AccountWideEditMode installed.")
						
						if (AccWideUIData.enableAccountWide == true) then
							print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r Account Wide Edit Mode Selection has been ENABLED by default. Type |cnITEM_LEGENDARY_COLOR:/accwideeditmode|r to configure.")
						else
							print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r Account Wide Edit Mode Selection has been DISABLED by default. Type |cnITEM_LEGENDARY_COLOR:/accwideeditmode|r to configure.")
						end
					
					end
				
				
				else
				
					if (AccWideUIData.enableTextOutput == true) then
				
						print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r Account Wide Edit Mode Selection Addon Loaded!")
					
					end
				
				end
				
				AccWideUIFrame.InitializeOptions()
			
			end



			if  (event == "SETTINGS_LOADED") or (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then


				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = GetSpecialization()
				
				if (AccWideUIDataChar[currentSpec] == true) then
					

					--Set the spec
					C_EditMode.SetActiveLayout(AccWideUIData.accountWideLayoutID)
					
					if (AccWideUIData.accountWideActionBars == true) then
					
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_2", AccWideUIData.ActionBars.Bar2)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_3", AccWideUIData.ActionBars.Bar3)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_4", AccWideUIData.ActionBars.Bar4)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_5", AccWideUIData.ActionBars.Bar5)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", AccWideUIData.ActionBars.Bar6)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_7", AccWideUIData.ActionBars.Bar7)
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", AccWideUIData.ActionBars.Bar8)
					
					end
					
					
					if (AccWideUIData.enableTextOutput == true) then
						print("|cnITEM_LEGENDARY_COLOR:<AccountWideEditMode>:|r Changed UI Layout for this Specialization to your Account Wide UI. (ID " .. AccWideUIData.accountWideLayoutID .. "). Type |cnITEM_LEGENDARY_COLOR:/accwideeditmode|r to configure.")
					end
					
			
				end

					
			end
			
			
			
			
			
			
			
			
			if  (event == "PLAYER_LOGOUT") then
			
				--Save Shown Action Bars
				if (AccWideUIData.accountWideActionBars == true) then

					AccWideUIData.ActionBars.Bar2 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_2")
					AccWideUIData.ActionBars.Bar3 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_3")
					AccWideUIData.ActionBars.Bar4 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_4")
					AccWideUIData.ActionBars.Bar5 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_5")
					AccWideUIData.ActionBars.Bar6 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_6")
					AccWideUIData.ActionBars.Bar7 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_7")
					AccWideUIData.ActionBars.Bar8 = Settings.GetValue("PROXY_SHOW_ACTIONBAR_8")
				
				
				end


			end
			
			
			
		
		end

	end)







	function AccWideUIFrame:InitializeOptions()
		
			accWideUIPanel = CreateFrame("Frame")
			accWideUIPanel.name = "Account Wide Edit Mode Selection"
			InterfaceOptions_AddCategory(accWideUIPanel) 

			--Title
			local title = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			title:SetJustifyV('TOP')
			title:SetJustifyH('LEFT')
			title:SetPoint('TOPLEFT', 16, -16)
			title:SetText("Account Wide Edit Mode Selection")
			
			--Title2
			local title2 = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			title2:SetJustifyV('TOP')
			title2:SetJustifyH('LEFT')
			title2:SetPoint('TOPLEFT', 16, -36)
			title2:SetText("Makes your chosen Edit Mode Layout apply for all of your characters and specs.")
			
			-- Add shortcut to Edit Mode
			local b1 = CreateFrame("Button", nil, accWideUIPanel, "UIPanelButtonTemplate")
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
			local chkEnableDefault = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableDefault:SetPoint("TOPLEFT", 16, -80)
			chkEnableDefault.Text:SetText("Enable by default for all New Characters")
			chkEnableDefault:HookScript("OnClick", function(_, btn, down)
				AccWideUIData.enableAccountWide = chkEnableDefault:GetChecked()
			end)
			chkEnableDefault:SetChecked(AccWideUIData.enableAccountWide)
			
			
			-- Show Text
			local chkSaveActionBar = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkSaveActionBar:SetPoint("TOPLEFT", 16, -105)
			chkSaveActionBar.Text:SetText("Also save which Action Bars are visible")
			chkSaveActionBar:HookScript("OnClick", function(_, btn, down)
					AccWideUIData.accountWideActionBars = chkSaveActionBar:GetChecked()
			end)
			chkSaveActionBar:SetChecked(AccWideUIData.accountWideActionBars)
			
			
			-- Show Text
			local chkShowText = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkShowText:SetPoint("TOPLEFT", 16, -130)
			chkShowText.Text:SetText("Output to chat when addon is loaded or UI is changed by Account Wide UI")
			chkShowText:HookScript("OnClick", function(_, btn, down)
					AccWideUIData.enableTextOutput = chkShowText:GetChecked()
			end)
			chkShowText:SetChecked(AccWideUIData.enableTextOutput)

		
		

			local classDisplayName, class = UnitClass("player");
			local classColorString = RAID_CLASS_COLORS[class].colorStr;
			
			--Title for Char Specific
			local titleCS = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			titleCS:SetJustifyV('TOP')
			titleCS:SetJustifyH('LEFT')
			titleCS:SetPoint('TOPLEFT', 16, -190)
			titleCS:SetText("|c" .. classColorString .. UnitName("player") .. "|r Specific Options")
			
			--Title for Char Specific2
			local titleCS2 = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			titleCS2:SetJustifyV('TOP')
			titleCS2:SetJustifyH('LEFT')
			titleCS2:SetPoint('TOPLEFT', 16, -212)
			titleCS2:SetText("Select whether to use the Account Wide UI for this character's Specializations.")
			
			
			
			
			
			--Specialisations
			AccWideUISpecName = {}
			AccWideUINumSpecializations = GetNumSpecializations(false, false)

			for specx = 1, AccWideUINumSpecializations, 1 do
				AccWideUISpecName[specx] = GetSpecializationNameForSpecID(select(1, GetSpecializationInfo(specx)))
			end
				

			if (AccWideUINumSpecializations >= 1) then
			
				local chkEnableSpec1 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec1:SetPoint("TOPLEFT", 16, -230)
				chkEnableSpec1.Text:SetText(AccWideUISpecName[1])
				chkEnableSpec1:HookScript("OnClick", function(_, btn, down)
					AccWideUIDataChar[1] = chkEnableSpec1:GetChecked()
				end)
				chkEnableSpec1:SetChecked(AccWideUIDataChar[1])

			end
			
			if (AccWideUINumSpecializations >= 2) then
			
				local chkEnableSpec2 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec2:SetPoint("TOPLEFT", 16, -255)
				chkEnableSpec2.Text:SetText(AccWideUISpecName[2])
				chkEnableSpec2:HookScript("OnClick", function(_, btn, down)
					AccWideUIDataChar[2] = chkEnableSpec2:GetChecked()
				end)
				chkEnableSpec2:SetChecked(AccWideUIDataChar[2])

			end
			
			if (AccWideUINumSpecializations >= 3) then
			
				local chkEnableSpec3 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec3:SetPoint("TOPLEFT", 16, -280)
				chkEnableSpec3.Text:SetText(AccWideUISpecName[3])
				chkEnableSpec3:HookScript("OnClick", function(_, btn, down)
					AccWideUIDataChar[3] = chkEnableSpec3:GetChecked()
				end)
				chkEnableSpec3:SetChecked(AccWideUIDataChar[3])

			end
			
			if (AccWideUINumSpecializations >= 4) then
			
				local chkEnableSpec4 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec4:SetPoint("TOPLEFT", 16, -305)
				chkEnableSpec4.Text:SetText(AccWideUISpecName[4])
				chkEnableSpec4:HookScript("OnClick", function(_, btn, down)
					AccWideUIDataChar[4] = chkEnableSpec4:GetChecked()
				end)
				chkEnableSpec4:SetChecked(AccWideUIDataChar[4])

			end
			
			if (AccWideUINumSpecializations >= 5) then
			
				local chkEnableSpec5 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
				chkEnableSpec5:SetPoint("TOPLEFT", 16, -330)
				chkEnableSpec5.Text:SetText(AccWideUISpecName[5])
				chkEnableSpec5:HookScript("OnClick", function(_, btn, down)
					AccWideUIDataChar[5] = chkEnableSpec5:GetChecked()
				end)
				chkEnableSpec5:SetChecked(AccWideUIDataChar[5])

			end
			
			
			
			
		
			
			SLASH_ACCWIDEUI1 = "/accwideui"
			SLASH_ACCWIDEUI2 = "/accwideeditmode"
			function SlashCmdList.ACCWIDEUI(msg)
				InterfaceOptionsFrame_OpenToCategory(accWideUIPanel)
				InterfaceOptionsFrame_OpenToCategory(accWideUIPanel)
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
	local AccWideUITooltip

	function AccWideUI_CompartmentClick(addonName, buttonName)
		InterfaceOptionsFrame_OpenToCategory("Account Wide Edit Mode Selection")
		InterfaceOptionsFrame_OpenToCategory("Account Wide Edit Mode Selection")
	end

	function AccWideUI_CompartmentHover(addonName, buttonName)
		if (not AccWideUITooltip) then
			AccWideUITooltip = CreateFrame("GameTooltip", "AccWideUITooltip_Compartment", UIParent, "GameTooltipTemplate")
		end
		
		local classDisplayName, class = UnitClass("player");
		local classColorString = RAID_CLASS_COLORS[class].colorStr;
		
		AccWideUITooltip:SetOwner(buttonName, "ANCHOR_LEFT");
		AccWideUITooltip:SetText("Account Wide Edit Mode Selection")
		
		AccWideUITooltip:AddLine(" ")
		AccWideUITooltip:AddLine("Current Settings for |c" .. classColorString .. UnitName("player") .. "|r:",  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		AccWideUITooltip:AddLine(" ")
		
		--Specialisations
		AccWideUISpecName = {}
		AccWideUINumSpecializations = GetNumSpecializations(false, false)

		for specx = 1, AccWideUINumSpecializations, 1 do
			AccWideUISpecName[specx] = GetSpecializationNameForSpecID(select(1, GetSpecializationInfo(specx)))
		end
		
		if (AccWideUINumSpecializations >= 1) then
			AccWideUITooltip:AddDoubleLine(AccWideUISpecName[1] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUIDataChar[1]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUINumSpecializations >= 2) then
			AccWideUITooltip:AddDoubleLine(AccWideUISpecName[2] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUIDataChar[2]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUINumSpecializations >= 3) then
			AccWideUITooltip:AddDoubleLine(AccWideUISpecName[3] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUIDataChar[3]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUINumSpecializations >= 4) then
			AccWideUITooltip:AddDoubleLine(AccWideUISpecName[4] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUIDataChar[4]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		if (AccWideUINumSpecializations >= 5) then
			AccWideUITooltip:AddDoubleLine(AccWideUISpecName[5] .. ":", AccWideUI_CompartmentIsSpecActive(AccWideUIDataChar[5]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		end
		
		AccWideUITooltip:AddLine(" ")
		AccWideUITooltip:AddLine("Click to change settings.",  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
		
		AccWideUITooltip:Show()
	end

	function AccWideUI_CompartmentLeave(buttonName)
		AccWideUITooltip:Hide()
	end






else



	print("<AccountWideEditMode>: This addon only works in Retail WoW.")
	
	

end
