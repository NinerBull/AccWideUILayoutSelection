local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:SaveUISettings(doNotSaveEditMode)

	doNotSaveEditMode = doNotSaveEditMode or false

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
			
			if (self:IsMainline() and doNotSaveEditMode == false) then
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

					if self:IsMainline() then
						self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5, self.db.profile.syncData.actionBars.visible.Bar6, self.db.profile.syncData.actionBars.visible.Bar7, self.db.profile.syncData.actionBars.visible.Bar8 = GetActionBarToggles()
					else
						self.db.profile.syncData.actionBars.visible.Bar2, self.db.profile.syncData.actionBars.visible.Bar3, self.db.profile.syncData.actionBars.visible.Bar4, self.db.profile.syncData.actionBars.visible.Bar5 = GetActionBarToggles()
					end

			end
			
			
			-- Save Nameplates
			if (self.db.profile.syncToggles.nameplates == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Nameplate] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.Nameplates) do
					self.db.profile.syncData.nameplates.cvars[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideNameplates
			
			
			
			-- Save Raid Frames
			if (self.db.profile.syncToggles.raidFrames == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Raid Frames] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.RaidFrames) do
					self.db.profile.syncData.raidFrames.cvars[v] = GetCVar(v) or nil
				end
				
				
				if (self:IsMainline() == false) then
				
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
			
			
			-- Save Social Variables
			if (self.db.profile.syncToggles.blockSocial == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Social] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.BlockSocial) do
					self.db.profile.syncData.blockSocial.cvars[v] = GetCVar(v) or nil
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
			
			
			
			-- Save Loss of Control Variables
			if (self.db.profile.syncToggles.lossOfControl == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Loss of Control] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.LossOfControl) do
					self.db.profile.syncData.lossOfControl.cvars[v] = GetCVar(v) or nil
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
					self.db.profile.syncData.battlefieldMap.options.opacity = OpacityFrameSlider:GetValue() or BattlefieldMapOptions.opacity 
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
			

			
			-- Save Mouseover/Self Cast Settings
			if (self.db.profile.syncToggles.mouseoverCast == true) then
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Mouseover/Self Cast] Saving Settings.")
				end
			
				for k, v in pairs(self.CVars.MouseoverCast) do
					self.db.profile.syncData.mouseoverCast.cvars[v] = GetCVar(v) or nil
				end
			
			end
			
			
			

			
			-- Save Chat Window Variables
			if (self.db.profile.syncToggles.chatWindow == true) then
			
			
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Chat Window] Saving Settings.")
				end
			
			
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do
				
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

			
			
			
			-- RETAIL only variables
			if self:IsMainline() then
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
				
				
				-- Save Bag Organisation Settings
				if (self.db.profile.syncToggles.bagOrganisation == true) then
					self:SaveBagFlagSettings(false)
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

	if (self:IsMainline() and self.db.global.hasDoneFirstTimeSetup == true) then
	
		local getLayoutsTable = C_EditMode.GetLayouts()
		local currentActiveLayout = getLayoutsTable["activeLayout"]
		local currentSpec = tostring(C_SpecializationInfo.GetSpecialization())

		if (self.db.profile.syncToggles.editModeLayout == true) and (self.db.char.useEditModeLayout["spec" .. currentSpec] == true) then
		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Debug] Saving Chosen Edit Mode Layout.")
			end

			if (self.db.char.useEditModeLayout["spec" .. currentSpec] == true) then

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


function AccWideUIAceAddon:SaveBagFlagSettings(saveFlags)

	saveFlags = saveFlags or false

	if (self.db.profile.syncToggles.bagOrganisation == true) then
				
		self.db.profile.syncData.bagOrganisation.settings.SortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
		self.db.profile.syncData.bagOrganisation.settings.InsertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
	
		self.db.profile.syncData.bagOrganisation.settings.BackpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled()
		self.db.profile.syncData.bagOrganisation.settings.BackpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled() 
		
		self.db.profile.syncData.bagOrganisation.settings.BankAutosortDisabled = C_Container.GetBankAutosortDisabled()
		
		if (saveFlags == true) then 
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
		
		else
		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Bags] Saving Settings.")
			end
		
		end

	
	end



end