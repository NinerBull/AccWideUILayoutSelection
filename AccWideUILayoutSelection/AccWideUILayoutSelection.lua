local AccWideUIFrame = CreateFrame("Frame")
AccWideUIFrame:RegisterEvent("ADDON_LOADED")
AccWideUIFrame:RegisterEvent("PLAYER_LOGIN")
AccWideUIFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
AccWideUIFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
AccWideUIFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")


hooksecurefunc(C_EditMode, "OnEditModeExit", function()
        
	
	getLayoutsTable = C_EditMode.GetLayouts()
	currentActiveLayout = getLayoutsTable["activeLayout"]
	currentSpec = GetSpecialization()
	

	
	
	if (AccWideUIDataChar[currentSpec] == true) then

		--Set the spec
		AccWideUIData.accountWideLayoutID = currentActiveLayout
		
		if (AccWideUIData.enableTextOutput == true) then
			print("|cffdb562a<AccountWideUI>:|r Saved your Account Wide UI to the selected Layout. (ID " .. AccWideUIData.accountWideLayoutID .. "). Type |cffdb562a/accwideui|r to configure.")
		end

	end

		
end)

AccWideUIFrame:SetScript("OnEvent", function(self, event, arg1, arg2)

	if InCombatLockdown() == false then
		-- do nothing if in combat

		if (event == "PLAYER_LOGIN") then
		
		
			getLayoutsTable = C_EditMode.GetLayouts()
			currentActiveLayout = getLayoutsTable["activeLayout"]

			if (AccWideUIData == nil) then
		
				AccWideUIData = {
					enableAccountWide = true,
					accountWideLayoutID = currentActiveLayout or 1,
					enableTextOutput = true
				}
			
			end
			
			
			
			if (AccWideUIDataChar == nil) then
		
				AccWideUIDataChar = {
						[1] = AccWideUIData.enableAccountWide,
						[2] = AccWideUIData.enableAccountWide,
						[3] = AccWideUIData.enableAccountWide,
						[4] = AccWideUIData.enableAccountWide,
						[5] = AccWideUIData.enableAccountWide --Temp Spec for fresh chars, adding just in case
				}
			
				
				print("|cffdb562a<AccountWideUI>:|r This is the first time you have logged in to this character with AccountWideUI installed.")
				
				if (AccWideUIData.enableAccountWide == true) then
					print("|cffdb562a<AccountWideUI>:|r Account Wide UI has been ENABLED by default. Type |cffdb562a/accwideui|r to configure.")
				else
					print("|cffdb562a<AccountWideUI>:|r Account Wide UI has been DISABLED by default. Type |cffdb562a/accwideui|r to configure.")
				end
			
			
			else
			
				print("|cffdb562a<AccountWideUI>:|r Account Wide UI Addon Loaded! Type |cffdb562a/accwideui|r to configure.")
			
			end
			
			AccWideUIFrame.InitializeOptions()
		
		end



	--(event == "ADDON_LOADED" and arg1 == "AccWideUIFrameLayoutSelection") or
		if  (event == "PLAYER_LOGIN") or (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then


			getLayoutsTable = C_EditMode.GetLayouts()
			currentActiveLayout = getLayoutsTable["activeLayout"]
			currentSpec = GetSpecialization()
			
			if (AccWideUIDataChar[currentSpec] == true) then
				

				--Set the spec
				C_EditMode.SetActiveLayout(AccWideUIData.accountWideLayoutID)
				
				if (AccWideUIData.enableTextOutput == true) then
					print("|cffdb562a<AccountWideUI>:|r Changed UI Layout for this Specialization to your Account Wide UI. (ID " .. AccWideUIData.accountWideLayoutID .. "). Type |cffdb562a/accwideui|r to configure.")
				end
				
			
			--else
		
			end

				
		end
	
	end

end)


function AccWideUIFrame:InitializeOptions()
	
		accWideUIPanel = CreateFrame("Frame")
		accWideUIPanel.name = "Account Wide UI Layout Selection"
		InterfaceOptions_AddCategory(accWideUIPanel) 

		--Title
		local title = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
		title:SetJustifyV('TOP')
		title:SetJustifyH('LEFT')
		title:SetPoint('TOPLEFT', 16, -16)
		title:SetText("Account Wide UI Layout Selection")
		
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
		local chkShowText = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
		chkShowText:SetPoint("TOPLEFT", 16, -105)
		chkShowText.Text:SetText("Output to chat when UI is changed by Account Wide UI")
		chkShowText:HookScript("OnClick", function(_, btn, down)
				AccWideUIData.enableTextOutput = chkShowText:GetChecked()
		end)
		chkShowText:SetChecked(AccWideUIData.enableTextOutput)

	
	

		
		
		
		csPlayerName = UnitName("player")
		
		--Title for Char Specific
		local titleCS = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
		titleCS:SetJustifyV('TOP')
		titleCS:SetJustifyH('LEFT')
		titleCS:SetPoint('TOPLEFT', 16, -180)
		titleCS:SetText(csPlayerName .. " Specific Options")
		
		--Title for Char Specific2
		local titleCS2 = accWideUIPanel:CreateFontString("ARTWORK", nil, "GameFontHighlight")
		titleCS2:SetJustifyV('TOP')
		titleCS2:SetJustifyH('LEFT')
		titleCS2:SetPoint('TOPLEFT', 16, -202)
		titleCS2:SetText("Select whether to use the Account Wide UI for this character's Specializations.")
		
		
		
		
		
		
	
		--Specialisations
		specName = {}
		numSpecializations = GetNumSpecializations(false, false)
	
		for specx = 1, numSpecializations, 1 do
		
			specName[specx] = GetSpecializationNameForSpecID(select(1, GetSpecializationInfo(specx)))
		
		end
	
		--tprint(specName)
		
		
		if (numSpecializations >= 1) then
		
			local chkEnableSpec1 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableSpec1:SetPoint("TOPLEFT", 16, -220)
			chkEnableSpec1.Text:SetText(specName[1])
			chkEnableSpec1:HookScript("OnClick", function(_, btn, down)
				AccWideUIDataChar[1] = chkEnableSpec1:GetChecked()
			end)
			chkEnableSpec1:SetChecked(AccWideUIDataChar[1])

		end
		
		if (numSpecializations >= 2) then
		
			local chkEnableSpec2 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableSpec2:SetPoint("TOPLEFT", 16, -242)
			chkEnableSpec2.Text:SetText(specName[2])
			chkEnableSpec2:HookScript("OnClick", function(_, btn, down)
				AccWideUIDataChar[2] = chkEnableSpec2:GetChecked()
			end)
			chkEnableSpec2:SetChecked(AccWideUIDataChar[2])

		end
		
		if (numSpecializations >= 3) then
		
			local chkEnableSpec3 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableSpec3:SetPoint("TOPLEFT", 16, -264)
			chkEnableSpec3.Text:SetText(specName[3])
			chkEnableSpec3:HookScript("OnClick", function(_, btn, down)
				AccWideUIDataChar[3] = chkEnableSpec3:GetChecked()
			end)
			chkEnableSpec3:SetChecked(AccWideUIDataChar[3])

		end
		
		if (numSpecializations >= 4) then
		
			local chkEnableSpec4 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableSpec4:SetPoint("TOPLEFT", 16, -286)
			chkEnableSpec4.Text:SetText(specName[4])
			chkEnableSpec4:HookScript("OnClick", function(_, btn, down)
				AccWideUIDataChar[4] = chkEnableSpec4:GetChecked()
			end)
			chkEnableSpec4:SetChecked(AccWideUIDataChar[4])

		end
		
		if (numSpecializations >= 5) then
		
			local chkEnableSpec5 = CreateFrame("CheckButton", nil, accWideUIPanel, "InterfaceOptionsCheckButtonTemplate")
			chkEnableSpec5:SetPoint("TOPLEFT", 16, -288)
			chkEnableSpec5.Text:SetText(specName[5])
			chkEnableSpec5:HookScript("OnClick", function(_, btn, down)
				AccWideUIDataChar[5] = chkEnableSpec5:GetChecked()
			end)
			chkEnableSpec5:SetChecked(AccWideUIDataChar[5])

		end
		
		
		
		
		
		
		
		
	
		
		SLASH_ACCWIDEUI1 = "/accwideui"
		function SlashCmdList.ACCWIDEUI(msg)
			InterfaceOptionsFrame_OpenToCategory(accWideUIPanel)
			InterfaceOptionsFrame_OpenToCategory(accWideUIPanel)
		end
	
end



