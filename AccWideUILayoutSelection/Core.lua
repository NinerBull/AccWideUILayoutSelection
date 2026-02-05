AccWideUIAceAddon = LibStub("AceAddon-3.0"):NewAddon("AccWideUIAceAddon", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0", "AceTimer-3.0")
AccWideUIAceAddon.AceGUI = LibStub("AceGUI-3.0")
AccWideUIAceAddon.LibSerialize = LibStub("LibSerialize")
AccWideUIAceAddon.LibDeflate = LibStub:GetLibrary("LibDeflate")
local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")


--Temporary Data
AccWideUIAceAddon.TempData = {
	TextSlash = "/awi",
	IsCurrentlyLoadingSettings = false,
	LoadSettingsAfterCombat = false,
	ProfileSaveVer = 2
}


function AccWideUIAceAddon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("AccWideUIAceDB", AccWideUIAceAddon:GenerateDefaultDB(), true)

	if (AccWideUI_AccountData ~= nil and AccWideUI_AccountData.HasDoneV1Migration ~= true) then
		AccWideUIAceAddon:MigrateFromV1()
	end

	AccWideUI_AccountData = nil
	
end

function AccWideUIAceAddon:OnEnable()

	local thisScreenWidth, thisScreenHeight = GetPhysicalScreenSize()
	self.TempData.ScreenRes = thisScreenWidth .. "x" .. thisScreenHeight
	self.TempData.ThisCharacter = UnitNameUnmodified("player") .. "-" .. GetNormalizedRealmName()

	self:GenerateOptions()
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.optionsData.args.profiles = profiles
	self.optionsData.args.profiles.order = 4
	AC:RegisterOptionsTable("AccWideUIAceAddon_Options", self.optionsData)

	self.optionsFrame = ACD:AddToBlizOptions("AccWideUIAceAddon_Options", L["ACCWUI_ADDONNAME_SHORT"])

	self.db.RegisterCallback(self, "OnNewProfile", "DoProfileInit")
    self.db.RegisterCallback(self, "OnProfileChanged", "DoProfileInit")
    self.db.RegisterCallback(self, "OnProfileCopied", "DoProfileInit")
    self.db.RegisterCallback(self, "OnProfileReset", "DoProfileInit")

	self.db.RegisterCallback(self, "OnProfileShutdown", "DoBeforeProfileShutdown")
	self.db.RegisterCallback(self, "OnDatabaseShutdown", "DoBeforeProfileShutdown")

	self:RegisterChatCommand("accwideui", "SlashCommand")
	self:RegisterChatCommand("accwideeditmode", "SlashCommand")
	self:RegisterChatCommand("accwideinterface", "SlashCommand")
	self:RegisterChatCommand("accwide", "SlashCommand")
	self:RegisterChatCommand("awi", "SlashCommand")

	self:DoProfileInit("OnEnable")

	self:RegisterEvent("CHANNEL_UI_UPDATE")
	self:RegisterEvent("DISABLE_DECLINE_GUILD_INVITE")
	self:RegisterEvent("ENABLE_DECLINE_GUILD_INVITE")
	self:RegisterEvent("LOADING_SCREEN_DISABLED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("CINEMATIC_STOP")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER")

	if (AccWideUIAceAddon:IsMainline()) then
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		self:RegisterEvent("BAG_SLOT_FLAGS_UPDATED")
		self:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
		self:RegisterEvent("LET_RECENT_ALLIES_SEE_LOCATION_SETTING_UPDATED")
	end


	C_AddOns.LoadAddOn("Blizzard_BattlefieldMap")

	self:SecureHook(BattlefieldMapTab, "StopMovingOrSizing", function()
		if (self.db.global.printDebugTextToChat == true) then
			self:Print("[Zone Map] Saving Map Coords.")
		end

		-- Save Zone Map Coords
		if ((self.db.profile.syncToggles.battlefieldMap == true) and (self.db.global.hasDoneFirstTimeSetup == true)) then
			if self.db.global.useScreenSizeSpecificSettings == true then
				self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position = {}
				self.db.profile.syncData.screenResolutionSpecific[self.TempData.ScreenRes].battlefieldMap.options.position.x, self.db.profile.syncData.battlefieldMap.options.position.y = BattlefieldMapTab:GetCenter()
			else
				self.db.profile.syncData.battlefieldMap.options.position = {}
				self.db.profile.syncData.battlefieldMap.options.position.x, self.db.profile.syncData.battlefieldMap.options.position.y = BattlefieldMapTab:GetCenter()
			end
			
			--self.db.profile.syncData.battlefieldMap.options.opacity = OpacityFrameSlider:GetValue() or BattlefieldMapOptions.opacity or 0.7
			
		end
	end)


	if (self:IsMainline() or self:IsClassicTBC()) then
		self:SecureHook(C_EditMode, "OnEditModeExit", function()
			if (C_AddOns.IsAddOnLoaded("EditModeExpanded") == true and not self.TempData.EditModeExpandedTriggered) then
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Debug] Ignoring first 'OnEditModeExit' due to EditModeExpanded.")
				end
				self.TempData.EditModeExpandedTriggered = true
			else
				if (self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
					self:SaveEditModeSettings()
					if (self.db.global.printDebugTextToChat == true) then
						self:Print("[Debug] Saving Edit Mode Layout on EditModeExit.")
					end
				end
			end
		end)
	end


	if (self:IsMainline()) then
		self:SecureHook(C_Container, "SetSortBagsRightToLeft", function(thisResponse)
			if (self.db.global.allowExperimentalSyncs == true and self.db.profile.syncToggles.bagOrganisation == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
				self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft = thisResponse
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Set sortBagsRightToLeft to " .. tostring(thisResponse) .. ".")
				end
			end
		end)


		self:SecureHook(C_Container, "SetInsertItemsLeftToRight", function(thisResponse)
			if (self.db.global.allowExperimentalSyncs == true and self.db.profile.syncToggles.bagOrganisation == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
				self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight = thisResponse
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Set insertItemsLeftToRight to " .. tostring(thisResponse) .. ".")
				end
			end
		end)



		self:SecureHook(C_Container, "SetBackpackAutosortDisabled", function(thisResponse)
			if (self.db.global.allowExperimentalSyncs == true and self.db.profile.syncToggles.bagOrganisation == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
				self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = thisResponse
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Set backpackAutosortDisabled to " .. tostring(thisResponse) .. ".")
				end
			end
		end)


		self:SecureHook(C_Container, "SetBackpackSellJunkDisabled", function(thisResponse)
			if (self.db.global.allowExperimentalSyncs == true and self.db.profile.syncToggles.bagOrganisation == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
				self.db.profile.syncData.bagOrganisation.settings.backpackSellJunkDisabled = thisResponse
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Set backpackSellJunkDisabled to " .. tostring(thisResponse) .. ".")
				end
			end
		end)


		self:SecureHook(C_Container, "SetBankAutosortDisabled", function(thisResponse)
			if (self.db.global.allowExperimentalSyncs == true and self.db.profile.syncToggles.bagOrganisation == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
				self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled = thisResponse
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Bags] Set bankAutosortDisabled to " .. tostring(thisResponse) .. ".")
				end
			end
		end)


		self:SecureHook("SetAutoDeclineNeighborhoodInvites", function(thisResponse)
			if (self.db.profile.syncToggles.blockNeighborhoodInvites == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false and self.TempData.IsCurrentlyLoadingSettings == false) then
				self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites = thisResponse
			end
		end)

	end
	
	-- Minimap Button
	self.LDBIcon:Register("AWI", self.LDB, self.db.global.minimapButton)


end

function AccWideUIAceAddon:DoProfileInit(event, db, profileKey)

	do
		-- Nil old variables
		self.db.profile.syncToggles.blockSocial = nil
		self.db.profile.syncData.blockSocial = nil
		self.db.profile.syncData.mouseoverCast.cvars.autoSelfCast = nil
	end


	-- Edit Mode Spec Settings
	if (self.db.char.useEditModeLayout.hasBeenPrepared ~= true) then
		for SpecX = 1, 5 do
			self.db.char.useEditModeLayout["specialization" .. SpecX] = self.db.profile.syncToggles.editModeOnByDefault
		end
		self.db.char.useEditModeLayout.hasBeenPrepared = true
	end


	--Set up profile data that I can't do with the regular table
	if (event == "OnNewProfile") then

		if (self.db.global.printDebugTextToChat == true) then
			self:Print("[Debug] Profile Created.")
		end

		--Block Guild Invites
		if (not self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites) then
			self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites = GetAutoDeclineGuildInvites()
		end



		if (AccWideUIAceAddon:IsMainline() == true) then

			--Block Neighborhood Invites
			if (not self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites) then
				self.db.profile.syncData.blockNeighborhoodInvites.special.blockNeighborhoodInvites = GetAutoDeclineNeighborhoodInvites()
			end

			self:ScheduleTimer(function()
				--Bag Organisation
				self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft = C_Container.GetSortBagsRightToLeft() or false
				self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight() or false
				self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled() or false
				self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled =  C_Container.GetBackpackSellJunkDisabled() or false
				self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled = C_Container.GetBankAutosortDisabled() or false
			end, 2)


			-- Edit Mode
			if (type(self.db.profile.syncData.editModeLayoutID) ~= "number") then
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]

				self.db.profile.syncData.editModeLayoutID = currentActiveLayout or 1

				if self.db.global.useScreenSizeSpecificSettings == true then
					self.db.profile.syncData.screenResolutionSpecific[AccWideUIAceAddon.TempData.ScreenRes].editModeLayoutID = currentActiveLayout or 1
				end

				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Debug] Setting default Edit Mode.")
				end

			end

		end

	end


	if (event == "OnProfileChanged" or event == "OnProfileCopied") then

		if (self.db.global.printDebugTextToChat == true) then
			self:Print("[Debug] Profile Changed.")
		end

		if (not InCombatLockdown() and not IsEncounterInProgress()) then
			if (self.db.global.disableAutoSaveLoad == false) then
				if (C_AddOns.IsAddOnLoaded("EditModeExpanded") == true and not self.TempData.EditModeExpandedTriggered) then
					 self.TempData.EditModeExpandedTriggered = true
				end
				self:CancelAllTimers()
				self:ScheduleTimer(function()
					self:LoadUISettings()
				end, 2)

			end
		else
			self:Print(L["ACCWUI_WAIT_TILL_COMBAT"])
			self.TempData.LoadSettingsAfterCombat = true
		end
	end

	if (event == "OnProfileReset") then
		if (self.db.global.printDebugTextToChat == true) then
			self:Print("[Debug] Profile Reset.")
		end

		self:CancelAllTimers()
	end
	
	AccWideUIAceAddon.LDB.text = AccWideUIAceAddon.db:GetCurrentProfile()


end



function AccWideUIAceAddon:DoBeforeProfileShutdown(event, db, profileKey)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false) then
		self:SaveUISettings(true)
	end
end



function AccWideUIAceAddon:SlashCommand(input, editbox)

	if not input or input:trim() == "" then
		Settings.OpenToCategory(self.optionsFrame.name)
	elseif input:lower() == "save" or input:lower() == "profiles save" then
		AccWideUIAceAddon:ForceSaveSettings()
	elseif input:lower() == "load" or input:lower() == "profiles load" then
		AccWideUIAceAddon:ForceLoadSettings()
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(AccWideUIAceAddon, "awi", "AccWideUIAceAddon_Options", input)
	end

end




function AccWideUIAceAddon:BlizzChannelManager()

	if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
	
		if (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown()) then
		
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Channel Manager] Chat in Lockdown.")
			end
		
			return
		end

		if (self.db.global.hasDoneFirstTimeSetup == true and not self.TempData.ThrottleJoinLeaveChannels) then

			

			-- Join player to channels if they're allowed
			if (self.db.profile.blizzChannels.general == "join") then
				if (((GetChannelName(self.chatChannelNames.general))) == 0) then
					JoinChannelByName(self.chatChannelNames.general)
					if (ChatFrame_AddChannel) then
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.general)
					else
						ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.general) -- 12.0.0
					end
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.general, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.localDefense == "join") then
				if (((GetChannelName(self.chatChannelNames.localDefense))) == 0) then
					JoinChannelByName(self.chatChannelNames.localDefense)
					if (ChatFrame_AddChannel) then
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.localDefense)
					else
						ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.localDefense) -- 12.0.0
					end
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.localDefense, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.trade == "join" and IsResting()) then
				if (((GetChannelName(self.chatChannelNames.trade))) == 0) then
					JoinChannelByName(self.chatChannelNames.trade)
					if (ChatFrame_AddChannel) then
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.trade)
					else
						ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.trade) -- 12.0.0
					end

					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.trade, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.lookingForGroup == "join") then
				if (((GetChannelName(self.chatChannelNames.lookingForGroup))) == 0) then
					JoinChannelByName(self.chatChannelNames.lookingForGroup)
					if (ChatFrame_AddChannel) then
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.lookingForGroup)
					else
						ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.lookingForGroup) -- 12.0.0
					end
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.lookingForGroup, self.TempData.TextSlash)
					end
				end
			end

			if (self:IsMainline() or self:IsClassicTBC() or self:IsClassicEra()) then
				if (self.db.profile.blizzChannels.services == "join" and IsResting()) then
					if (((GetChannelName(self.chatChannelNames.services))) == 0) then
						JoinChannelByName(self.chatChannelNames.services)
						if (ChatFrame_AddChannel) then
							ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.services)
						else
							ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.services) -- 12.0.0
						end
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.services, self.TempData.TextSlash)
						end
					end
				end
			end

			if (self:IsMainline() == false) then
				if (self.db.profile.blizzChannels.worldDefense == "join") then
					if (((GetChannelName(self.chatChannelNames.worldDefense))) == 0) then
						JoinChannelByName(self.chatChannelNames.worldDefense)
						if (ChatFrame_AddChannel) then
							ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.worldDefense)
						else
							ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.worldDefense) -- 12.0.0
						end
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.worldDefense, self.TempData.TextSlash)
						end
					end
				end
			end


			if (self:IsClassicEra() or self:IsClassicTBC() or self:IsClassicWrath()) then
				if (self.db.profile.blizzChannels.guildRecruitment == "join") then
					if (((GetChannelName(self.chatChannelNames.guildRecruitment))) == 0) then
						JoinChannelByName(self.chatChannelNames.guildRecruitment)
						if (ChatFrame_AddChannel) then
							ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.guildRecruitment)
						else
							ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.guildRecruitment) -- 12.0.0
						end
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.guildRecruitment, self.TempData.TextSlash)
						end
					end
				end
			end

			if (self:IsClassicEra()) then
				if (self.db.profile.blizzChannels.hardcoreDeaths == "join") then
					if (((GetChannelName(self.chatChannelNames.hardcoreDeaths))) == 0) then
						JoinChannelByName(self.chatChannelNames.hardcoreDeaths)
						if (ChatFrame_AddChannel) then
							ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.hardcoreDeaths)
						else
							ChatFrameMixin.AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.hardcoreDeaths) -- 12.0.0
						end
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.hardcoreDeaths, self.TempData.TextSlash)
						end
					end
				end
			end



			-- Remove player from channels if they're blocked
			if (self.db.profile.blizzChannels.general == "block") then
				if (GetChannelName((GetChannelName(self.chatChannelNames.general))) > 0) then
					LeaveChannelByName(self.chatChannelNames.general)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.general, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.localDefense == "block") then
				if (GetChannelName((GetChannelName(self.chatChannelNames.localDefense))) > 0) then
					LeaveChannelByName(self.chatChannelNames.localDefense)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.localDefense, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.trade == "block") then
				if (GetChannelName((GetChannelName(self.chatChannelNames.trade))) > 0) then
					LeaveChannelByName(self.chatChannelNames.trade)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.trade, self.TempData.TextSlash)
					end
				end
			end

			if (self.db.profile.blizzChannels.lookingForGroup == "block") then
				if (GetChannelName((GetChannelName(self.chatChannelNames.lookingForGroup))) > 0) then
					LeaveChannelByName(self.chatChannelNames.lookingForGroup)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.lookingForGroup, self.TempData.TextSlash)
					end
				end
			end

			if (self:IsMainline() or self:IsClassicTBC() or self:IsClassicEra()) then
				if (self.db.profile.blizzChannels.services == "block") then
					if (GetChannelName((GetChannelName(self.chatChannelNames.services))) > 0) then
						LeaveChannelByName(self.chatChannelNames.services)
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.services, self.TempData.TextSlash)
						end
					end
				end
			end

			if (self:IsMainline() == false) then
				if (self.db.profile.blizzChannels.worldDefense == "block") then
					if (GetChannelName((GetChannelName(self.chatChannelNames.worldDefense))) > 0) then
						LeaveChannelByName(self.chatChannelNames.worldDefense)
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.worldDefense, self.TempData.TextSlash)
						end
					end
				end
			end


			if (self:IsClassicEra() or self:IsClassicTBC() or self:IsClassicWrath()) then
				if (self.db.profile.blizzChannels.guildRecruitment == "block") then
					if (GetChannelName((GetChannelName(self.chatChannelNames.guildRecruitment))) > 0) then
						LeaveChannelByName(self.chatChannelNames.guildRecruitment)
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.guildRecruitment, self.TempData.TextSlash)
						end
					end
				end
			end

			if (self:IsClassicEra()) then
				if (self.db.profile.blizzChannels.hardcoreDeaths == "block") then
					if (GetChannelName((GetChannelName(self.chatChannelNames.hardcoreDeaths))) > 0) then
						LeaveChannelByName(self.chatChannelNames.hardcoreDeaths)
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.hardcoreDeaths, self.TempData.TextSlash)
						end
					end
				end
			end




		end

	end

end



function AccWideUIAceAddon:LOADING_SCREEN_DISABLED(event, arg1, arg2)

	if (not self.TempData.HasDoneInitialLoad) then

		if (self.db.global.disableAutoSaveLoad == false) then

			if (self.db.global.hasDoneFirstTimeSetup == true) then

				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Debug] Doing Initial Load.")
				end

				if (self.db.global.enableTextOutput == true) then
					self:Printf(L["ACCWUI_LOAD_REGULAR"], self.TempData.TextSlash)
				end

				if (not InCombatLockdown() and not IsEncounterInProgress()) then
					self:ScheduleTimer(function()
						self:LoadUISettings()
					end, 5)
				else
					self:Print(L["ACCWUI_WAIT_TILL_COMBAT"])
					self.TempData.LoadSettingsAfterCombat = true
				end

			else

				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
				--self:Print("Show First Time Popup")

			end

		end

		self.TempData.HasDoneInitialLoad = true

	end


end



function AccWideUIAceAddon:CHANNEL_UI_UPDATE(event, arg1, arg2)
	self:BlizzChannelManager()
end

function AccWideUIAceAddon:ZONE_CHANGED_NEW_AREA(event, arg1, arg2)
	self:ScheduleTimer(function()
		self:BlizzChannelManager()
	end, 5)
end


function AccWideUIAceAddon:CINEMATIC_STOP(event, arg1, arg2)

	if (not self.TempData.HasShownFTPPopup) then

		C_Timer.After(5, function()
			if (self.db.global.hasDoneFirstTimeSetup ~= true and not self.TempData.HasDimissedFTPAlready) then
				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
			end
		end)

		self.TempData.HasShownFTPPopup = true

	end

end


function AccWideUIAceAddon:DISABLE_DECLINE_GUILD_INVITE(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites = false
	end
end



function AccWideUIAceAddon:ENABLE_DECLINE_GUILD_INVITE(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites = true
	end
end



function AccWideUIAceAddon:ACTIVE_TALENT_GROUP_CHANGED(event, arg1, arg2)
	if (not InCombatLockdown() and not IsEncounterInProgress() and self.TempData.HasDoneInitialLoad) then
		self:ScheduleTimer(function()
			self:LoadEditModeSettings()
		end, 0.5)
	end
end



function AccWideUIAceAddon:BAG_SLOT_FLAGS_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false and self:IsMainline() == true) then
		if (self.db.global.allowExperimentalSyncs == true) then
			if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
				self:SaveBagFlagSettings()
			end
		end
	end
end



function AccWideUIAceAddon:BANK_BAG_SLOT_FLAGS_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false and self:IsMainline() == true) then
		if (self.db.global.allowExperimentalSyncs == true) then
			if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
				self:SaveBagFlagSettings()
			end
		end
	end
end

function AccWideUIAceAddon:LET_RECENT_ALLIES_SEE_LOCATION_SETTING_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false and self.db.global.disableAutoSave == false and self:IsMainline() == true) then
		if (self.db.profile.syncToggles.locationVisibility == true) then
			self.db.profile.syncData.locationVisibility.special.allowRecentAlliesSeeLocation = GetAllowRecentAlliesSeeLocation()
			if (self.db.global.printDebugTextToChat == true) then
				self:Print("[Location Visibility] Setting Changed.")
			end

		end
	end
end


function AccWideUIAceAddon:PLAYER_REGEN_ENABLED(event, arg1, arg2)
	if (self.TempData.LoadSettingsAfterCombat == true) then
		self.TempData.LoadSettingsAfterCombat = false
		self:CancelAllTimers();
		self:ScheduleTimer(function()
			self:LoadUISettings()
		end, 3)
	end
end

function AccWideUIAceAddon:PLAYER_REGEN_DISABLED(event, arg1, arg2)
	if (self.TempData.IsCurrentlyLoadingSettings == true) then
		self.TempData.IsCurrentlyLoadingSettings = false
		self.TempData.LoadSettingsAfterCombat = true
		self:CancelAllTimers();
		if (self.db.global.printDebugTextToChat == true) then
			self:Print(L["ACCWUI_WAIT_TILL_COMBAT"])
		end
	end
end

function AccWideUIAceAddon:CHAT_MSG_CHANNEL_NOTICE_USER(event, arg1, arg2)
	if issecretvalue and issecretvalue(arg1) then
		return
	end
	if (select(1, arg1) == "INVALID_NAME") then
		-- Throttle trying to join or leave channels for a few seconds
		self.TempData.ThrottleJoinLeaveChannels = true
		self:ScheduleTimer(function()
			self.TempData.ThrottleJoinLeaveChannels = nil
		end, 5)
	end
end
