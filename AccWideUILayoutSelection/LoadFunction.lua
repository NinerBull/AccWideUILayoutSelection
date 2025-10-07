local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:LoadUISettings(doNotLoadChatOrBagSettings)

	local LoadUIAllowSaveTime = 36
	
	if (self.db.global.hasDoneFirstTimeSetup == true) then
	
		self:CancelAllTimers()

		doNotLoadChatOrBagSettings = doNotLoadChatOrBagSettings or false
		self.TempData.IsCurrentlyLoadingSettings = true
		
			if (self.db.global.printWhenLastSaved == true) then
				self:Printf(L["ACCWUI_LOAD_LASTUPDATED"], LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(self.db.profile.lastSaved.character), LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(date("%Y-%m-%d %H:%M", self.db.profile.lastSaved.unixTime)), self.db:GetCurrentProfile())
			end

		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Loading UI Settings. (" .. self.db:GetCurrentProfile() .. ")")
			end
			
			
			if self:IsMainline() then
				
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
				
						if self:IsMainline() then
							
							SetActionBarToggles(self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5, self.db.profile.syncData.actionBars.visible.Bar6, self.db.profile.syncData.actionBars.visible.Bar7, self.db.profile.syncData.actionBars.visible.Bar8)
						
						else
						
							SetActionBarToggles(self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5)
						
						end
					
					end, 4)
				
				end
				
				
				self:ScheduleTimer(function() 
					MultiActionBar_Update()
				end, 5)
			
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
			
			end 
			
			
			
			-- Use Raid Frames
			if (self.db.profile.syncToggles.raidFrames == true) then
		
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Raid Frames] Loading Settings.")
				end
				
				for k, v in pairs(self.CVars.RaidFrames) do
					if (self.db.profile.syncData.nameplates.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.nameplates.cvars[v])
					end
				end
			
				if (self:IsMainline() == false) then
				
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
			
			
			
			
			
			-- Block Social Variables
			if (self.db.profile.syncToggles.blockSocial == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Social] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.BlockSocial) do
					if (self.db.profile.syncData.blockSocial.cvars[v] ~= nil) then
						SetCVar(v, self.db.profile.syncData.blockSocial.cvars[v])
					end
				end
				
				
				--Special
				if (self.db.profile.syncData.blockSocial.special.blockGuildInvites ~= nil) then
					SetAutoDeclineGuildInvites(self.db.profile.syncData.blockSocial.special.blockGuildInvites)
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
			
			
			
				
			
			
			-- Mouseover/Self Cast Variables
			if (self.db.profile.syncToggles.mouseoverCast == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Mouseover/Self Cast] Loading Settings.")
				end
			
				for k, v in pairs(self.CVars.MouseoverCast) do
					SetCVar(v, self.db.profile.syncData.mouseoverCast.cvars[v])
				end
			
			end 
			
			
			-- Custom CVars
			if (self.db.global.allowCustomCVars == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Custom CVars] Loading Settings.")
				end
			
				for line in self.db.profile.syncData.customCVars.cvarList:gmatch("([^\n]*)\n?") do
					line = line:gsub("[^%w]+", "")
					if (line ~= "" and GetCVar(line) ~= nil) then
						SetCVar(line, self.db.profile.syncData.customCVars.cvarData[line])
					end
				end
			
			end 
			
			
			
			
			-- RETAIL Only settings
			if self:IsMainline() then
		
				-- Empowered Tap/Hold Variables
				if (self.db.profile.syncToggles.empowerTap == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Empowered Tap/Hold] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.EmpowerTap) do
						SetCVar(v, self.db.profile.syncData.empowerTap.cvars[v])
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
				
				
			
				-- Cooldown Viewer Variables
				if (self.db.profile.syncToggles.cooldownViewer == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Cooldown Viewer] Loading Settings.")
					end
				
					for k, v in pairs(self.CVars.CooldownViewer) do
						if (self.db.profile.syncData.cooldownViewer.cvars[v] ~= nil) then
							SetCVar(v, self.db.profile.syncData.cooldownViewer.cvars[v])
						end
					end
				
				end
			
			
			end
			

			
			-- NOT CLASSIC ERA Only settings
			if (self:IsClassicEra() == false) then
			
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
				
				
				end
				
				
				
				
				-- Individual Chat Window/Tab Settings
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do -- 12.0.0 Constants.ChatFrameConstants.MaxChatWindows
					
					--local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					local thisChatFrameVar = FCF_GetChatFrameByID(thisChatFrame);
					
					
					if (type(self.db.profile.syncData.chat.windows[thisChatFrame]) == "table") then
					
						if(type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo) == "table") then
					
							--[[FCF_SetWindowAlpha(
								thisChatFrameVar, 
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.a
							)]]
							
							SetChatWindowAlpha(
								thisChatFrame, 
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.a
							)
							
							--[[FCF_SetWindowColor(
								thisChatFrameVar,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.r,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.g,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.b
							)]]
							
							SetChatWindowColor(
								thisChatFrame,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.r,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.g,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.b
							)
							
							--[[if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked) then
								FCF_DockFrame(
									thisChatFrameVar,
									(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked or false)
								)
							else
								FCF_UnDockFrame(
									thisChatFrameVar
								)
							end]]
							
							SetChatWindowDocked(
								thisChatFrame,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked or false)
							)
							
							--[[FCF_SetLocked(
								thisChatFrameVar,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isLocked or false)
							)]]
							
							SetChatWindowLocked(
								thisChatFrame,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isLocked or false)
							)
							
							SetChatWindowShown(
								thisChatFrame,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown or false)
							)
							
							--[[if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown == true) then
								thisChatFrameVar:Show()
							else
								thisChatFrameVar:Hide()
							end]]
							
							SetChatWindowUninteractable(
								thisChatFrame,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
							)
							
							--[[FCF_SetUninteractable(
								thisChatFrameVar,
								(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
							)]]
							
							SetChatWindowName(
								thisChatFrame,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.name
							)
							
							--[[FCF_SetWindowName(
								thisChatFrameVar,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.name
							)]]
							
							SetChatWindowSize(
								thisChatFrame,
								self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.size
							)
						
						
						end
						
							
						
						
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
						

						self:ScheduleTimer(function()
							FloatingChatFrame_Update(thisChatFrame, true)
							
							--[[if (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked) then
								FCF_UnDockFrame(thisChatFrameVar)
								FCF_DockFrame(thisChatFrameVar, self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked, thisChatFrame)
							end]]
							
							local f = _G["ChatFrame" .. thisChatFrame];
							f:GetScript("OnEvent")(f, "UPDATE_CHAT_WINDOWS");
							
						end, 1)
					
					
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
						
					end, 4)
					
					
					
					--Visible Chat Channels
					self:ScheduleTimer(function() 
					
						if (self.db.profile.syncData.chat.windows[thisChatFrame]) then
							if (type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible) == "table") then
							
								local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
					
								for i = 1, #thisWindowChannels, 2 do
									local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
									
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Chat Window] Removing " .. chn .. " From Window " .. thisChatFrame .. ".")
									end
									
									ChatFrame_RemoveChannel(thisChatFrameVar, chn) -- 12.0.0 ChatFrameMixin.RemoveChannel
								end
							
								for k,v in pairs(self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible) do
								
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Chat Window] Adding " .. v .. " To Window " .. thisChatFrame .. ".")
									end
									
									ChatFrame_AddChannel(thisChatFrameVar, v) -- 12.0.0 ChatFrameMixin.AddChannel
									
								end
							end
						end

					end, (20 + (thisChatFrame * 2)))
					
					
					
					-- Types of Chat
					self:ScheduleTimer(function() 
					
						if (self.db.profile.syncData.chat.windows[thisChatFrame]) then
					
							if (type(self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo) == "table") then
							
								if ((self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isShown == true) or (self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo.isDocked)) then
							
									if (self.db.global.printDebugTextToChat == true) then
										self:Print("[Chat Window] Setting Chat Types for Window " .. thisChatFrame .. ".")
									end
								
									if (type(self.db.profile.syncData.chat.windows[thisChatFrame].MessageTypes) == "table") then
										ChatFrame_RemoveAllMessageGroups(thisChatFrameVar) -- 12.0.0 ChatFrameMixin.RemoveAllMessageGroups
										
										for k,v in pairs(self.db.profile.syncData.chat.windows[thisChatFrame].MessageTypes) do
											 ChatFrame_AddMessageGroup(thisChatFrameVar, v) -- 12.0.0 ChatFrameMixin.AddMessageGroup
											 if (self.db.global.printDebugTextToChat == true) then
												self:Print("[Chat Window] Adding " .. v .. " to Window " .. thisChatFrame .. ".")
											 end
										end
									
									end
								
								end
							
							end
						
						end
						
					end, (22 + (thisChatFrame * 2)))
				
					
				end
			
				self:ScheduleTimer(function()
					FCF_DockUpdate()
				end, 2)
				
			
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




function AccWideUIAceAddon:LoadEditModeSettings()
	
	if (self:IsMainline() and self.db.global.hasDoneFirstTimeSetup == true and type(self.db.profile.syncData.editModeLayoutID) == "number") then
				
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
	self:CancelAllTimers(); 
	self:Print(L["ACCWUI_DEBUG_TXT_FORCELOAD"]);
	self:LoadUISettings();
end