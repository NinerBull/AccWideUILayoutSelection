AccWideUIAceAddon = LibStub("AceAddon-3.0"):NewAddon("AccWideUIAceAddon", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

--Temporary Data
AccWideUIAceAddon.TempData = {
	HasLoadedSettings = false,
	HasDoneInitialLoad = false,
	IsCurrentlyLoadingSettings = false,
	TextSlash = "/awi"
}

function AccWideUIAceAddon:OnInitialize()

	self.db = LibStub("AceDB-3.0"):New("AccWideUIAceDB", AccWideUIAceAddon:GenerateDefaultDB(), true)
	
	if (AccWideUI_AccountData ~= nil and AccWideUI_AccountData.HasDoneV1Migration ~= true) then
		AccWideUIAceAddon:MigrateFromV1()
	end
	
end

function AccWideUIAceAddon:OnEnable()

	local options = self:GenerateOptions()
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles = profiles
	options.args.profiles.name = "Sync Profiles"
	options.args.profiles.order = 3
	AC:RegisterOptionsTable("AccWideUIAceAddon_Options", options)
	
	
	self.optionsFrame = ACD:AddToBlizOptions("AccWideUIAceAddon_Options", "Account Wide UI")
	
	
	--AC:RegisterOptionsTable("AccWideUIAceAddon_Options", self:GenerateOptionsSyncSettings())
	--self.optionsSyncSettingsFrame = ACD:AddToBlizOptions("AccWideUIAceAddon_Options", "Sync Settings", "AccWideUIAceAddon")

	--AC:RegisterOptionsTable("AccWideUIAceAddon_Options", profiles)
	
	
	--ACD:AddToBlizOptions("AccWideUIAceAddon_Options", "Profiles", "AccWideUIAceAddon")
	
	--AC:RegisterOptionsTable("AccWideUIAceAddon_Options", self:GenerateOptionsDebug())
	--self.optionsDebugFrame = ACD:AddToBlizOptions("AccWideUIAceAddon_Options", "Debug", "AccWideUIAceAddon")
	
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
	
	if (AccWideUIAceAddon:IsMainline()) then
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		self:RegisterEvent("BAG_SLOT_FLAGS_UPDATED")
		self:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
	end
	
	
	if (self:IsMainline()) then
	
		self:SecureHook(C_EditMode, "OnEditModeExit", function()
			
			self:SaveEditModeSettings()
				
		end)
	
	end
	
end

function AccWideUIAceAddon:DoProfileInit(event, db, profileKey)

	--self:Print(event)
	
	--Set up profile data that I can't do with the regular table
	if (event == "OnNewProfile") then
	
		--Block Guild Invites
		self.db.profile.syncData.blockSocial.blockGuildInvites = self.db.profile.syncData.blockSocial.blockGuildInvites or GetAutoDeclineGuildInvites()
		
		
		-- Chat Windows
		for thisChatFrame = 1, NUM_CHAT_WINDOWS do
			--local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
			if (type(self.db.profile.syncData.chat.windows[thisChatFrame]) ~= "table") then
				self.db.profile.syncData.chat.windows[thisChatFrame] = {}
			end
		end 
		

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
	
		self:CancelAllTimers()
	
		self:ScheduleTimer(function() 
			self:LoadUISettings()			
		end, 2)
	
	end
	
	if (event == "OnProfileReset") then
	
		self:CancelAllTimers()

	end
	
end



function AccWideUIAceAddon:DoBeforeProfileShutdown(event, db, profileKey)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		self:SaveUISettings(true)
	end
end



function AccWideUIAceAddon:SlashCommand(input, editbox)
	Settings.OpenToCategory(self.optionsFrame.name)
end



function AccWideUIAceAddon:LOADING_SCREEN_DISABLED(event, arg1, arg2)

	if (self.TempData.HasDoneInitialLoad == false) then
	
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
	
		self.TempData.HasDoneInitialLoad = true
	
	end
	
	
end




function AccWideUIAceAddon:CHANNEL_UI_UPDATE(event, arg1, arg2)

	if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then

		if (self.db.global.hasDoneFirstTimeSetup == true) then
		
			-- Remove player from channels if they're blocked
			if (self.db.profile.blockChannels.general == true) then
				if (GetChannelName((GetChannelName(self.chatChannelNames.general))) > 0) then
					LeaveChannelByName(self.chatChannelNames.general)
					self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.general, self.TempData.TextSlash)
				end
			end
			
			if (self.db.profile.blockChannels.localDefense == true) then
				if (GetChannelName((GetChannelName(self.chatChannelNames.localDefense))) > 0) then
					LeaveChannelByName(self.chatChannelNames.localDefense)
					self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.localDefense, self.TempData.TextSlash)	
				end
			end
			
			if (self.db.profile.blockChannels.trade == true) then
				if (GetChannelName((GetChannelName(self.chatChannelNames.trade))) > 0) then
					LeaveChannelByName(self.chatChannelNames.trade)
					self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.trade, self.TempData.TextSlash)	
				end
			end
			
			if (self.db.profile.blockChannels.lookingForGroup == true) then
				if (GetChannelName((GetChannelName(self.chatChannelNames.lookingForGroup))) > 0) then
					LeaveChannelByName(self.chatChannelNames.lookingForGroup)
					self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.lookingForGroup, self.TempData.TextSlash)
				end
			end
			
			if (self:IsMainline() or self:IsClassicEra()) then
				if (self.db.profile.blockChannels.services == true) then
					if (GetChannelName((GetChannelName(self.chatChannelNames.services))) > 0) then
						LeaveChannelByName(self.chatChannelNames.services)
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.services, self.TempData.TextSlash)
					end
				end
			end
			
			if (self:IsMainline() == false) then
				if (self.db.profile.blockChannels.worldDefense == true) then
					if (GetChannelName((GetChannelName(self.chatChannelNames.worldDefense))) > 0) then
						LeaveChannelByName(self.chatChannelNames.worldDefense)
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.worldDefense, self.TempData.TextSlash)
					end
				end
			end
			
			
			if (self:IsClassicEra() or self:IsClassicWrath()) then
				if (self.db.profile.blockChannels.guildRecruitment == true) then
					if (GetChannelName((GetChannelName(self.chatChannelNames.guildRecruitment))) > 0) then
						LeaveChannelByName(self.chatChannelNames.guildRecruitment)
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.guildRecruitment, self.TempData.TextSlash)
					end
				end
			end
				
			if (self:IsClassicEra()) then
				if (self.db.profile.blockChannels.hardcoreDeaths == true) then
					if (GetChannelName((GetChannelName(self.chatChannelNames.hardcoreDeaths))) > 0) then
						LeaveChannelByName(self.chatChannelNames.hardcoreDeaths)
						self:Printf(L["ACCWUI_LEAVING_CHANNEL"], self.chatChannelNames.hardcoreDeaths, self.TempData.TextSlash)
					end
				end
			end	

		end

	end

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
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
			self:SaveBagFlagSettings(true)
		end
	end
end



function AccWideUIAceAddon:BANK_BAG_SLOT_FLAGS_UPDATED(event, arg1, arg2)
	if (self.db.global.hasDoneFirstTimeSetup == true) then
		if (self.db.profile.syncToggles.bagOrganisation == true and self.TempData.IsCurrentlyLoadingSettings == false) then
			self:SaveBagFlagSettings(true)
		end
	end
end
