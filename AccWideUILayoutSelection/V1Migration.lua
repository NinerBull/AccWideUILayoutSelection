local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:MigrateFromV1()

	if (AccWideUI_AccountData ~= nil and AccWideUI_AccountData.HasDoneV1Migration ~= true) then
	
		--Global
		self.db.global.hasDoneFirstTimeSetup = (AccWideUI_AccountData.HasDoneFirstTimeSetup == true and true or false)
		self.db.global.printDebugTextToChat = (AccWideUI_AccountData.printDebugTextToChat == true and true or false)
		self.db.global.printWhenLastSaved = (AccWideUI_AccountData.printWhenLastSaved == true and true or false)
		self.db.global.printWelcomeMessage = (AccWideUI_AccountData.enableTextOutput == true and true or false)
		
		--Profile
		if (AccWideUI_AccountData.LastSaved) then
			self.db.profile.lastSaved.character = AccWideUI_AccountData.LastSaved.Character or UnitNameUnmodified("player")
			self.db.profile.lastSaved.unixTime = AccWideUI_AccountData.LastSaved.UnixTime or GetServerTime()
		end
		
		self.db.profile.syncToggles.editModeLayout = (AccWideUI_AccountData.enableAccountWide == true and true or false)
		self.db.profile.syncToggles.editModeOnByDefault = (AccWideUI_AccountData.accountWideLayout == true and true or false)
		self.db.profile.syncToggles.actionBars = (AccWideUI_AccountData.accountWideActionBars == true and true or false)
		self.db.profile.syncToggles.nameplates = (AccWideUI_AccountData.accountWideNameplates == true and true or false)
		self.db.profile.syncToggles.raidFrames = (AccWideUI_AccountData.accountWideRaidFrames == true and true or false)
		self.db.profile.syncToggles.blockTrades = (AccWideUI_AccountData.accountWideBlockSocialVariables == true and true or false)
		self.db.profile.syncToggles.blockChannelInvites = (AccWideUI_AccountData.accountWideBlockSocialVariables == true and true or false)
		self.db.profile.syncToggles.blockGuildInvites = (AccWideUI_AccountData.accountWideBlockSocialVariables == true and true or false)
		self.db.profile.syncToggles.autoLoot = (AccWideUI_AccountData.accountWideAutoLootVariables == true and true or false)
		self.db.profile.syncToggles.softTarget = (AccWideUI_AccountData.accountWideSoftTargetVariables == true and true or false)
		self.db.profile.syncToggles.tutorialTooltips = (AccWideUI_AccountData.accountWideTutorialTooltipVariables == true and true or false)
		self.db.profile.syncToggles.battlefieldMap = (AccWideUI_AccountData.accountWideBattlefieldMapVariables == true and true or false)
		self.db.profile.syncToggles.mouseoverCast = (AccWideUI_AccountData.accountWideMouseoverCastVariables == true and true or false)
		self.db.profile.syncToggles.selfCast = (AccWideUI_AccountData.accountWideMouseoverCastVariables == true and true or false)
		self.db.profile.syncToggles.empowerTap = (AccWideUI_AccountData.accountWideEmpowerTapVariables == true and true or false)
		self.db.profile.syncToggles.lossOfControl = (AccWideUI_AccountData.accountWideLossOfControlVariables == true and true or false)
		self.db.profile.syncToggles.arenaFrames = (AccWideUI_AccountData.accountWideArenaFrames == true and true or false)
		self.db.profile.syncToggles.spellOverlay = (AccWideUI_AccountData.accountWideSpellOverlayVariables == true and true or false)
		self.db.profile.syncToggles.cooldownViewer = (AccWideUI_AccountData.accountWideCooldownViewerVariables == true and true or false)
		
		self.db.profile.syncToggles.chatWindow = (AccWideUI_AccountData.accountWideChatWindowVariables == true and true or false)
		self.db.profile.syncToggles.chatWindowPosition = (AccWideUI_AccountData.accountWideChatWindowPosition == true and true or false)
		self.db.profile.syncToggles.chatChannels = (AccWideUI_AccountData.accountWideChatChannelVariables == true and true or false)
		
		self.db.profile.syncToggles.bagOrganisation = (AccWideUI_AccountData.accountWideBagOrganisationVariables == true and true or false)
		
		if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true) then
			self.db.global.allowExperimentalSyncs = true
		end
		
		if (AccWideUI_AccountData.ChatChannels) then
			self.db.profile.blizzChannels.general = (AccWideUI_AccountData.ChatChannels.BlockGeneral == true and "block" or "default")
			self.db.profile.blizzChannels.localDefense = (AccWideUI_AccountData.ChatChannels.BlockLocalDefense == true and "block" or "default")
			self.db.profile.blizzChannels.trade = (AccWideUI_AccountData.ChatChannels.BlockTrade == true and "block" or "default")
			self.db.profile.blizzChannels.lookingForGroup = (AccWideUI_AccountData.ChatChannels.BlockLookingForGroup == true and "block" or "default")
			self.db.profile.blizzChannels.services = (AccWideUI_AccountData.ChatChannels.BlockServices == true and "block" or "default")
			self.db.profile.blizzChannels.worldDefense = (AccWideUI_AccountData.ChatChannels.BlockWorldDefense == true and "block" or "default")
			self.db.profile.blizzChannels.guildRecruitment = (AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment == true and "block" or "default")
			self.db.profile.blizzChannels.hardcoreDeaths = (AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths == true and "block" or "default")
		end
		
		
		
		if (AccWideUI_AccountData.ActionBars) then
			self.db.profile.syncData.actionBars.visible = AccWideUI_AccountData.ActionBars or {}
			if (AccWideUI_AccountData.ActionBars.ActionBarVariables) then
				self.db.profile.syncData.actionBars.cvars = AccWideUI_AccountData.ActionBars.ActionBarVariables or {}
				self.db.profile.syncData.actionBars.visible.ActionBarVariables = nil
			end
		end
		
		self.db.profile.syncData.editModeLayoutID = AccWideUI_AccountData.accountWideLayoutID or 1
		self.db.profile.syncData.nameplates.cvars = AccWideUI_AccountData.Nameplates or {}
		self.db.profile.syncData.arenaFrames.cvars = AccWideUI_AccountData.ArenaFrames or {}
		self.db.profile.syncData.raidFrames.cvars = AccWideUI_AccountData.RaidFrames or {}
		self.db.profile.syncData.raidFrames.profiles = AccWideUI_AccountData.RaidFrameProfiles or {}
		self.db.profile.syncData.spellOverlay.cvars = AccWideUI_AccountData.SpellOverlay or {}
		self.db.profile.syncData.autoLoot.cvars = AccWideUI_AccountData.AutoLoot or {}
		self.db.profile.syncData.softTarget.cvars = AccWideUI_AccountData.SoftTarget or {}
		self.db.profile.syncData.tutorialTooltips.cvars = AccWideUI_AccountData.TutorialTooltips or {}
		self.db.profile.syncData.battlefieldMap.cvars = AccWideUI_AccountData.BattlefieldMap or {}
		self.db.profile.syncData.battlefieldMap.options = AccWideUI_AccountData.BattlefieldMapOptions or {}
		self.db.profile.syncData.lossOfControl.cvars = AccWideUI_AccountData.LossOfControl or {}
		self.db.profile.syncData.cooldownViewer.cvars = AccWideUI_AccountData.CooldownViewer or {}
		
		
		if (AccWideUI_AccountData.BlockSocial) then
			if (AccWideUI_AccountData.BlockSocial.blockChannelInvites) then
				self.db.profile.syncData.blockChannelInvites.cvars.blockChannelInvites = AccWideUI_AccountData.BlockSocial.blockChannelInvites
			end
			if (AccWideUI_AccountData.BlockSocial.blockTrades) then
				self.db.profile.syncData.blockTrades.cvars.blockTrades = AccWideUI_AccountData.BlockSocial.blockTrades
			end
		end
		
		if (AccWideUI_AccountData.SpecialVariables) then
			self.db.profile.syncData.blockGuildInvites.special.blockGuildInvites = (AccWideUI_AccountData.SpecialVariables.BlockGuildInvites == true and true or false)
		end
		
		if (AccWideUIAceAddon:IsMainline() and AccWideUI_AccountData.BagOrganisation) then
			self.db.profile.syncData.bagOrganisation.bags = AccWideUI_AccountData.BagOrganisation.Bags or {}
			self.db.profile.syncData.bagOrganisation.settings.sortBagsRightToLeft = AccWideUI_AccountData.BagOrganisation.SortBagsRightToLeft or C_Container.GetSortBagsRightToLeft()
			self.db.profile.syncData.bagOrganisation.settings.insertItemsLeftToRight = AccWideUI_AccountData.BagOrganisation.InsertItemsLeftToRight or C_Container.GetInsertItemsLeftToRight()
			self.db.profile.syncData.bagOrganisation.settings.backpackAutosortDisabled = AccWideUI_AccountData.BagOrganisation.BackpackAutosortDisabled or C_Container.GetBackpackAutosortDisabled()
			self.db.profile.syncData.bagOrganisation.settings.backpackSellJunkDisabled = AccWideUI_AccountData.BagOrganisation.BackpackSellJunkDisabled or C_Container.GetBackpackSellJunkDisabled()
			self.db.profile.syncData.bagOrganisation.settings.bankAutosortDisabled = AccWideUI_AccountData.BagOrganisation.BankAutosortDisabled or C_Container.GetBankAutosortDisabled()
		end
		
		self.db.profile.syncData.chat.windows = AccWideUI_AccountData.ChatWindows or {}
		self.db.profile.syncData.chat.channelsJoined = AccWideUI_AccountData.ChatChannelsJoined or {}
		self.db.profile.syncData.chat.info = AccWideUI_AccountData.ChatInfo or {}
				
		-- Flag to show migration has been done
		AccWideUI_AccountData.HasDoneV1Migration = true
		
		self:Print("Migrated settings over from old version of addon.")
		
	end

end