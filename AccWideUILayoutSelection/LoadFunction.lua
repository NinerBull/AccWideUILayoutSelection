local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:LoadUISettings(doNotLoadChatOrBagSettings)

	local LoadUIAllowSaveTime = 36
	
	if (self.db.global.hasDoneFirstTimeSetup == true) then
	
		self:CancelAllTimers()
		
		if (InCombatLockdown() or IsEncounterInProgress()) then
			self.TempData.LoadSettingsAfterCombat = true
		else
			self.TempData.LoadSettingsAfterCombat = false

			doNotLoadChatOrBagSettings = doNotLoadChatOrBagSettings or false
			self.TempData.IsCurrentlyLoadingSettings = true
		
			if (self.db.global.printWhenLastSaved == true) then
				self:Printf(L["ACCWUI_LOAD_LASTUPDATED"], LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(self.db.profile.lastSaved.character), LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(date("%Y-%m-%d %H:%M", self.db.profile.lastSaved.unixTime)), self.db:GetCurrentProfile())
			end

		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Loading UI Settings. (" .. self.db:GetCurrentProfile() .. ")")
			end
			
			
			if self:IsMainline() or self:IsClassicTBC() then
				
				self:LoadEditModeSettings()

			end
			
			
			
			-- Use Action Bars
			if (self.db.profile.syncToggles.actionBars == true) then
					
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Action Bars] Loading Settings.")
				end
				
				
				for k, v in pairs(AccWideUIAceAddon.CVars.ActionBars) do
					if (self.db.profile.syncData.actionBars.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.actionBars.cvars[v])
					end
				end
				
				
				if (type(self.db.profile.syncData.actionBars.visible.Bar2) == "boolean") then
				
					self:ScheduleTimer(function() 
				
						if self:IsMainline() or self:IsClassicTBC() then
							
							SetActionBarToggles(self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5, self.db.profile.syncData.actionBars.visible.Bar6, self.db.profile.syncData.actionBars.visible.Bar7, self.db.profile.syncData.actionBars.visible.Bar8)
						
						else
						
							SetActionBarToggles(self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5)
						
						end
					
					end, 4)
				
				end
				
				
				self:ScheduleTimer(function() 
					if (not InCombatLockdown()) then
						securecall(MultiActionBar_Update)
					end
				end, 5)
			
			end 

			
			
			-- Use Raid Frames
			if (self.db.profile.syncToggles.raidFrames == true) then
		
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Raid Frames] Loading Settings.")
				end
				
				for k, v in pairs(self.CVars.RaidFrames) do
					if (self.db.profile.syncData.raidFrames.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.raidFrames.cvars[v])
					end
				end
			
				if (self:IsClassicEra() == true or self:IsClassicProgression() == true) then
				
					--How many Raid Profiles?
					
					local ThisNumRaidProfilesSaved = 0
					local HasSetRaidFramesActive = false
					local NamesOfSavedRaidProfiles = {}
					
					
					if (type(self.db.profile.syncData.raidFrames.profiles) == "table") then
						for key, value in pairs(self.db.profile.syncData.raidFrames.profiles) do 
							ThisNumRaidProfilesSaved = ThisNumRaidProfilesSaved + 1 
							
							if (type(value.name) == "string") then
								table.insert(NamesOfSavedRaidProfiles, value.name)
							end
						end
					end
					
					
					if (ThisNumRaidProfilesSaved > 0) then
					
						--Remove Raid Frame Profiles that we do not have saved.
						for i=GetMaxNumCUFProfiles(), 1, -1 do
							
							local KeepThisProfile = false
							
							local thisProfileName = GetRaidProfileName(i) or nil
							
							for key, value in pairs(NamesOfSavedRaidProfiles) do
								
								if (type(thisProfileName) == "string") then
									if (value == thisProfileName) then
										KeepThisProfile = true
									end
								end
							 
							end
								
							if ((KeepThisProfile == false) and (type(thisProfileName) == "string")) then
								if (self.db.global.printDebugTextToChat == true) then
									self:Print("[Raid Frames] Deleting Old Raid Profile with Name " .. thisProfileName .. ".")
								end
								DeleteRaidProfile(thisProfileName)
							end
						
						end
					
						--Create/Update Raid Profiles
						for i=1, GetMaxNumCUFProfiles() do
								
							if (type(self.db.profile.syncData.raidFrames.profiles[i]) == "table") then
								if (type(self.db.profile.syncData.raidFrames.profiles[i].name) == "string") then
								
									--table.insert(NamesOfSavedRaidProfiles, self.db.profile.syncData.raidFrames.profiles[i].name)

									if (RaidProfileExists(self.db.profile.syncData.raidFrames.profiles[i].name) == false) then
										CreateNewRaidProfile(self.db.profile.syncData.raidFrames.profiles[i].name)
										
										if (self.db.global.printDebugTextToChat == true) then
											self:Print("[Raid Frames] Creating Raid Profile with Name " .. self.db.profile.syncData.raidFrames.profiles[i].name .. ".")
										end
										
									else
										if (self.db.global.printDebugTextToChat == true) then
											self:Print("[Raid Frames] Using Existing Raid Profile with Name " .. self.db.profile.syncData.raidFrames.profiles[i].name .. ".")
										end
									
									end
									
									SetRaidProfileSavedPosition(
										self.db.profile.syncData.raidFrames.profiles[i].name,
										self.db.profile.syncData.raidFrames.profiles[i].position.isDynamic,
										self.db.profile.syncData.raidFrames.profiles[i].position.topPoint,
										self.db.profile.syncData.raidFrames.profiles[i].position.topOffset,
										self.db.profile.syncData.raidFrames.profiles[i].position.bottomPoint,
										self.db.profile.syncData.raidFrames.profiles[i].position.bottomOffset,
										self.db.profile.syncData.raidFrames.profiles[i].position.leftPoint,
										self.db.profile.syncData.raidFrames.profiles[i].position.leftOffset
									)
									
									for k, v in pairs(self.db.profile.syncData.raidFrames.profiles[i].options) do
										SetRaidProfileOption(self.db.profile.syncData.raidFrames.profiles[i].name, tostring(k), v)
									end
											
									if (self.db.profile.syncData.raidFrames.profiles[i].isActive == true) then
										CompactUnitFrameProfiles_ActivateRaidProfile(self.db.profile.syncData.raidFrames.profiles[i].name)
										HasSetRaidFramesActive = true
									end
							
								end
							end
			
						end
						
					end


					--Fallback incase no raid frames profiles are set up.
					if (GetNumRaidProfiles() == 0) then
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Raid Frames] No Raid Profiles found, resetting.")
						end
						CompactUnitFrameProfiles_ResetToDefaults()
						
					end
					
					--Fallback in case none of the profiles are set active for some reason.
					if (HasSetRaidFramesActive == false) then
						CompactUnitFrameProfiles_ActivateRaidProfile(GetRaidProfileName(1))
					end
					

				end

			
			end 
			
			
			
			-- Block Channel Invite Variables
			if (self.db.profile.syncToggles.blockChannelInvites == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Block Channel Invites] Loading Settings.")
				end
							
				for k, v in pairs(self.CVars.BlockChannelInvites) do
					if (self.db.profile.syncData.blockChannelInvites.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.blockChannelInvites.cvars[v])
					end
				end
				
			end
			
			
			-- Block Trade Variables
			if (self.db.profile.syncToggles.blockTrades == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Block Trade Invites] Loading Settings.")
				end
							
				for k, v in pairs(self.CVars.BlockTrades) do
					if (self.db.profile.syncData.blockTrades.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.blockTrades.cvars[v])
					end
				end
				
			end
			
	
			
			-- Block Guild Invite Variables
			if (self.db.profile.syncToggles.blockGuildInvites == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Block Guild Invites] Loading Settings.")
				end
				
				--Special
				if (self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites ~= nil) then
					SetAutoDeclineGuildInvites(self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites)
				end
			
			end 
	
			
			
			
			-- Tutorial Variables
			if (self.db.profile.syncToggles.tutorialTooltips == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Tutorial Tooltip] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.TutorialTooltip) do
					if (self.db.profile.syncData.tutorialTooltips.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.tutorialTooltips.cvars[v])
					end
				end
			end 
			
			-- Auto Loot Variables
			if (self.db.profile.syncToggles.autoLoot == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Auto Loot] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.AutoLoot) do
					if (self.db.profile.syncData.autoLoot.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.autoLoot.cvars[v])
					end
				end
			
			end
			
			
			
			-- Soft Target Variables
			if (self.db.profile.syncToggles.softTarget == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Soft Target] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.SoftTarget) do
					if (self.db.profile.syncData.softTarget.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.softTarget.cvars[v])
					end
				end
			
			end 
			
			-- Battlefield Map Variables
			if (self.db.profile.syncToggles.battlefieldMap == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Zone Map] Loading Settings.")
				end
				
				C_AddOns.LoadAddOn("Blizzard_BattlefieldMap")
				
				for k, v in pairs(self.CVars.BattlefieldMap) do
					if (self.db.profile.syncData.battlefieldMap.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.battlefieldMap.cvars[v])
					end
				end
				
				
				if (self.db.profile.syncData.battlefieldMap.options) then
				
					-- Defaults from https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_BattlefieldMap/Blizzard_BattlefieldMap.lua#L11
					if not BattlefieldMapOptions then
						BattlefieldMapOptions = {
							opacity = 0.7,
							locked = true,
							showPlayers = true
						}
						
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Zone Map] BMOptions did not exist.")
						end
						
					end

					if (type(self.db.profile.syncData.battlefieldMap.options.opacity) == "number") then
						BattlefieldMapOptions.opacity = self.db.profile.syncData.battlefieldMap.options.opacity
					end
					
					if (type(self.db.profile.syncData.battlefieldMap.options.locked) == "boolean") then
						BattlefieldMapOptions.locked = self.db.profile.syncData.battlefieldMap.options.locked
					end
					
					if (type(self.db.profile.syncData.battlefieldMap.options.showPlayers) == "number") then
						BattlefieldMapOptions.showPlayers = self.db.profile.syncData.battlefieldMap.options.showPlayers
					end
					
					
					BattlefieldMapOptions.position = {}
					
					if self.db.global.useScreenSizeSpecificSettings == true then
						
						if (type(self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position) == "table") then
							BattlefieldMapOptions.position.x = self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.x
							BattlefieldMapOptions.position.y = self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.y
						end
					
					else
					
						if (type(self.db.profile.syncData.battlefieldMap.options.position) == "table") then
							BattlefieldMapOptions.position.x = self.db.profile.syncData.battlefieldMap.options.position.x
							BattlefieldMapOptions.position.y = self.db.profile.syncData.battlefieldMap.options.position.y
						end
					
					end
					
				end
				
				
				self:ScheduleTimer(function() 
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Zone Map] Setting Placement etc.")
					end
					
					if (self.db.profile.syncData.battlefieldMap.cvars["showBattlefieldMinimap"] == "1") then
						BattlefieldMapFrame:Show()
					else
						BattlefieldMapFrame:Hide()
					end
					
					--BattlefieldMapTab:ClearAllPoints();
					if self.db.global.useScreenSizeSpecificSettings == true then
					
						if (self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position) then
							if (self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.x and self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.y) then
								
								if (self.db.global.printDebugTextToChat == true) then
									self:Print("[Zone Map] Moving Map (Screen Res).")
								end
							
								BattlefieldMapTab:ClearAllPoints()
								BattlefieldMapTab:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.x, self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.y);
								BattlefieldMapTab:SetUserPlaced(true)
								--ValidateFramePosition(BattlefieldMapTab)
							else
								BattlefieldMapTab:SetUserPlaced(false)
							end
						else
							BattlefieldMapTab:SetUserPlaced(false)
						end
					
					else
						
						if (self.db.profile.syncData.battlefieldMap.options.position) then
							if (self.db.profile.syncData.battlefieldMap.options.position.x and self.db.profile.syncData.battlefieldMap.options.position.y) then
							
								if (self.db.global.printDebugTextToChat == true) then
									self:Print("[Zone Map] Moving Map (Global).")
								end
							
								BattlefieldMapTab:ClearAllPoints()
								BattlefieldMapTab:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", self.db.profile.syncData.battlefieldMap.options.position.x, self.db.profile.syncData.battlefieldMap.options.position.y);
								BattlefieldMapTab:SetUserPlaced(true)
								--ValidateFramePosition(BattlefieldMapTab)
							else
								BattlefieldMapTab:SetUserPlaced(false)
							end
						else
							BattlefieldMapTab:SetUserPlaced(false)
						end
					
					end
					
					
					
					

					BattlefieldMapFrame:RefreshAlpha()
					
					BattlefieldMapFrame:UpdateUnitsVisibility()
					--BattlefieldMapFrame:StopMovingOrSizing()
					
					BattlefieldMapFrame:OnEvent("PLAYER_ENTERING_WORLD")
				
				end, 5)
				
				
			end
						
			
			-- Self Cast Variables
			if (self.db.profile.syncToggles.selfCast == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Self Cast] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.SelfCast) do
					if (self.db.profile.syncData.selfCast.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.selfCast.cvars[v])
					end
				end
			
			end 
			
			
			-- World Map Variables
			if (self.db.profile.syncToggles.worldMap == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[World Map] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.WorldMap) do
					if (self.db.profile.syncData.worldMap.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.worldMap.cvars[v])
					end
				end
			
			end 
			
			
			-- Minimap Variables
			if (self.db.profile.syncToggles.minimap == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Minimap] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.Minimap) do
					if (self.db.profile.syncData.minimap.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.minimap.cvars[v])
					end
				end
				
				if Minimap then
					if IsIndoors and IsIndoors() then
						Minimap:SetZoom(GetCVar("minimapInsideZoom") or GetCVarDefault("minimapInsideZoom"))
					elseif IsOutdoors and IsOutdoors() then
						Minimap:SetZoom(GetCVar("minimapZoom") or GetCVarDefault("minimapZoom"))
					end
				end
			
			end 
			
			
			-- Calendar Filter Variables
			if (self.db.profile.syncToggles.calendarFilters == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Calendar Filters] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.CalendarFilters) do
					if (self.db.profile.syncData.calendarFilters.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.calendarFilters.cvars[v])
					end
				end
			
			end 
			
			
			-- Camera Variables
			if (self.db.profile.syncToggles.camera == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Camera] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.Camera) do
					if (self.db.profile.syncData.camera.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.camera.cvars[v])
					end
				end
			
			end 
			

			
			-- Use Nameplates 
			if (self.db.profile.syncToggles.nameplates == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Nameplates] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.Nameplates) do
					if (self.db.profile.syncData.nameplates.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.nameplates.cvars[v])
					end
				end
				
				if (self:IsMainline() == true) then
					if (self.db.profile.syncData.nameplates.special.NamePlateSize) then
						C_NamePlate.SetNamePlateSize(self.db.profile.syncData.nameplates.special.NamePlateSize[1], self.db.profile.syncData.nameplates.special.NamePlateSize[2])
					end
				else
					if (self.db.profile.syncData.nameplates.special.NamePlateEnemyClickThrough) then
						C_NamePlate.SetNamePlateEnemyClickThrough(self.db.profile.syncData.nameplates.special.NamePlateEnemyClickThrough)
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets) then
						C_NamePlate.SetNamePlateEnemyPreferredClickInsets(self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[4])
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateEnemySize) then
						C_NamePlate.SetNamePlateEnemySize(self.db.profile.syncData.nameplates.special.NamePlateEnemySize[1], self.db.profile.syncData.nameplates.special.NamePlateEnemySize[2])
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateFriendlyClickThrough) then
						C_NamePlate.SetNamePlateFriendlyClickThrough(self.db.profile.syncData.nameplates.special.NamePlateFriendlyClickThrough)
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets) then
						C_NamePlate.SetNamePlateFriendlyPreferredClickInsets(self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[4])
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateFriendlySize) then
						C_NamePlate.SetNamePlateFriendlySize(self.db.profile.syncData.nameplates.special.NamePlateFriendlySize[1], self.db.profile.syncData.nameplates.special.NamePlateFriendlySize[2])
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateSelfClickThrough) then
						C_NamePlate.SetNamePlateSelfClickThrough(self.db.profile.syncData.nameplates.special.NamePlateSelfClickThrough)
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets) then
						C_NamePlate.SetNamePlateSelfPreferredClickInsets(self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[4])
					end
					
					if (self.db.profile.syncData.nameplates.special.NamePlateSelfSize) then
						C_NamePlate.SetNamePlateSelfSize(self.db.profile.syncData.nameplates.special.NamePlateSelfSize[1], self.db.profile.syncData.nameplates.special.NamePlateSelfSize[2])
					end
				end
				
			end
			

			
			
			-- Misc. Combat Variables
			if (self.db.profile.syncToggles.combatMisc == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Misc. Combat] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.CombatMisc) do
					if (self.db.profile.syncData.combatMisc.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.combatMisc.cvars[v])
					end
				end
			
			end 
			
			
			-- Misc. UI Variables
			if (self.db.profile.syncToggles.combatMisc == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Misc. UI] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.UIMisc) do
					if (self.db.profile.syncData.uiMisc.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.uiMisc.cvars[v])
					end
				end
			
			end 
			
			
			
			-- Custom CVars
			if (self.db.global.allowCustomCVars == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Custom CVars] Loading Settings.")
				end
			
				for line in self.db.profile.syncData.customCVars.cvarList:gmatch("([^\n]*)\n?") do
					line = line:gsub("[^%w]+", "")
					if (line ~= "" and GetCVar(line) ~= nil and self.db.profile.syncData.customCVars.cvarData[line] ~= nil) then
						SetCVar(line, self.db.profile.syncData.customCVars.cvarData[line])
					end
				end
			
			end 
			
			
			-- RETAIL and TBC Only Settings
			if (self:IsMainline() == true or self:IsClassicTBC() == true) then
			
				-- Loss of Control Variables
				if (self.db.profile.syncToggles.lossOfControl == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Loss of Control] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.LossOfControl) do
						if (self.db.profile.syncData.lossOfControl.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.lossOfControl.cvars[v])
						end
					end
				
				end

			
			end
			
			
			-- RETAIL Only settings
			if (self:IsMainline() == true) then
				
				-- Block Neighborhood Invite
				if (self.db.profile.syncToggles.blockNeighborhoodInvites == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Block Neighborhood Invites] Loading Settings.")
					end
					
					--Special
					if (self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites ~= nil) then
						SetAutoDeclineNeighborhoodInvites(self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites)
					end
				
				end 
				
				-- External Defensives Variables
				if (self.db.profile.syncToggles.externalDefensives == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[External Defensives] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.ExternalDefensives) do
						if (self.db.profile.syncData.externalDefensives.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.externalDefensives.cvars[v])
						end
					end
				
				end 
			
				-- Mouseover Cast Variables
				if (self.db.profile.syncToggles.mouseoverCast == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Mouseover Cast] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.MouseoverCast) do
						if (self.db.profile.syncData.mouseoverCast.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.mouseoverCast.cvars[v])
						end
					end
				
				end 
		
				-- Empowered Tap/Hold Variables
				if (self.db.profile.syncToggles.empowerTap == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Empowered Tap/Hold] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.EmpowerTap) do
						if (self.db.profile.syncData.empowerTap.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.empowerTap.cvars[v])
						end
					end
				
				end 
				
				-- Assisted Highlight Variables
				if (self.db.profile.syncToggles.assistedCombat == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Assisted Highlight] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.AssistedCombat) do
						if (self.db.profile.syncData.assistedCombat.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.assistedCombat.cvars[v])
						end
					end
				
				end 
				

				-- Cooldown Manager Variables
				if (self.db.profile.syncToggles.cooldownViewer == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Cooldown Manager] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.CooldownViewer) do
						if (self.db.profile.syncData.cooldownViewer.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.cooldownViewer.cvars[v])
						end
					end
					
					--[[if (self:IsMainline() == true) then
						local thisClass = UnitClassBase("player")
						if (C_CooldownViewer.IsCooldownViewerAvailable() and self.db.profile.syncData.cooldownViewer.classes[thisClass]) then
							if (self.db.global.printDebugTextToChat == true) then
								self:Print("[Cooldown Manager] Loading CD Viewer String.")
							end
							C_CooldownViewer.SetLayoutData(self.db.profile.syncData.cooldownViewer.classes[thisClass])
							--CooldownViewerSettings:GetSerializer():SetSerializedData(self.db.profile.syncData.cooldownViewer.classes[thisClass])
							--CooldownViewerSettings:GetSerializer():SetSerializedData:WriteData()
							CooldownViewerSettings:CheckSaveCurrentLayout()
							EssentialCooldownViewer:RefreshData()
							EssentialCooldownViewer:RefreshLayout()
							UtilityCooldownViewer:RefreshData()
							UtilityCooldownViewer:RefreshLayout()
						end
					end]]
				
				end
				
				
				
				-- Location Visibility Variables
				if (self.db.profile.syncToggles.locationVisibility == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Location Visibility] Loading Settings.")
					end

					--Special
					if (self.db.profile.syncData.locationVisibility.special.allowRecentAlliesSeeLocation ~= nil) then
						SetAllowRecentAlliesSeeLocation(self.db.profile.syncData.locationVisibility.special.allowRecentAlliesSeeLocation)
					end
				
				end 
				
				
				-- Bag Organisation Settings
				if (self.db.global.allowExperimentalSyncs == true) then
					if (self.db.profile.syncToggles.bagOrganisation == true and doNotLoadChatOrBagSettings == false) then
					
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Bags] Loading Settings.")
						end
						
						
						local extraTimer = 1
						local extraTimerAdd = 0.7
						
						self:ScheduleTimer(function() 
						
							C_Container.SetSortBagsRightToLeft(self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft)
							C_Container.SetInsertItemsLeftToRight(self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight)
							
							C_Container.SetBackpackAutosortDisabled(self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled)
							C_Container.SetBackpackSellJunkDisabled(self.db.profile.syncData.bagOrganisation.settings.backpackSellJunkDisabled)
							
							C_Container.SetBankAutosortDisabled(self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled)
							
							
							for bagName, bagId in pairs(Enum.BagIndex) do
							
								if (string.find(string.lower(bagName), "bank") == nil) then 
									
									if (type(self.db.profile.syncData.bagOrganisation.bags[bagName]) == "table") then	

										for k, v in pairs(Enum.BagSlotFlags) do
											if (type(self.db.profile.syncData.bagOrganisation.bags[bagName][tostring(k)]) == "boolean") then
											
												self:ScheduleTimer(function() 
												
													if (self.db.global.printDebugTextToChat == true) then
														self:Print("[Bags] Setting " .. k .. " to " .. tostring(self.db.profile.syncData.bagOrganisation.bags[bagName][tostring(k)]) .. " for " .. bagName .. ".")
														--print("C_Container.SetBagSlotFlag(" .. bagId .. ", " .. Enum.BagSlotFlags[tostring(k)] .. ", " .. tostring(self:ToBoolean(self.db.profile.syncData.bagOrganisation.bags[bagName][tostring(k)])) .. ")")
													end
												
													C_Container.SetBagSlotFlag(bagId, Enum.BagSlotFlags[tostring(k)], self.db.profile.syncData.bagOrganisation.bags[bagName][tostring(k)])
													
													ContainerFrameSettingsManager:SetFilterFlag(bagId, Enum.BagSlotFlags[tostring(k)], self.db.profile.syncData.bagOrganisation.bags[bagName][tostring(k)]);
												
												end, extraTimer)
												
												extraTimer = extraTimer + extraTimerAdd
												
											end
										end

									end
								
								end
							
							end
							
						end, 4)
						
					
					end
				end
	
			
			end
			
			
			
			
			--  Midnight only settings
			if (self:IsMainline() == true) then
			
				-- Use Damage Meter Setting
				if (self.db.profile.syncToggles.damageMeter == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Damage Meter] Loading Settings.")
					end
					
					for k, v in pairs(self.CVars.DamageMeter) do
						if (self.db.profile.syncData.damageMeter.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.damageMeter.cvars[v])
						end
					end
					
					--[[if (self.db.profile.syncData.damageMeter.special.settings) then
					
						if next(self.db.profile.syncData.damageMeter.special.settings) then
					
							--DamageMeterPerCharacterSettings = CopyTable(self.db.profile.syncData.damageMeter.special.settings)
							
							--DamageMeter:LoadSavedWindowDataList()
							
							
							-- Create Windows
							for i = 1, DamageMeter:GetMaxSessionWindowCount() do 
								DamageMeter:ShowNewSessionWindow()
							end
							
							
							for i = 1, DamageMeter:GetMaxSessionWindowCount() do 
								local thisDamageMeter = DamageMeter:GetSessionWindow(i) -- DamageMeterSessionWindow1 / 2 / 3
								
								if (thisDamageMeter) then
									--Hide Windows we don't need
									if (self.db.profile.syncData.damageMeter.special.settings.windowDataList[i]) then
									
										if (DamageMeter:CanHideSessionWindow(thisDamageMeter)) then
											if (self.db.profile.syncData.damageMeter.special.settings.windowDataList[i].shown == true) then
												thisDamageMeter:Show()
											else
												DamageMeter:HideSessionWindow(thisDamageMeter) --thisDamageMeter:Hide()
											end
										end
										
									else
										--Hide if we have no saved info
										if (DamageMeter:CanHideSessionWindow(thisDamageMeter)) then
											DamageMeter:HideSessionWindow(thisDamageMeter) --thisDamageMeter:Hide()
										end
									end
								
								end
								
								self:ScheduleTimer(function() 
								
									local thisDamageMeter = DamageMeter:GetSessionWindow(i) 
									
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Damage Meter] Check WDL for DM " .. i)
									end
								
									if (thisDamageMeter and self.db.profile.syncData.damageMeter.special.settings.windowDataList[i]) then
									
										if (self.db.global.printDebugTextToChat == true) then
											self:Print("[Damage Meter] WDL for DM " .. i)
										end
									
										--thisDamageMeter:SetDamageMeterType(self.db.profile.syncData.damageMeter.special.settings.windowDataList[i].damageMeterType)
										--DamageMeter:SetSessionWindowDamageMeterType(thisDamageMeter, self.db.profile.syncData.damageMeter.special.settings.windowDataList[i].damageMeterType)
										
										--thisDamageMeter:SetLocked(self.db.profile.syncData.damageMeter.special.settings.windowDataList[i].locked)
										--DamageMeter:SetSessionWindowLocked(thisDamageMeter, self.db.profile.syncData.damageMeter.special.settings.windowDataList[i].locked)
										
										if (DamageMeter:CanMoveOrResizeSessionWindow(thisDamageMeter)) then
										
											self:ScheduleTimer(function() 
												if (self.db.profile.syncData.damageMeter.special.size[i]) then -- First window is set via Edit Mode
												
													if (self.db.global.printDebugTextToChat == true) then
														self:Print("[Damage Meter] Set Size for DM " .. i)
													end
												
													thisDamageMeter:SetSize(
														self.db.profile.syncData.damageMeter.special.size[i].x,
														self.db.profile.syncData.damageMeter.special.size[i].y
													)
												end
											end, 0.3)
											
											
											self:ScheduleTimer(function() 
												if (self.db.profile.syncData.damageMeter.special.position[i]) then -- First window is set via Edit Mode
												
													if (self.db.global.printDebugTextToChat == true) then
														self:Print("[Damage Meter] Set Position for DM " .. i)
													end
												
													thisDamageMeter:ClearAllPoints()
													thisDamageMeter:SetPoint(
														self.db.profile.syncData.damageMeter.special.position[i].point,
														UIParent,
														self.db.profile.syncData.damageMeter.special.position[i].relativePoint,
														self.db.profile.syncData.damageMeter.special.position[i].offsetX,
														self.db.profile.syncData.damageMeter.special.position[i].offsetY
													)
												end
											end, 0.6)
										
										end
										
									end
								
								end, 0.3)
								
							end
						
						end
						
					end]]
				
				end
			
			end
			
			
		
			
			-- NOT CLASSIC ERA Only settings
			if (self:IsClassicEra() == false) then

				-- Spell Overlay Variables
				if (self.db.profile.syncToggles.spellOverlay == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Spell Overlay] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.SpellOverlay) do
						if (self.db.profile.syncData.spellOverlay.cvars ~= nil) then
							SetCVar(v, self.db.profile.syncData.spellOverlay.cvars[v])
						end
					end
					
				end
				
			end
			
			
			
			-- NOT Vanilla Only settings
			if (self:IsClassicVanilla() == false) then
			
				-- Use Arena Frames
				if (self.db.profile.syncToggles.arenaFrames == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Arena Frames] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.ArenaFrames) do
						if (self.db.profile.syncData.arenaFrames.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.arenaFrames.cvars[v])
						end
					end
				
				end 
				
			end
		
		
		
			-- Chat Window Settings
			if (self.db.profile.syncToggles.chatWindow == true and doNotLoadChatOrBagSettings == false) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Chat Window] Loading Settings.")
				end
				
				if (self.db.profile.syncToggles.chatChannels == true) then
				
					self:ScheduleTimer(function() 
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Chat Window] Joining Channels.")
						end
						
						AccWideUIAceAddon:BlizzChannelManager()
						
						-- Chat Channels
						for k, v in pairs(self.db.profile.syncData.chat.channelsJoined) do
							JoinChannelByName(v)
						end
					end, 10)
					
					
					
					self:ScheduleTimer(function() 
					
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Chat Window] Reordering Channels.")
						end
						--Reorder Chat Channels
						for k, v in pairs(self.db.profile.syncData.chat.channelsJoined) do
							
							local id, name, instanceID, isCommunitiesChannel = GetChannelName(v)
							
							if (id ~= k) then
								-- Move Channel
								C_ChatInfo.SwapChatChannelsByChannelIndex(id, k)
							end
							
						end
					end, 14)
					
	
					
					self:ScheduleTimer(function() 
						if (self.db.global.printDebugTextToChat == true) then
							self:Print("[Chat Window] Setting Channel Colors.")
						end
						-- Chat Colours
						for k, v in pairs(self.CVars.ChatTypes) do
							if (type(ChatTypeInfo[v]) == "table" and type(self.db.profile.syncData.chat.info[v]) == "table") then
								if (type(self.db.profile.syncData.chat.info[v][1]) == "table") then
									ChangeChatColor(v, self.db.profile.syncData.chat.info[v][1].r, self.db.profile.syncData.chat.info[v][1].g, self.db.profile.syncData.chat.info[v][1].b)
									
									SetChatColorNameByClass(v, self.db.profile.syncData.chat.info[v][1].colorNameByClass)
								end
							end
						end
					end, 16)
					
					
					-- Newcomer Chat Exception
					if (self:IsMainline() and self.chatChannelNames.newcomerChat) then
						self:ScheduleTimer(function()
						
							if (self.db.global.printDebugTextToChat == true) then
								self:Print("[Chat Window] Setting Newcomer Chat Settings.")
							end
							
							if (self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelIndex) then
								local id, name, instanceID, isCommunitiesChannel = GetChannelName(self.chatChannelNames.newcomerChat)
								
								if (id ~= self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelIndex) then
									-- Move Channel
									C_ChatInfo.SwapChatChannelsByChannelIndex(id, self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelIndex)
								end
								
								if (self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelColor.r) then
									local v = "CHANNEL" .. self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelIndex
									ChangeChatColor(v, self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelColor.r, self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelColor.g, self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelColor.b)
									SetChatColorNameByClass(v, self.db.profile.syncData.chat.channelSpecial.newcomerChat.channelColorByClass)
								end
							end
						
						end, 20)
					end
				
				
				end
				
				
				
				
				-- Individual Chat Window/Tab Settings
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do -- 12.0.0 Constants.ChatFrameConstants.MaxChatWindows
					
					--local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					local thisChatFrameVar = FCF_GetChatFrameByID(thisChatFrame);
					local thisChatFrameTab =  _G["ChatFrame"..thisChatFrame.."Tab"];
					
					
					if (type(self.db.profile.syncData.chat.windows[thisChatFrame]) == "table") then
					
						if(type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo) == "table") then
												
	
							self:ScheduleTimer(function()
								if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.a) then
								
									SetChatWindowAlpha(
										thisChatFrame, 
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.a
									)
									
									--[[ FCF_SetWindowAlpha(
											thisChatFrameVar, 
											self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.a
									) ]]
								
								end
								
								if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.r) then
								
									SetChatWindowColor(
										thisChatFrame,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.r,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.g,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.b
									)
									
									--[[ FCF_SetWindowColor(
										thisChatFrameVar,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.r,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.g,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.b
									) ]]
								
								end
								
								SetChatWindowDocked(
									thisChatFrame,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked or false)
								)
								
								--[[ if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked and self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked == true) then
									FCF_DockFrame(
										thisChatFrameVar,
										(#FCFDock_GetChatFrames(GENERAL_CHAT_DOCK)+1),
										(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked or false)
									)
								else
									FCF_UnDockFrame(
										thisChatFrameVar
									)
								end ]]
								
								SetChatWindowLocked(
									thisChatFrame,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isLocked or false)
								)
								
								--[[ FCF_SetLocked(
									thisChatFrameVar,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isLocked or false)
								) ]]
								
								SetChatWindowShown(
									thisChatFrame,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown or false)
								)
								
								--[[ if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown == true) then
									thisChatFrameVar:Show()
								else
									thisChatFrameVar:Hide()
								end ]]
								
								
								SetChatWindowUninteractable(
									thisChatFrame,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
								)
								
								--[[ FCF_SetUninteractable(
									thisChatFrameVar,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
								) ]]
								
								SetChatWindowName(
									thisChatFrame,
									self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.name
								)
								
								--[[ FCF_SetWindowName(
									thisChatFrameVar,
									self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.name
								) ]] 
								
								if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.size and self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.size >= 10) then
								
									SetChatWindowSize(
										thisChatFrame,
										self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.size
									)
									
									if (self:IsMainline()) then
										FCF_SetChatWindowFontSize(
											nil,
											thisChatFrameVar,
											self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.size
										)
									end
								
								else
								
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Chat Window] Invalid Chat Text Size.")
									end
								
								end
							
							end, 2)
							
						end
						
							
						
						self:ScheduleTimer(function()
							if (self.db.profile.syncToggles.chatWindowPosition == true) then
							
									if self.db.global.useScreenSizeSpecificSettings == true then
										--Res Specific
										if (type(self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions)  ~= "nil") then
											if (type(self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions.xOffset) ~= "nil") then
												SetChatWindowSavedPosition(
													thisChatFrame,
													self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions.point,
													self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions.xOffset,
													self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions.yOffset
												)
											end
										end
										
										if (type(self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Dimensions) ~= "nil") then
											if (type(self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Dimensions.width) ~= "nil") then
												SetChatWindowSavedDimensions(
													thisChatFrame,
													self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Dimensions.width,
													self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Dimensions.height
												)
											end
										end
										
									else
									
										--Global
										if (type(self.db.profile.syncData.chat.windows[thisChatFrame].Positions)  ~= "nil") then
											if (type(self.db.profile.syncData.chat.windows[thisChatFrame].Positions.xOffset) ~= "nil") then
												SetChatWindowSavedPosition(
													thisChatFrame,
													self.db.profile.syncData.chat.windows[thisChatFrame].Positions.point,
													self.db.profile.syncData.chat.windows[thisChatFrame].Positions.xOffset,
													self.db.profile.syncData.chat.windows[thisChatFrame].Positions.yOffset
												)
											end
										end
										
										if (type(self.db.profile.syncData.chat.windows[thisChatFrame].Dimensions)  ~= "nil") then
											if (type(self.db.profile.syncData.chat.windows[thisChatFrame].Dimensions.width) ~= "nil") then
												SetChatWindowSavedDimensions(
													thisChatFrame,
													self.db.profile.syncData.chat.windows[thisChatFrame].Dimensions.width,
													self.db.profile.syncData.chat.windows[thisChatFrame].Dimensions.height
												)
											end
										end
									
									end
								
							
					
								--FCF_RestorePositionAndDimensions(thisChatFrameVar)
							end
						end, 3)

						self:ScheduleTimer(function()
							FloatingChatFrame_Update(thisChatFrame, true)
							
							--[[if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked) then
								FCF_UnDockFrame(thisChatFrameVar)
								FCF_DockFrame(thisChatFrameVar, self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked, thisChatFrame)
							end]]
							
							if (not self:IsMainline()) then
								--Triggering this in Retail causes secret errors when chat lockdown is enabled
								local f = _G["ChatFrame" .. thisChatFrame];
								f:GetScript("OnEvent")(f, "UPDATE_CHAT_WINDOWS");
							
							end
							
						end, 4)
					
					
					end
					
					self:ScheduleTimer(function()
					
						if (C_AddOns.IsAddOnLoaded("ElvUI") == true) then
							-- Redock chat windows in ElvUI if panel docking is enabled
							local E, L, V, P, G = unpack(ElvUI);
							local CH = E:GetModule('Chat');
							
							if (CH.LeftChatWindow ~= nil) then
								CH:PositionChat(CH.LeftChatWindow);
							end
							
							if (CH.RightChatWindow ~= nil) then
								CH:PositionChat(CH.RightChatWindow);
							end
							
						end
						
					end, 5)
					
					
					
					--Visible Chat Channels
					self:ScheduleTimer(function() 
					
						-- TEMP DISABLED FOR RETAIL DUE TO CAUSING TAINT IN INSTANCES (WTF?!) 12.0.0
						if (not self:IsMainline()) then
					
							if (self.db.profile.syncData.chat.windows[thisChatFrame]) then
								if (type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible) == "table") then
								
									local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
									
									if thisWindowChannels then
						
										for i = 1, #thisWindowChannels, 2 do
											local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
											
											if (self.db.global.printDebugTextToChat == true) then
												self:Print("[Chat Window] Removing " .. chn .. " From Window " .. thisChatFrame .. ".")
											end

											if thisChatFrameVar.RemoveChannel then
												thisChatFrameVar:RemoveChannel(chn) -- 12.0.0
											else
												ChatFrame_RemoveChannel(thisChatFrameVar, chn)
											end
											
										end
									
									end
								
									for k,v in pairs(self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible) do
									
										if (self.db.global.printDebugTextToChat == true) then
											self:Print("[Chat Window] Adding " .. v .. " To Window " .. thisChatFrame .. ".")
										end
											
										if thisChatFrameVar.AddChannel then
											thisChatFrameVar:AddChannel(v) -- 12.0.0
										else
											ChatFrame_AddChannel(thisChatFrameVar, v)
										end
																												
									end
								end
							end
							
						end -- EO Not Retail

					end, (22 + (thisChatFrame * 2)))
					
					
					
					-- Types of Chat
					self:ScheduleTimer(function() 
					
						if (self.db.profile.syncData.chat.windows[thisChatFrame]) then
					
							if (type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo) == "table") then
							
								if ((self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown == true) or (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked)) then
							
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Chat Window] Setting Chat Types for Window " .. thisChatFrame .. ".")
									end
								
									if (type(self.db.profile.syncData.chat.windows[thisChatFrame].MessageTypes) == "table") then
									
										if (ChatFrame_RemoveAllMessageGroups) then
											ChatFrame_RemoveAllMessageGroups(thisChatFrameVar)
										else
											thisChatFrameVar:RemoveAllMessageGroups() -- 12.0.0
										end
										


										for k,v in pairs(self.db.profile.syncData.chat.windows[thisChatFrame].MessageTypes) do
										
											if (ChatFrame_AddMessageGroup) then
												ChatFrame_AddMessageGroup(thisChatFrameVar, v)
											else
												thisChatFrameVar:AddMessageGroup(v) -- 12.0.0 
											end


											if (self.db.global.printDebugTextToChat == true) then
												self:Print("[Chat Window] Adding " .. v .. " to Window " .. thisChatFrame .. ".")
											end
										end
									
									end
								
								end
							
							end
						
						end
						
					end, (25 + (thisChatFrame * 2)))
				
					
				end
				
				
			
				self:ScheduleTimer(function()
				
					--Fix for Leatrix Plus where Hide Combat Log is Enabled
					if (C_AddOns.IsAddOnLoaded("Leatrix_Plus") == true) then
						if (LeaPlusDB and LeaPlusDB.NoCombatLogTab == "On") then
							if ChatFrame2.isDocked then
								ChatFrame2Tab:SetText(" ")
								FCF_DockUpdate()
								if (self.db.global.printDebugTextToChat == true) then
									self:Print("[Leatrix Plus] Combat Log Tab is Hidden, fixing text.")
								end
							end
						end
					end
				
					
				end, 5)
				
			
			else
			
				LoadUIAllowSaveTime = 15
				
			end
			
			
			if (self.db.profile.syncToggles.bagOrganisation == true) then
				LoadUIAllowSaveTime = 65
			end
			
			
			self:ScheduleTimer(function()
				self.TempData.IsCurrentlyLoadingSettings = false
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Debug] Settings can now be saved.")
				end
			end, LoadUIAllowSaveTime)
			
		end
	
	end
	
end




function AccWideUIAceAddon:LoadEditModeSettings()
	
	if ((self:IsMainline() or self:IsClassicTBC()) and not InCombatLockdown() and self.db.global.hasDoneFirstTimeSetup == true and type(self.db.profile.syncData.editModeLayoutID) == "number") then
				
		-- Use Edit Mode Layout
		local currentSpec = tostring(C_SpecializationInfo.GetSpecialization())
		
		if (self.db.profile.syncToggles.editModeLayout == true) and (self.db.char.useEditModeLayout["specialization" .. currentSpec] == true) then
		
			local thisEditModeLayoutID = self.db.profile.syncData.editModeLayoutID or 1
			
			if self.db.global.useScreenSizeSpecificSettings == true then
				
				if (self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].editModeLayoutID ~= "unset") then
				
					thisEditModeLayoutID = self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].editModeLayoutID or thisEditModeLayoutID
					
				end
			
				
			end

			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Loading Chosen Edit Mode Layout (ID: " .. thisEditModeLayoutID .. ").")
			end

			--Set the spec
			C_EditMode.SetActiveLayout(thisEditModeLayoutID)
	
		end
	
	end

end


function AccWideUIAceAddon:ForceLoadSettings() 
	if (not InCombatLockdown() and not IsEncounterInProgress()) then
		if (C_AddOns.IsAddOnLoaded("EditModeExpanded") == true and not self.TempData.EditModeExpandedTriggered) then
			 self.TempData.EditModeExpandedTriggered = true
		end
		self:CancelAllTimers(); 
		self:Print(L["ACCWUI_DEBUG_TXT_FORCELOAD"]);
		self:LoadUISettings();
	else
		self:Print(L["ACCWUI_WAIT_TILL_COMBAT"])
		self.TempData.LoadSettingsAfterCombat = true
	end
end