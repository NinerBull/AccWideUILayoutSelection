AccWideUIAceAddon = LibStub("AceAddon-3.0"):NewAddon("AccWideUIAceAddon", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

--Temporary Data
AccWideUIAceAddon.TempData = {
	HasLoadedSettings = false,
	HasDoneInitialLoad = false,
	IsCurrentlyLoadingSettings = false,
	TextSlash = "/awi",
}


function AccWideUIAceAddon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("AccWideUIAceDB", AccWideUIAceAddon:GenerateDefaultDB(), true)
	
	if (AccWideUI_AccountData ~= nil and AccWideUI_AccountData.HasDoneV1Migration ~= true) then
		AccWideUIAceAddon:MigrateFromV1()
	end
	
	-- Do this in future, to prevent bloat in the addon settings file with old data, once I'm 100% sure the migration works as it should
	--[[
		AccWideUI_AccountData = nil
		AccWideUI_CharData = nil
	]]
	
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
	
	if (AccWideUIAceAddon:IsMainline()) then
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		self:RegisterEvent("BAG_SLOT_FLAGS_UPDATED")
		self:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
	end
	
	
	if (self:IsMainline() and self.db.global.disableAutoSaveLoad == false) then
		self:SecureHook(C_EditMode, "OnEditModeExit", function()
			self:SaveEditModeSettings()
		end)
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
			
			
		end	
	end)
	
end

function AccWideUIAceAddon:DoProfileInit(event, db, profileKey)

	--Set up profile data that I can't do with the regular table
	if (event == "OnNewProfile") then
	
		--Block Guild Invites
		self.db.profile.syncData.blockSocial.blockGuildInvites = self.db.profile.syncData.blockSocial.blockGuildInvites or GetAutoDeclineGuildInvites()
		
		
		if (AccWideUIAceAddon:IsMainline()) then
		
			self:ScheduleTimer(function() 
				--Bag Organisation
				self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft = self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft or C_Container.GetSortBagsRightToLeft()
				self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight = self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight or C_Container.GetInsertItemsLeftToRight()
				self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled or C_Container.GetBackpackAutosortDisabled()
				self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled or C_Container.GetBackpackSellJunkDisabled()
				self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled = self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled or C_Container.GetBankAutosortDisabled()
			end, 2)
			
						
			-- Edit Mode
			if (type(self.db.profile.syncData.editModeLayoutID) ~= "number") then
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				
				self.db.profile.syncData.editModeLayoutID = currentActiveLayout or 1
				
				if self.db.global.useScreenSizeSpecificSettings == true then
					self.db.profile.syncData.screenResolutionSpecific[AccWideUIAceAddon.TempData.ScreenRes].editModeLayoutID = currentActiveLayout or 1
				end
				
			end
			

			-- Edit Mode Spec Settings
			if (type(self.db.char.useEditModeLayout.spec1) ~= "boolean") then
				for SpecX = 1, 5 do
					self.db.char.useEditModeLayout["spec" .. SpecX] = self.db.profile.syncToggles.editModeOnByDefault
				end
			end
		
		end
		
	end
	
	
	if (event == "OnProfileChanged" or event == "OnProfileCopied") then
		if (self.db.global.disableAutoSaveLoad == false) then
			self:CancelAllTimers()
		
			self:ScheduleTimer(function() 
				self:LoadUISettings()			
			end, 2)
		end
	end
	
	if (event == "OnProfileReset") then
		self:CancelAllTimers()
	end
	
end



function AccWideUIAceAddon:DoBeforeProfileShutdown(event, db, profileKey)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false) then
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

		if (self.db.global.hasDoneFirstTimeSetup == true) then
		
			
			
			-- Join player to channels if they're allowed
			if (self.db.profile.blizzChannels.general == "join") then
				if (((GetChannelName(self.chatChannelNames.general))) == 0) then
					JoinChannelByName(self.chatChannelNames.general)
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.general)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.general, self.TempData.TextSlash)
					end
				end
			end
			
			if (self.db.profile.blizzChannels.localDefense == "join") then
				if (((GetChannelName(self.chatChannelNames.localDefense))) == 0) then
					JoinChannelByName(self.chatChannelNames.localDefense)
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.localDefense)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.localDefense, self.TempData.TextSlash)
					end
				end
			end
			
			if (self.db.profile.blizzChannels.trade == "join") then
				if (((GetChannelName(self.chatChannelNames.trade))) == 0) then
					JoinChannelByName(self.chatChannelNames.trade)
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.trade)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.trade, self.TempData.TextSlash)
					end
				end
			end
			
			if (self.db.profile.blizzChannels.lookingForGroup == "join") then
				if (((GetChannelName(self.chatChannelNames.lookingForGroup))) == 0) then
					JoinChannelByName(self.chatChannelNames.lookingForGroup)
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.lookingForGroup)
					if (self.db.global.printBlizzChatChanges == true) then
						self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.lookingForGroup, self.TempData.TextSlash)
					end
				end
			end
			
			if (self:IsMainline() or self:IsClassicEra()) then
				if (self.db.profile.blizzChannels.services == "join") then
					if (((GetChannelName(self.chatChannelNames.services))) == 0) then
						JoinChannelByName(self.chatChannelNames.services)
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.services)
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
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.worldDefense)
						if (self.db.global.printBlizzChatChanges == true) then
							self:Printf(L["ACCWUI_JOINING_CHANNEL"], self.chatChannelNames.worldDefense, self.TempData.TextSlash)
						end
					end
				end
			end
			
			
			if (self:IsClassicEra() or self:IsClassicWrath()) then
				if (self.db.profile.blizzChannels.guildRecruitment == "join") then
					if (((GetChannelName(self.chatChannelNames.guildRecruitment))) == 0) then
						JoinChannelByName(self.chatChannelNames.guildRecruitment)
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.guildRecruitment)
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
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, self.chatChannelNames.hardcoreDeaths)
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
			
			if (self:IsMainline() or self:IsClassicEra()) then
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
			
			
			if (self:IsClassicEra() or self:IsClassicWrath()) then
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

	if (self.TempData.HasDoneInitialLoad == false) then
	
		if (self.db.global.disableAutoSaveLoad == false) then
		
			if (self.db.global.hasDoneFirstTimeSetup == true) then
				
				if (self.db.global.printDebugTextToChat == true) then
					self:Print("[Debug] Doing Initial Load.")
				end
				
				if (self.db.global.enableTextOutput == true) then
					self:Printf(L["ACCWUI_LOAD_REGULAR"], self.TempData.TextSlash)
				end
				
				self:ScheduleTimer(function() 
					AccWideUIAceAddon:LoadUISettings()
				end, 5)
				
			else
			
				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
			
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



function AccWideUIAceAddon:DISABLE_DECLINE_GUILD_INVITE(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		self.db.profile.syncData.blockSocial.special.blockGuildInvites = false
	end
end



function AccWideUIAceAddon:ENABLE_DECLINE_GUILD_INVITE(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		self.db.profile.syncData.blockSocial.special.blockGuildInvites = true
	end
end



function AccWideUIAceAddon:ACTIVE_TALENT_GROUP_CHANGED(event, arg1, arg2)
	if (self.TempData.HasDoneInitialLoad == true) then
		self:ScheduleTimer(function() 
			self:LoadEditModeSettings()
		end, 0.5)
	end
	
end



function AccWideUIAceAddon:BAG_SLOT_FLAGS_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false) then
		if (self.db.global.allowExperimentalSyncs == true) then
			if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
				self:SaveBagFlagSettings(true)
			end
		end
	end
end



function AccWideUIAceAddon:BANK_BAG_SLOT_FLAGS_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true and self.db.global.disableAutoSaveLoad == false) then
		if (self.db.global.allowExperimentalSyncs == true) then
			if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
				self:SaveBagFlagSettings(true)
			end
		end
	end
end

