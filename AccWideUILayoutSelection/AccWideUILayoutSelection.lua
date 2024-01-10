local AccWideUI_Frame = CreateFrame("Frame")


	local function AccWideUI_ToBoolean(str)
		local bool = false
		if str == "true" then
			bool = true
		end
		return bool
	end



	AccWideUI_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	AccWideUI_Frame:RegisterEvent("SETTINGS_LOADED")
	AccWideUI_Frame:RegisterEvent("PLAYER_LOGOUT")
	AccWideUI_Frame:RegisterEvent("PLAYER_LEAVING_WORLD")

	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		AccWideUI_Frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	end

	local AccWideUI_TextName = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("<Account Wide Interface>")
	local AccWideUI_TextSlash = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("/accwideinterface")
	local AccWideUI_ThisCategory = nil


		--AccWideUI = {}
		

		if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
			hooksecurefunc(C_EditMode, "OnEditModeExit", function()
			
				if (AccWideUI_AccountData.accountWideLayout == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Acc Wide UI.")
					end
						
					
					local getLayoutsTable = C_EditMode.GetLayouts()
					local currentActiveLayout = getLayoutsTable["activeLayout"]
					local currentSpec = tostring(GetSpecialization())
					
					if (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then

						--Set the spec
						AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout
						
						AccWideUI_Frame:SaveUISettings()

					end
					
					
					
					
					
				end -- EO accountWideLayout
					
			end)
		
		end
		

		
		
		AccWideUI_Table_NameplateVariables = {
			"NamePlateClassificationScale",
			"nameplateClassResourceTopInset",
			"nameplateGameObjectMaxDistance",
			"nameplateGlobalScale",
			"nameplateHideHealthAndPower",
			"NamePlateHorizontalScale",
			"nameplateLargeBottomInset",
			"nameplateLargerScale",
			"nameplateLargeTopInset",
			"nameplateMaxAlpha",
			"nameplateMaxAlphaDistance",
			"nameplateMaxDistance",
			"NamePlateMaximumClassificationScale",
			"nameplateMaxScale",
			"nameplateMaxScaleDistance",
			"nameplateMinAlpha",
			"nameplateMinAlphaDistance",
			"nameplateMinScale",
			"nameplateMinScaleDistance",
			"nameplateMotion",
			"nameplateMotionSpeed",
			"nameplateOccludedAlphaMult",
			"nameplateOtherBottomInset",
			"nameplateOtherTopInset",
			"NameplatePersonalClickThrough",
			"NameplatePersonalHideDelayAlpha",
			"NameplatePersonalHideDelaySeconds",
			"NameplatePersonalShowAlways",
			"NameplatePersonalShowInCombat",
			"NameplatePersonalShowWithTarget",
			"nameplatePlayerLargerScale",
			"nameplatePlayerMaxDistance",
			"nameplateResourceOnTarget",
			"nameplateSelectedAlpha",
			"nameplateSelectedScale",
			"nameplateSelfAlpha",
			"nameplateSelfBottomInset",
			"nameplateSelfScale",
			"nameplateSelfTopInset",
			"nameplateShowAll",
			"nameplateShowDebuffsOnFriendly",
			"nameplateShowEnemies",
			"nameplateShowEnemyGuardians",
			"nameplateShowEnemyMinions",
			"nameplateShowEnemyMinus",
			"nameplateShowEnemyPets",
			"nameplateShowEnemyTotems",
			"nameplateShowFriendlyBuffs",
			"nameplateShowFriendlyGuardians",
			"nameplateShowFriendlyMinions",
			"nameplateShowFriendlyNPCs",
			"nameplateShowFriendlyPets",
			"nameplateShowFriendlyTotems",
			"nameplateShowFriends",
			"nameplateShowPersonalCooldowns",
			"nameplateShowSelf",
			"nameplateTargetBehindMaxDistance",
			"NamePlateVerticalScale",
			"ShowClassColorInFriendlyNameplate",
			"ShowClassColorInNameplate",
			"ShowNamePlateLoseAggroFlash",
			"nameplateShowOnlyNames"
		}
		
		
		
		AccWideUI_Table_RaidFrameVariables = {
			"raidFramesDisplayAggroHighlight",
			"raidFramesDisplayClassColor",
			"raidFramesDisplayDebuffs",
			"raidFramesDisplayIncomingHeals",
			"raidFramesDisplayOnlyDispellableDebuffs",
			"raidFramesDisplayPowerBars",
			"raidFramesHealthText",
			"raidFramesHeight",
			"raidFramesPosition",
			"raidFramesWidth",
			"raidFramesHealthText",
			"showPartyPets",
			"raidOptionLocked",
			"raidOptionIsShown",
			"raidOptionSortMode",
			"raidOptionDisplayPets",
			"raidOptionShowBorders",
			"raidOptionKeepGroupsTogether",	
			"raidOptionDisplayMainTankAndAssist",
			"raidFramesDisplayOnlyHealerPowerBars",
			"useCompactPartyFrames",
			"activeCUFProfile"
		}
		
		
		AccWideUI_Table_ArenaFrameVariables = {
			"showArenaEnemyCastbar",
			"showArenaEnemyFrames",
			"showArenaEnemyPets",
			"pvpOptionDisplayPets",
			"pvpFramesHealthText",
			"pvpFramesDisplayPowerBars",
			"pvpFramesDisplayClassColor",
			"pvpFramesDisplayOnlyHealerPowerBars",
		}
		
		

		AccWideUI_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

			if (InCombatLockdown() == false) then
				-- do nothing if in combat

				if (event == "SETTINGS_LOADED") then
				
				
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
						local getLayoutsTable = C_EditMode.GetLayouts()
						local currentActiveLayout = getLayoutsTable["activeLayout"]
						
					end		
					



					if (type(AccWideUI_AccountData) ~= "table") then
						AccWideUI_AccountData = {}
					end
					
					if (type(AccWideUI_AccountData.enableDebug) ~= "boolean") then
						AccWideUI_AccountData.enableDebug = false
					end
					
					
		
					if (type(AccWideUI_AccountData.enableAccountWide) ~= "boolean") then
						AccWideUI_AccountData.enableAccountWide = true
					end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
						
						if (type(AccWideUI_AccountData.accountWideLayoutID) ~= "number") then
							AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout or 1
						end
						
						if (type(AccWideUI_AccountData.accountWideLayout) ~= "boolean") then
							AccWideUI_AccountData.accountWideLayout = true
						end
					
					end
		
					
					if (type(AccWideUI_AccountData.enableTextOutput) ~= "boolean") then
						AccWideUI_AccountData.enableTextOutput = true
					end

					if (type(AccWideUI_AccountData.accountWideActionBars) ~= "boolean") then
						AccWideUI_AccountData.accountWideActionBars = true
					end
					
					if (type(AccWideUI_AccountData.accountWideNameplates) ~= "boolean") then
						AccWideUI_AccountData.accountWideNameplates = true
					end
					
					if (type(AccWideUI_AccountData.accountWideRaidFrames) ~= "boolean") then
						AccWideUI_AccountData.accountWideRaidFrames = true
					end
					
					if (type(AccWideUI_AccountData.accountWideArenaFrames) ~= "boolean") then
						AccWideUI_AccountData.accountWideArenaFrames = true
					end
					
					
					
					
					
					
					
					
					
					
					-- Action Bar Variables
					if (type(AccWideUI_AccountData.ActionBars) ~= "table") then
						AccWideUI_AccountData.ActionBars = {}
					end
					
					

				
					if (type(AccWideUI_AccountData.ActionBars.Bar2) ~= "string") then
						AccWideUI_AccountData.ActionBars.Bar2 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_2"))
					end
					
					if (type(AccWideUI_AccountData.ActionBars.Bar3) ~= "string") then
						AccWideUI_AccountData.ActionBars.Bar3 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_3"))
					end
					
					if (type(AccWideUI_AccountData.ActionBars.Bar4) ~= "string") then
						AccWideUI_AccountData.ActionBars.Bar4 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_4"))
					end
					
					if (type(AccWideUI_AccountData.ActionBars.Bar5) ~= "string") then
						AccWideUI_AccountData.ActionBars.Bar5 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_5"))
					end
					
					
					
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
						
						if (type(AccWideUI_AccountData.ActionBars.Bar6) ~= "string") then
							AccWideUI_AccountData.ActionBars.Bar6 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_6"))
						end
					
						if (type(AccWideUI_AccountData.ActionBars.Bar7) ~= "string") then
							AccWideUI_AccountData.ActionBars.Bar7 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_7"))
						end
						
						if (type(AccWideUI_AccountData.ActionBars.Bar8) ~= "string") then
							AccWideUI_AccountData.ActionBars.Bar8 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_8"))
						end
					
					end



					
					-- Nameplates Variables
					if (type(AccWideUI_AccountData.Nameplates) ~= "table") then
						AccWideUI_AccountData.Nameplates = {}
					end
					
					for k, v in pairs(AccWideUI_Table_NameplateVariables) do
						if (type(AccWideUI_AccountData.Nameplates[v]) == "nil") then
							AccWideUI_AccountData.Nameplates[v] = GetCVar(v) or nil
						end
					end
					

					-- Raid Frame Variables
					if (type(AccWideUI_AccountData.RaidFrames) ~= "table") then
						AccWideUI_AccountData.RaidFrames = {}
					end
					
					for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
						if (type(AccWideUI_AccountData.RaidFrames[v]) == "nil") then
							AccWideUI_AccountData.RaidFrames[v] = GetCVar(v) or nil
						end
					end
					
					
					-- Arena Frame Variables
					if (type(AccWideUI_AccountData.ArenaFrames) ~= "table") then
						AccWideUI_AccountData.ArenaFrames = {}
					end
					
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						if (type(AccWideUI_AccountData.ArenaFrames[v]) == "nil") then
							AccWideUI_AccountData.ArenaFrames[v] = GetCVar(v) or nil
						end
					end
					
				
				
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

						if ((type(AccWideUI_CharData) == "table") and (AccWideUI_CharData["accWideSpec1"] == nil)) then
							AccWideUI_CharData = nil
							print(AccWideUI_TextName .. " Removed Invalid Char Data.")
						end
						
						
						if (type(AccWideUI_CharData) ~= "table") then
					
							AccWideUI_CharData = {
									["accWideSpec1"] = AccWideUI_AccountData.enableAccountWide,
									["accWideSpec2"] = AccWideUI_AccountData.enableAccountWide,
									["accWideSpec3"] = AccWideUI_AccountData.enableAccountWide,
									["accWideSpec4"] = AccWideUI_AccountData.enableAccountWide,
									["accWideSpec5"] = AccWideUI_AccountData.enableAccountWide --Temp Spec for fresh chars, adding just in case
							}
						
							if (AccWideUI_AccountData.enableTextOutput == true) then
							
								print(AccWideUI_TextName .. " This is the first time you have logged in to this character with AccountWideInterface installed.")
							
							end
						
						
						else
						
							if (AccWideUI_AccountData.enableTextOutput == true) then
						
								print(AccWideUI_TextName .. " Account Wide Interface Option Settings Addon Loaded! Type " .. AccWideUI_TextSlash .. " to configure.")
							
							end
						
						end
						
					
					else
					
						if (AccWideUI_AccountData.enableTextOutput == true) then
						
								print(AccWideUI_TextName .. " Account Wide Interface Option Settings Addon Loaded! Type " .. AccWideUI_TextSlash .. " to configure.")
							
						end
							
					end
					
					AccWideUI_Frame.InitializeOptions()
				
				end



				if  (event == "SETTINGS_LOADED") then
				
					
					
					RunNextFrame(function() 
						AccWideUI_Frame:LoadUISettings() 
					end)
					
					C_Timer.After(10, function() 
						AccWideUI_Frame:LoadUISettings()
					end)
				
					
		
				end --EO Settings Loaded
				
				
				if  (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then
					
					AccWideUI_Frame:SaveUISettings()
					AccWideUI_Frame:LoadUISettings()
		
				end --EO Settings Loaded
				
				
				
				
				
				if  (event == "PLAYER_LOGOUT" or event == "PLAYER_LEAVING_WORLD") then
					
					AccWideUI_Frame:SaveUISettings()

				end
				
				
				
			
			end

		end)







		function AccWideUI_Frame:InitializeOptions()
		
		
			--[[
		
			local category, layout = Settings.RegisterVerticalLayoutCategory("Account Wide Interface Option Settings")
			Settings.AccWideUISettingsID = category:GetID();
			
			
			-- Show Text
			do
				local variable, name, tooltip = "enableTextOutput", "Output to Chat", "Outputs to the chat window when this addon has been loaded.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			
			layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("What should be saved Account Wide?"));
			
			-- Save Edit Mode Layout
			do
				local variable, name, tooltip = "accountWideLayout", "Chosen Edit Mode Layout", "Makes the chosen Edit Mode Layout work across Account Wide.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			
			-- Save Action Bars
			do
				local variable, name, tooltip = "accountWideActionBars", "Visible Action Bars", "Makes the currently visible Action Bars work Account Wide.\n\nNote that this does not affect what abilities you have on your bars, only which bars are visible.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			
			-- Save Nameplates
			do
				local variable, name, tooltip = "accountWideNameplates", "Nameplate Settings", "Makes various Nameplate Settings work Account Wide.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			--Save Raid Frames
			do
				local variable, name, tooltip = "accountWideRaidFrames", "Party/Raid Frame Settings", "Makes various Party and Raid Frame Settings work Account Wide.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			--Save Arena Frames
			do
				local variable, name, tooltip = "accountWideArenaFrames", "Arena Frame Settings", "Makes various Arena Frame Settings work Account Wide.";
				local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
				Settings.CreateCheckBox(category, setting, tooltip);
			end
			
			

			
			
		
				layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Edit Mode Layout Settings"));


				-- Enable by Default
				do
					local variable, name, tooltip = "enableAccountWide", "Enforce Chosen Layout by Default", "Enables the Edit Mode Layout Per-Spec by default for all of your characters.";
					local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_AccountData, type(AccWideUI_AccountData[variable]), name, true);
					Settings.CreateCheckBox(category, setting, tooltip);
				end
			
		
			
			
			
				local classColorString = C_ClassColor.GetClassColor(UnitClass("player"));
			
			
				layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(classColorString:WrapTextInColorCode(UnitName("player")) .. "'s Per-Spec Edit Mode Settings"));
				
				--Specialisations
				
				
				
					AccWideUI_SpecName = {}
					AccWideUI_NumSpecializations = GetNumSpecializations(false, false)
					
					for specx = 1, AccWideUI_NumSpecializations, 1 do
						AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
					end
					
					
					
					if (AccWideUI_NumSpecializations >= 1) then
					
						do
							local variable, name, tooltip = "accWideSpec1", AccWideUI_SpecName[1], "Enforces the chosen Account Wide Edit Mode Layout for your " .. AccWideUI_SpecName[1] .. " spec.";
							local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_CharData, type(AccWideUI_CharData[variable]), name, true);
							Settings.CreateCheckBox(category, setting, tooltip);
						end
					
					end
					
					if (AccWideUI_NumSpecializations >= 2) then
					
						do
							local variable, name, tooltip = "accWideSpec2", AccWideUI_SpecName[2], "Enforces the chosen Account Wide Edit Mode Layout for your " .. AccWideUI_SpecName[2] .. " spec.";
							local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_CharData, type(AccWideUI_CharData[variable]), name, true);
							Settings.CreateCheckBox(category, setting, tooltip);
						end
					
					end
					
					if (AccWideUI_NumSpecializations >= 3) then
					
						do
							local variable, name, tooltip = "accWideSpec3", AccWideUI_SpecName[3], "Enforces the chosen Account Wide Edit Mode Layout for your " .. AccWideUI_SpecName[3] .. " spec.";
							local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_CharData, type(AccWideUI_CharData[variable]), name, true);
							Settings.CreateCheckBox(category, setting, tooltip);
						end
					
					end
					
					if (AccWideUI_NumSpecializations >= 4) then
					
						do
							local variable, name, tooltip = "accWideSpec4", AccWideUI_SpecName[4], "Enforces the chosen Account Wide Edit Mode Layout for your " .. AccWideUI_SpecName[4] .. " spec.";
							local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_CharData, type(AccWideUI_CharData[variable]), name, true);
							Settings.CreateCheckBox(category, setting, tooltip);
						end
					
					end
					
					if (AccWideUI_NumSpecializations >= 5) then
					
						do
							local variable, name, tooltip = "accWideSpec5", AccWideUI_SpecName[5], "Enforces the chosen Account Wide Edit Mode Layout for your " .. AccWideUI_SpecName[5] .. " spec.";
							local setting = Settings.RegisterProxySetting(category, variable, AccWideUI_CharData, type(AccWideUI_CharData[variable]), name, true);
							Settings.CreateCheckBox(category, setting, tooltip);
						end
					
					end
					
			

			
		
			
			Settings.RegisterAddOnCategory(category);
		]]--
			
			
				AccWideUI_OptionsPanelFrame = CreateFrame("Frame")
				AccWideUI_OptionsPanelFrame.name = "Account Wide Interface Option Settings"
				InterfaceOptions_AddCategory(AccWideUI_OptionsPanelFrame) 
				
				
				local thisPointX = 16
				local thisPointY = -10

				--Title
				local title = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				title:SetJustifyV('TOP')
				title:SetJustifyH('LEFT')
				title:SetPoint('TOPLEFT', thisPointX, thisPointY)
				title:SetText("Account Wide Interface Option Settings")
				
				thisPointY = thisPointY - 20
				
				--Title2
				local title2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				title2:SetJustifyV('TOP')
				title2:SetJustifyH('LEFT')
				title2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				title2:SetText("Makes your chosen Interface Options apply for all of your characters and specs.")
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

					thisPointY = thisPointY - 20
					
					-- Add shortcut to Edit Mode
					local b1 = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
					b1:SetSize(140 ,20)
					b1:SetText("Open Edit Mode")
					b1:SetPoint("TOPLEFT",thisPointX, thisPointY)
					b1:SetScript("OnClick", function()
						if SettingsPanel:IsShown() then
							HideUIPanel(SettingsPanel)
						end
						ShowUIPanel(EditModeManagerFrame)
					end)
					
					
					thisPointY = thisPointY - 30
					
					--Enable by Default
					local chkEnableDefault = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableDefault:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableDefault.Text:SetText("Enable Edit Mode by default for all New Characters")
					chkEnableDefault:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.enableAccountWide = chkEnableDefault:GetChecked()
					end)
					chkEnableDefault:SetChecked(AccWideUI_AccountData.enableAccountWide)
			
				end
				
				
				thisPointY = thisPointY - 25
				
				
				-- Show Text
				local chkShowText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkShowText:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkShowText.Text:SetText("Output to chat when addon is loaded")
				chkShowText:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.enableTextOutput = chkShowText:GetChecked()
				end)
				chkShowText:SetChecked(AccWideUI_AccountData.enableTextOutput)
				
				
				
				
				thisPointY = -160
				
				
				--Title for Which Save Options
				local titleSA = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				titleSA:SetJustifyV('TOP')
				titleSA:SetJustifyH('LEFT')
				titleSA:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleSA:SetText("Enable Account Wide Modules")
				
				
				thisPointY = thisPointY - 25
				
				
				--Title for  Which Save Options 2
				local titleSA2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				titleSA2:SetJustifyV('TOP')
				titleSA2:SetJustifyH('LEFT')
				titleSA2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleSA2:SetText("What kind of UI settings would you like to save Account Wide?")
				
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					
					thisPointY = thisPointY - 25 
				
					-- Save Edit Mode Layout
					local chkSaveEditModeLayout = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkSaveEditModeLayout:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkSaveEditModeLayout.Text:SetText("Chosen Edit Mode Layout")
					chkSaveEditModeLayout:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.accountWideLayout = chkSaveEditModeLayout:GetChecked()
					end)
					chkSaveEditModeLayout:SetChecked(AccWideUI_AccountData.accountWideLayout)
				
				end


				thisPointY = thisPointY - 25 
				
				
				-- Save Action Bars
				local chkSaveActionBar = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveActionBar:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveActionBar.Text:SetText("Visible Action Bars")
				chkSaveActionBar:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideActionBars = chkSaveActionBar:GetChecked()
				end)
				chkSaveActionBar:SetChecked(AccWideUI_AccountData.accountWideActionBars)
				
				thisPointY = thisPointY - 25 
				
				
				-- Save Nameplates
				local chkSaveNameplates = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveNameplates:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveNameplates.Text:SetText("Nameplate Settings")
				chkSaveNameplates:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideNameplates = chkSaveNameplates:GetChecked()
				end)
				chkSaveNameplates:SetChecked(AccWideUI_AccountData.accountWideNameplates)
				
				thisPointY = thisPointY - 25 
				
				
				-- Save Raid Frames
				local chkSaveRaidFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveRaidFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveRaidFrames.Text:SetText("Party/Raid Frame Settings")
				chkSaveRaidFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideRaidFrames = chkSaveRaidFrames:GetChecked()
				end)
				chkSaveRaidFrames:SetChecked(AccWideUI_AccountData.accountWideRaidFrames)
				
				thisPointY = thisPointY - 25 
				
				
				-- Save Arena Frames
				local chkSaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveArenaFrames.Text:SetText("Arena Frame Settings")
				chkSaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideArenaFrames = chkSaveArenaFrames:GetChecked()
				end)
				chkSaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideArenaFrames)
				
				
				

				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
					thisPointY = -375
					local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
					

					

					
					--Title for Char Specific
					local titleCS = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
					titleCS:SetJustifyV('TOP')
					titleCS:SetJustifyH('LEFT')
					titleCS:SetPoint('TOPLEFT', thisPointX, thisPointY)
					titleCS:SetText(classColorString:WrapTextInColorCode(UnitName("player")) .. " Specific Options")
					
					thisPointY = thisPointY - 25
					
					--Title for Char Specific2
					local titleCS2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
					titleCS2:SetJustifyV('TOP')
					titleCS2:SetJustifyH('LEFT')
					titleCS2:SetPoint('TOPLEFT', thisPointX, thisPointY)
					titleCS2:SetText("Select whether to use the chosen Edit Mode layout for this character's Specializations.")
				

				
				
					--Specialisations
				
				
				
					AccWideUI_SpecName = {}
					AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

					for specx = 1, AccWideUI_NumSpecializations, 1 do
						AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
						
					end
					
					thisPointY = -395
						

					if (AccWideUI_NumSpecializations >= 1) then
					
						thisPointY = thisPointY - 25
					
						local chkEnableSpec1 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
						chkEnableSpec1:SetPoint("TOPLEFT", thisPointX, thisPointY)
						chkEnableSpec1.Text:SetText(AccWideUI_SpecName[1])
						chkEnableSpec1:HookScript("OnClick", function(_, btn, down)
							AccWideUI_CharData["accWideSpec" .. 1] = chkEnableSpec1:GetChecked()
						end)
						chkEnableSpec1:SetChecked(AccWideUI_CharData["accWideSpec" .. 1])

					end
					
					if (AccWideUI_NumSpecializations >= 2) then
					
						thisPointY = thisPointY - 25
					
						local chkEnableSpec2 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
						chkEnableSpec2:SetPoint("TOPLEFT", thisPointX, thisPointY)
						chkEnableSpec2.Text:SetText(AccWideUI_SpecName[2])
						chkEnableSpec2:HookScript("OnClick", function(_, btn, down)
							AccWideUI_CharData["accWideSpec" .. 2] = chkEnableSpec2:GetChecked()
						end)
						chkEnableSpec2:SetChecked(AccWideUI_CharData["accWideSpec" .. 2])

					end
					
					if (AccWideUI_NumSpecializations >= 3) then
					
						thisPointY = thisPointY - 25
					
						local chkEnableSpec3 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
						chkEnableSpec3:SetPoint("TOPLEFT", thisPointX, thisPointY)
						chkEnableSpec3.Text:SetText(AccWideUI_SpecName[3])
						chkEnableSpec3:HookScript("OnClick", function(_, btn, down)
							AccWideUI_CharData["accWideSpec" .. 3] = chkEnableSpec3:GetChecked()
						end)
						chkEnableSpec3:SetChecked(AccWideUI_CharData["accWideSpec" .. 3])

					end
					
					if (AccWideUI_NumSpecializations >= 4) then
					
						thisPointY = thisPointY - 25
					
						local chkEnableSpec4 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
						chkEnableSpec4:SetPoint("TOPLEFT", thisPointX, thisPointY)
						chkEnableSpec4.Text:SetText(AccWideUI_SpecName[4])
						chkEnableSpec4:HookScript("OnClick", function(_, btn, down)
							AccWideUI_CharData["accWideSpec" .. 4] = chkEnableSpec4:GetChecked()
						end)
						chkEnableSpec4:SetChecked(AccWideUI_CharData["accWideSpec" .. 4])

					end
					
					if (AccWideUI_NumSpecializations >= 5) then
					
						thisPointY = thisPointY - 25
					
						local chkEnableSpec5 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
						chkEnableSpec5:SetPoint("TOPLEFT", thisPointX, thisPointY)
						chkEnableSpec5.Text:SetText(AccWideUI_SpecName[5])
						chkEnableSpec5:HookScript("OnClick", function(_, btn, down)
							AccWideUI_CharData["accWideSpec" .. 5] = chkEnableSpec5:GetChecked()
						end)
						chkEnableSpec5:SetChecked(AccWideUI_CharData["accWideSpec" .. 5])

					end
					
				
				end
			
			
				
				SLASH_ACCWIDEUI1 = "/accwideui"
				SLASH_ACCWIDEUI2 = "/accwideeditmode"
				SLASH_ACCWIDEUI3 = "/accwideinterface"
				function SlashCmdList.ACCWIDEUI(msg)
					InterfaceOptionsFrame_OpenToCategory(AccWideUI_OptionsPanelFrame)
					InterfaceOptionsFrame_OpenToCategory(AccWideUI_OptionsPanelFrame)
				end
				
				
			
		end





		
		function AccWideUI_Frame:LoadUISettings()
		
			if (InCombatLockdown()) then
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Not loading UI Settings while in combat.")
				end
				
			else
			
				
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading UI Settings.")
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					-- Use Acc Wide Layout
					local getLayoutsTable = C_EditMode.GetLayouts()
					local currentActiveLayout = getLayoutsTable["activeLayout"]
					local currentSpec = tostring(GetSpecialization())
					
					if (AccWideUI_AccountData.accountWideLayout == true) and (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then
					

						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Loading Acc Wide UI.")
						end

						--Set the spec
						C_EditMode.SetActiveLayout(AccWideUI_AccountData.accountWideLayoutID)
				
					
				end -- eo accountWideLayout

				end
				
				-- Use Action Bars
				if (AccWideUI_AccountData.accountWideActionBars == true) then
						
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Action Bar Settings.")
					end
					
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_2", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar2))
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_3", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar3))
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_4", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar4))
						Settings.SetValue("PROXY_SHOW_ACTIONBAR_5", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar5))
						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
							Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar6))
							Settings.SetValue("PROXY_SHOW_ACTIONBAR_7", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar7))
							Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", AccWideUI_ToBoolean(AccWideUI_AccountData.ActionBars.Bar8))
						end
				
				end -- EO accountWideActionBars


				-- Use Nameplates
				if (AccWideUI_AccountData.accountWideNameplates == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Nameplate Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_NameplateVariables) do
						SetCVar(v, AccWideUI_AccountData.Nameplates[v])
					end
				
				end -- EO accountWideNameplates
				
				
				
				-- Use Raid Frames
				if (AccWideUI_AccountData.accountWideRaidFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Raid Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
						SetCVar(v, AccWideUI_AccountData.RaidFrames[v])
					end
				
				end -- EO accountWideRaidFrames
				
				
				-- Use Arena Frames
				if (AccWideUI_AccountData.accountWideArenaFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Arena Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						SetCVar(v, AccWideUI_AccountData.ArenaFrames[v])
					end
				
				end -- EO accountWideRaidFrames
			
			
			end
		
		end




		function AccWideUI_Frame:SaveUISettings()
		
		
			if (InCombatLockdown()) then
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Not saving UI Settings while in combat.")
				end
				
			else
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving UI Settings.")
				end
				
			
				--Save Shown Action Bars
				if (AccWideUI_AccountData.accountWideActionBars == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Action Bar Settings.")
					end

						AccWideUI_AccountData.ActionBars.Bar2 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_2"))
						AccWideUI_AccountData.ActionBars.Bar3 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_3"))
						AccWideUI_AccountData.ActionBars.Bar4 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_4"))
						AccWideUI_AccountData.ActionBars.Bar5 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_5"))
						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
							AccWideUI_AccountData.ActionBars.Bar6 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_6"))
							AccWideUI_AccountData.ActionBars.Bar7 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_7"))
							AccWideUI_AccountData.ActionBars.Bar8 = tostring(Settings.GetValue("PROXY_SHOW_ACTIONBAR_8"))
						end
			
				
				end
				
				
				-- Save Nameplates
				if (AccWideUI_AccountData.accountWideNameplates == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Nameplate Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_NameplateVariables) do
						AccWideUI_AccountData.Nameplates[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideNameplates
				
				
				
				-- Save Raid Frames
				if (AccWideUI_AccountData.accountWideRaidFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Raid Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
						AccWideUI_AccountData.RaidFrames[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideRaidFrames
				
				
				-- Save Arena Frames
				if (AccWideUI_AccountData.accountWideArenaFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Arena Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						AccWideUI_AccountData.ArenaFrames[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideRaidFrames
			
			end
		
		end








		function AccWideUI_Frame:CompartmentIsSpecActive(thisSpec)
		
			if (thisSpec == true) then
				return("|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t")
			else
				return("|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t")
			end	
		
		end
		
		

		
		
		
		
		--Addon Compartment
		local AccWideUI_Tooltip

		function AccWideUI_CompartmentClick(addonName, buttonName)
			InterfaceOptionsFrame_OpenToCategory("Account Wide Interface Option Settings")
			InterfaceOptionsFrame_OpenToCategory("Account Wide Interface Option Settings")
		end

		function AccWideUI_CompartmentHover(addonName, buttonName)
		
				if (not AccWideUI_Tooltip) then
					AccWideUI_Tooltip = CreateFrame("GameTooltip", "AccWideUI_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
				end
				
				local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
				
				AccWideUI_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
				AccWideUI_Tooltip:SetText("Account Wide Interface Option Settings")
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					
					AccWideUI_Tooltip:AddLine(" ")
					AccWideUI_Tooltip:AddLine("Current Settings for " .. classColorString:WrapTextInColorCode(UnitName("player")) .. ":",  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					AccWideUI_Tooltip:AddLine(" ")
					
					--Specialisations
					AccWideUI_SpecName = {}
					AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

					for specx = 1, AccWideUI_NumSpecializations, 1 do
						AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
					end
					
					if (AccWideUI_NumSpecializations >= 1) then
						AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[1] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 1]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					end
					
					if (AccWideUI_NumSpecializations >= 2) then
						AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[2] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 2]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					end
					
					if (AccWideUI_NumSpecializations >= 3) then
						AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[3] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 3]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					end
					
					if (AccWideUI_NumSpecializations >= 4) then
						AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[4] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 4]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					end
					
					if (AccWideUI_NumSpecializations >= 5) then
						AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[5] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 5]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
					end
				
				end
				
				AccWideUI_Tooltip:AddLine(" ")
				AccWideUI_Tooltip:AddLine("Click to change settings.",  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
				
				AccWideUI_Tooltip:Show()
			
		end

		function AccWideUI_CompartmentLeave(buttonName)
				AccWideUI_Tooltip:Hide()
		end


