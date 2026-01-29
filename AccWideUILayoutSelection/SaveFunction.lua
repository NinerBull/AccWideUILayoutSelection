local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:SaveUISettings(doNotSaveEditMode, isForced)

	doNotSaveEditMode = doNotSaveEditMode or false
	isForced = isForced or false
	

	if self.TempData.IsCurrentlyLoadingSettings == true then
	
		if (self.db.global.printDebugTextToChat == true) then
			self:Print("[Debug] Not saving UI Settings while settings are still loading.")
		end
	
	else
		
		if (InCombatLockdown()) then
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Not saving UI Settings while in combat.")
			end
			
		else
		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Saving UI Settings. (" .. self.db:GetCurrentProfile() .. ")")
			end
			
			self.db.global.hasDoneFirstTimeSetup = true


			self.db.profile.lastSaved.character = AccWideUIAceAddon.TempData.ThisCharacter
			self.db.profile.lastSaved.unixTime = GetServerTime()
			
			if ((self:IsMainline() or self:IsClassicTBC()) and doNotSaveEditMode == false) then
				self:SaveEditModeSettings()
			end
			
		
			--Save Shown Action Bars
			if (self.db.profile.syncToggles.actionBars == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Action Bar] Saving Settings.")
				end
				
				for k, v in pairs(self.CVars.ActionBars) do
					self.db.profile.syncData.actionBars.cvars[v] = GetCVar(v) or nil
				end

					if self:IsMainline() or self:IsClassicTBC() then
						self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5, self.db.profile.syncData.actionBars.visible.Bar6, self.db.profile.syncData.actionBars.visible.Bar7, self.db.profile.syncData.actionBars.visible.Bar8 = GetActionBarToggles()
					else
						self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5 = GetActionBarToggles()
					end

			end
			
			
			-- Save Raid Frames
			if (self.db.profile.syncToggles.raidFrames == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Raid Frames] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.RaidFrames) do
					self.db.profile.syncData.raidFrames.cvars[v] = GetCVar(v) or nil
				end
				
				
				if (self:IsClassicEra() == true or self:IsClassicProgression() == true) then
					-- Raid Profiles
				
					--if (GetNumRaidProfiles() > 1) then
					
					self.db.profile.syncData.raidFrames.profiles = {}
					
					for i=1, GetNumRaidProfiles() do
					
						self.db.profile.syncData.raidFrames.profiles[i] = {}
														
						local thisRaidProfileName = GetRaidProfileName(i) or nil
					
						if (type(thisRaidProfileName) ~= "nil") then
							if (RaidProfileExists(thisRaidProfileName)) then
							
								if (self.db.global.printDebugTextToChat == true) then
									self:Print("[Raid Frame] Saving Raid Frame Profile with Name " .. thisRaidProfileName .. ".")
								end
								
								
								self.db.profile.syncData.raidFrames.profiles[i].name = thisRaidProfileName
								self.db.profile.syncData.raidFrames.profiles[i].isActive = false
								
								
								if (thisRaidProfileName == GetActiveRaidProfile()) then
									self.db.profile.syncData.raidFrames.profiles[i].isActive = true
								end
								
								
								self.db.profile.syncData.raidFrames.profiles[i].options =  GetRaidProfileFlattenedOptions(GetRaidProfileName(i))  
								
								local isDynamic, topPoint, topOffset, bottomPoint, bottomOffset, leftPoint, leftOffset = GetRaidProfileSavedPosition(GetRaidProfileName(i))
								
								self.db.profile.syncData.raidFrames.profiles[i].position = {
									["isDynamic"] = isDynamic,
									["topPoint"] = topPoint,
									["topOffset"] = topOffset,
									["bottomPoint"] = bottomPoint,
									["bottomOffset"] = bottomOffset,
									["leftPoint"] = leftPoint,
									["leftOffset"] = leftOffset
								}
								
							
							else
									
								self.db.profile.syncData.raidFrames.profiles[i] = nil

							end
						end
						
					end
			end
				
			
			end
			
			
			-- Save Block Channel Invite Variables
			if (self.db.profile.syncToggles.blockChannelInvites == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Block Channel Invites] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.BlockChannelInvites) do
					self.db.profile.syncData.blockChannelInvites.cvars[v] = GetCVar(v) or nil
				end
				
			end
			
			-- Save Block Trade Variables
			if (self.db.profile.syncToggles.blockTrades == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Block Trade Invites] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.BlockTrades) do
					self.db.profile.syncData.blockTrades.cvars[v] = GetCVar(v) or nil
				end
				
			end
			
			-- Save Auto Loot Variables
			if (self.db.profile.syncToggles.autoLoot == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Auto Loot] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.AutoLoot) do
					self.db.profile.syncData.autoLoot.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			
			-- Save Soft Target Variables
			if (self.db.profile.syncToggles.softTarget == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Soft Target] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.SoftTarget) do
					self.db.profile.syncData.softTarget.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Tutorial Variables
			if (self.db.profile.syncToggles.tutorialTooltips == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Tutorial Tooltip] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.TutorialTooltip) do
					self.db.profile.syncData.tutorialTooltips.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Battlefield Map Variables
			if (self.db.profile.syncToggles.battlefieldMap == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Zone Map] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.BattlefieldMap) do
					self.db.profile.syncData.battlefieldMap.cvars[v] = GetCVar(v) or nil
				end
				
				--self.db.profile.syncData.battlefieldMap.options = {}
				
				if (type(BattlefieldMapOptions.locked) == "boolean") then
					self.db.profile.syncData.battlefieldMap.options.locked = BattlefieldMapOptions.locked 
				end
				
				if (type(BattlefieldMapOptions.opacity) == "number") then
					self.db.profile.syncData.battlefieldMap.options.opacity = BattlefieldMapOptions.opacity or 0.7
				end
				
				if (type(BattlefieldMapOptions.showPlayers) == "boolean") then
					self.db.profile.syncData.battlefieldMap.options.showPlayers = BattlefieldMapOptions.showPlayers 
				end
				
				if self.db.global.useScreenSizeSpecificSettings == true then
					self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position = {}
					self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.x, self.db.profile.syncData.battlefieldMap.options.position.y = BattlefieldMapTab:GetCenter()
				else 
					self.db.profile.syncData.battlefieldMap.options.position = {}
					self.db.profile.syncData.battlefieldMap.options.position.x, self.db.profile.syncData.battlefieldMap.options.position.y = BattlefieldMapTab:GetCenter()
				end
			
			end
			
			-- Save Self Cast Settings
			if (self.db.profile.syncToggles.selfCast == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Self Cast] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.SelfCast) do
					self.db.profile.syncData.selfCast.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save World Map Settings
			if (self.db.profile.syncToggles.worldMap == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[World Map] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.WorldMap) do
					self.db.profile.syncData.worldMap.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Calendar Filter Settings
			if (self.db.profile.syncToggles.calendarFilters == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Calendar Filters] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.CalendarFilters) do
					self.db.profile.syncData.calendarFilters.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Camera Settings
			if (self.db.profile.syncToggles.camera == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Camera] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.Camera) do
					self.db.profile.syncData.camera.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Misc. Combat Settings
			if (self.db.profile.syncToggles.combatMisc == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Misc. Combat] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.CombatMisc) do
					self.db.profile.syncData.combatMisc.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Save Misc. UI Settings
			if (self.db.profile.syncToggles.uiMisc == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Misc. UI] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.UIMisc) do
					self.db.profile.syncData.uiMisc.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			-- Custom CVars
			if (self.db.global.allowCustomCVars == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Custom CVars] Saving Settings.")
				end
				
				self.db.profile.syncData.customCVars.cvarData = {}
				
				for line in self.db.profile.syncData.customCVars.cvarList:gmatch("([^\n]*)\n?") do
					line = line:gsub("[^%w]+", "")
					if line ~= "" then
						self.db.profile.syncData.customCVars.cvarData[line] = GetCVar(line) or nil
					end
				end
			
			end
			
			
			-- Save Chat Window Variables
			if (self.db.profile.syncToggles.chatWindow == true) then
			
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Chat Window] Saving Settings.")
				end
			
			
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do -- 12.0.0 Constants.ChatFrameConstants.MaxChatWindows
				
					local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					
					if (type(self.db.profile.syncData.chat.windows[thisChatFrame]) ~= table) then
						self.db.profile.syncData.chat.windows[thisChatFrame] = {}
					end
					
						
					-- Chat Window Info
					do
						local name, size, r, g, b, a, isShown, isLocked, isDocked, isUninteractable = GetChatWindowInfo(thisChatFrame);
						self.db.profile.syncData.chat.windows[thisChatFrame].ChatWindowInfo = {
							["name"] = name,
							["size"] = size,
							["r"] = r,
							["g"] = g,
							["b"] = b,
							["a"] = a,
							["isShown"] = isShown,
							["isLocked"] = isLocked,
							["isDocked"] = isDocked,
							["isUninteractable"] = isUninteractable
						}
					end
					
					--Positions
					if (self.db.profile.syncToggles.chatWindowPosition == true) then
					
						if self.db.global.useScreenSizeSpecificSettings == true then
						
							--Res Specific
							do
								local point, xOffset, yOffset = GetChatWindowSavedPosition(thisChatFrame);
								self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Positions = {
									["point"] = point,
									["xOffset"] = xOffset,
									["yOffset"] = yOffset
								}
							end
							
							--Dimensions
							do
								local width, height = GetChatWindowSavedDimensions(thisChatFrame);
								self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].chat.windows[thisChatFrame].Dimensions = {
									["width"] = width,
									["height"] = height
								}
							end
							
						else
						
							--Global
							do
								local point, xOffset, yOffset = GetChatWindowSavedPosition(thisChatFrame);
								self.db.profile.syncData.chat.windows[thisChatFrame].Positions = {
									["point"] = point,
									["xOffset"] = xOffset,
									["yOffset"] = yOffset
								}
							end
							
							--Dimensions
							do
								local width, height = GetChatWindowSavedDimensions(thisChatFrame);
								self.db.profile.syncData.chat.windows[thisChatFrame].Dimensions = {
									["width"] = width,
									["height"] = height
								}
							end
							
						end
						
					end



					--Message Types
					do
						self.db.profile.syncData.chat.windows[thisChatFrame].MessageTypes = {GetChatWindowMessages(thisChatFrame)}
					end
					
					
					--Chat Channels
					do
						self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible = {}
						
						local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
						
						for i = 1, #thisWindowChannels, 2 do
							local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
							table.insert(self.db.profile.syncData.chat.windows[thisChatFrame].ChatChannelsVisible, chn)
						end
						
					end
						
					
					

				end
				
				
				if (self.db.profile.syncToggles.chatChannels == true) then
					-- Chat Channels
					do
						self.db.profile.syncData.chat.channelsJoined = {}
						local channels = {GetChannelList()}
						for i = 1, #channels, 3 do
							local id, name, disabled = channels[i], channels[i+1], channels[i+2]
							
							local saveThisChannel = true
							
							--[[for k, v in pairs(AccWideUIAceAddon.chatChannelNames) do
								if v == name then
									saveThisChannel = false
								end
							end
							
							if string.find(name, "Community:") then
								saveThisChannel = false
							end]]
							
							
							if saveThisChannel == true then
								self.db.profile.syncData.chat.channelsJoined[id] = name
							end
							
							
						end
					end
				end
				
				
				--Chat Colours Etc
				do
					self.db.profile.syncData.chat.info = {}
					for k, v in pairs(self.CVars.ChatTypes) do
						if (type(ChatTypeInfo[v]) == "table") then
							local thisChatTypeInfo = ChatTypeInfo[v]
							self.db.profile.syncData.chat.info[v] = { ChatTypeInfo[v] }
						end
					end
				end
			
			end
			
			
			-- Save Nameplates
			if (self.db.profile.syncToggles.nameplates == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Nameplates] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.Nameplates) do
					self.db.profile.syncData.nameplates.cvars[v] = GetCVar(v) or nil
				end
				
				if (self:IsMainline() == true) then
				
					self.db.profile.syncData.nameplates.special.NamePlateSize = {}
					self.db.profile.syncData.nameplates.special.NamePlateSize[1], self.db.profile.syncData.nameplates.special.NamePlateSize[2] = C_NamePlate.GetNamePlateSize()
				
				else
				
					self.db.profile.syncData.nameplates.special.NamePlateEnemyClickThrough = C_NamePlate.GetNamePlateEnemyClickThrough()
					self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets = {}
					self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateEnemyPreferredClickInsets[4] = C_NamePlate.GetNamePlateEnemyPreferredClickInsets()
					self.db.profile.syncData.nameplates.special.NamePlateEnemySize = {}
					self.db.profile.syncData.nameplates.special.NamePlateEnemySize[1], self.db.profile.syncData.nameplates.special.NamePlateEnemySize[2] = C_NamePlate.GetNamePlateEnemySize()
					
					self.db.profile.syncData.nameplates.special.NamePlateFriendlyClickThrough = C_NamePlate.GetNamePlateFriendlyClickThrough()
					self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets = {}
					self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateFriendlyPreferredClickInsets[4] = C_NamePlate.GetNamePlateFriendlyPreferredClickInsets()
					self.db.profile.syncData.nameplates.special.NamePlateFriendlySize = {}
					self.db.profile.syncData.nameplates.special.NamePlateFriendlySize[1], self.db.profile.syncData.nameplates.special.NamePlateFriendlySize[2] = C_NamePlate.GetNamePlateFriendlySize()
					
					self.db.profile.syncData.nameplates.special.NamePlateSelfClickThrough = C_NamePlate.GetNamePlateSelfClickThrough()
					self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets = {}
					self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[1], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[2], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[3], self.db.profile.syncData.nameplates.special.NamePlateSelfPreferredClickInsets[4] = C_NamePlate.GetNamePlateSelfPreferredClickInsets()
					self.db.profile.syncData.nameplates.special.NamePlateSelfSize = {}
					self.db.profile.syncData.nameplates.special.NamePlateSelfSize[1], self.db.profile.syncData.nameplates.special.NamePlateSelfSize[2] = C_NamePlate.GetNamePlateSelfSize()
				
				end
				
			
			end -- EO accountWideNameplates

			
			-- RETAIL and TBC only variables
			if (self:IsMainline() == true or self:IsClassicTBC()) then
			
				-- Save Loss of Control Variables
				if (self.db.profile.syncToggles.lossOfControl == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Loss of Control] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.LossOfControl) do
						self.db.profile.syncData.lossOfControl.cvars[v] = GetCVar(v) or nil
					end
				
				end 
				
		
			end
			
			-- RETAIL only variables
			if (self:IsMainline() == true) then
			
				-- External Defensives Variables
				if (self.db.profile.syncToggles.externalDefensives == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[External Defensives] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.ExternalDefensives) do
						self.db.profile.syncData.externalDefensives.cvars[v] = GetCVar(v) or nil
					end
				
				end

				-- Save Mouseover Cast Settings
				if (self.db.profile.syncToggles.mouseoverCast == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Mouseover Cast] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.MouseoverCast) do
						self.db.profile.syncData.mouseoverCast.cvars[v] = GetCVar(v) or nil
					end
				
				end
			
				-- Save Empowered Tap/Hold Settings
				if (self.db.profile.syncToggles.empowerTap == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Empowered Tap/Hold] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.EmpowerTap) do
						self.db.profile.syncData.empowerTap.cvars[v] = GetCVar(v) or nil
					end
				
				end
				
				
				-- Save Cooldown Manager Setting
				if (self.db.profile.syncToggles.cooldownViewer == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Cooldown Manager] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.CooldownViewer) do
						self.db.profile.syncData.cooldownViewer.cvars[v] = GetCVar(v) or nil
					end
				
				end
				
				-- Save Assisted Highlight Setting
				if (self.db.profile.syncToggles.assistedCombat == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Assisted Highlight] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.AssistedCombat) do
						self.db.profile.syncData.assistedCombat.cvars[v] = GetCVar(v) or nil
					end
				
				end
				
				
				-- Save Location Visibility Setting
				if (self.db.profile.syncToggles.locationVisibility == true and isForced == true) then -- Does not work on logout
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Location Visibility] Saving Settings.")
					end
				
					self.db.profile.syncData.locationVisibility.special.allowRecentAlliesSeeLocation = GetAllowRecentAlliesSeeLocation()
				
				end
				
				
				-- Save Bag Organisation Settings
				if (self.db.global.allowExperimentalSyncs == true) then
					if (self.db.profile.syncToggles.bagOrganisation == true) then
						self:SaveBagFlagSettings()
					end
				end
	
			end
			
			
			
			
			--  Midnight only settings
			if (self:IsMainline() == true) then
			
				-- Save Damage Meter Setting
				if (self.db.profile.syncToggles.damageMeter == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Damage Meter] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.DamageMeter) do
						self.db.profile.syncData.damageMeter.cvars[v] = GetCVar(v) or nil
					end
					
					if (DamageMeterPerCharacterSettings) then
						self.db.profile.syncData.damageMeter.special.settings = {}
						self.db.profile.syncData.damageMeter.special.settings = CopyTable(DamageMeterPerCharacterSettings)
					end
					
					for i = 1, DamageMeter:GetMaxSessionWindowCount() do 
						self.db.profile.syncData.damageMeter.special.position[i] = nil
						
						local thisDamageMeter = _G["DamageMeterSessionWindow" .. i]
						if (thisDamageMeter and DamageMeter:CanMoveOrResizeSessionWindow(thisDamageMeter)) then -- First Window is set by Edit Mode
							
							self.db.profile.syncData.damageMeter.special.size[i] = {}
							self.db.profile.syncData.damageMeter.special.size[i].x = thisDamageMeter:GetWidth()
							self.db.profile.syncData.damageMeter.special.size[i].y = thisDamageMeter:GetHeight()
						
							self.db.profile.syncData.damageMeter.special.position[i] = {}
							self.db.profile.syncData.damageMeter.special.position[i].point = select(1, thisDamageMeter:GetPoint())
							self.db.profile.syncData.damageMeter.special.position[i].relativePoint = select(3, thisDamageMeter:GetPoint())
							self.db.profile.syncData.damageMeter.special.position[i].offsetX = select(4, thisDamageMeter:GetPoint())
							self.db.profile.syncData.damageMeter.special.position[i].offsetY = select(5, thisDamageMeter:GetPoint())
							--self.db.profile.syncData.damageMeter.special.position[i].offsetX = thisDamageMeter:GetLeft()
							--self.db.profile.syncData.damageMeter.special.position[i].offsetY = thisDamageMeter:GetTop()
							
							
						end
						
					end
				
				end
			
			end
			
			
			
			
			-- NOT CLASSIC ERA only variables
			if (self:IsClassicEra() == false) then
				-- Save Spell Overlay Variables
				if (self.db.profile.syncToggles.spellOverlay == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Spell Overlay] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.SpellOverlay) do
						self.db.profile.syncData.spellOverlay.cvars[v] = GetCVar(v) or nil
					end
				
				end
				
				
			end
			
			
			-- NOT Vanilla only variables
			if (self:IsClassicVanilla() == false) then
				-- Save Arena Frames
				if (self.db.profile.syncToggles.arenaFrames == true) then
				
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Arena Frames] Saving Settings.")
					end
				
					for k, v in pairs(self.CVars.ArenaFrames) do
						self.db.profile.syncData.arenaFrames.cvars[v] = GetCVar(v) or nil
					end
				
				end
			end
			
			
			
		end
	
	end

end

function AccWideUIAceAddon:SaveEditModeSettings()

	if ((self:IsMainline() or self:IsClassicTBC()) and not InCombatLockdown() and self.db.global.hasDoneFirstTimeSetup == true) then
	
		local getLayoutsTable = C_EditMode.GetLayouts()
		local currentActiveLayout = getLayoutsTable["activeLayout"]
		local currentSpec = tostring(C_SpecializationInfo.GetSpecialization())

		if (self.db.profile.syncToggles.editModeLayout == true) and (self.db.char.useEditModeLayout["specialization" .. currentSpec] == true) then
		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Saving Chosen Edit Mode Layout (ID: " .. currentActiveLayout .. ").")
			end

			if (self.db.char.useEditModeLayout["specialization" .. currentSpec] == true) then

				--Set the spec
				if self.db.global.useScreenSizeSpecificSettings == true then
					self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].editModeLayoutID = currentActiveLayout
				else
					self.db.profile.syncData.editModeLayoutID = currentActiveLayout
				end
			
			end
			
		end
		
	end 

end


function AccWideUIAceAddon:SaveBagFlagSettings()

	if (self:IsMainline() and self.db.global.allowExperimentalSyncs == true) then
		if (self.db.profile.syncToggles.bagOrganisation == true) then
					
			-- C_Container.GetBagSlotFlag always seems to return -false- when logging out. So save this only when BAG_SLOT_FLAGS_UPDATED or BANK_BAG_SLOT_FLAGS_UPDATED is triggered.
			
			self:ScheduleTimer(function() 
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Saving Settings and Flags.")
				end
				
				self.db.profile.syncData.bagOrganisation.bags = {}
		
				for bagName, bagId in pairs(Enum.BagIndex) do
				
					if (string.find(string.lower(bagName), "bank") == nil) then 
					
						self.db.profile.syncData.bagOrganisation.bags[bagName] = {}
					
						for k, v in pairs(Enum.BagSlotFlags) do
						
							if (self.db.global.printDebugTextToChat == true) then
								--self:Print("Saving " .. k .. " for " .. bagName .. ".")
							end
						
							self.db.profile.syncData.bagOrganisation.bags[bagName][k] = C_Container.GetBagSlotFlag(bagId, tonumber(v))
							
						end
					
					end

				end
			
			end, 10)

		end

	end


end


function AccWideUIAceAddon:ForceSaveSettings() 
	self:Print(L["ACCWUI_DEBUG_TXT_FORCESAVE"]);
	self:SaveUISettings(false, true); 
	self:SaveBagFlagSettings(); 
	self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites = GetAutoDeclineGuildInvites()
	
	if (AccWideUIAceAddon:IsMainline()) then
		self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites = GetAutoDeclineNeighborhoodInvites()
	
		self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
		self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
		self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled()
		self.db.profile.syncData.bagOrganisation.settings.backpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled() 
		self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled = C_Container.GetBankAutosortDisabled()
	end
	
end