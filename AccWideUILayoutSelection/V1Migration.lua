local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:MigrateFromV1(forceMigration)

	forceMigration = forceMigration or false

	if (AccWideUI_AccountData ~= nil and (AccWideUI_AccountData.HasDoneV1Migration ~= true or forceMigration == true)) then
	
		--Global
		self.db.global.hasDoneFirstTimeSetup = AccWideUI_AccountData.HasDoneFirstTimeSetup or false
		self.db.global.printDebugTextToChat = AccWideUI_AccountData.printDebugTextToChat or false
		self.db.global.printWhenLastSaved = AccWideUI_AccountData.printWhenLastSaved or false
		self.db.global.printWelcomeMessage = AccWideUI_AccountData.enableTextOutput or false
		
		--Profile
		self.db.profile.lastSaved.character = AccWideUI_AccountData.LastSaved.Character or UnitNameUnmodified("player")
		self.db.profile.lastSaved.unixTime = AccWideUI_AccountData.LastSaved.UnixTime or GetServerTime()
		
		self.db.profile.syncToggles.editModeLayout = AccWideUI_AccountData.enableAccountWide or true
		self.db.profile.syncToggles.editModeOnByDefault = AccWideUI_AccountData.accountWideLayout or true
		self.db.profile.syncToggles.actionBars = AccWideUI_AccountData.accountWideActionBars or true
		self.db.profile.syncToggles.nameplates = AccWideUI_AccountData.accountWideNameplates or true
		self.db.profile.syncToggles.raidFrames = AccWideUI_AccountData.accountWideRaidFrames or true
		self.db.profile.syncToggles.blockSocial = AccWideUI_AccountData.accountWideBlockSocialVariables or true
		self.db.profile.syncToggles.autoLoot = AccWideUI_AccountData.accountWideAutoLootVariables or true
		self.db.profile.syncToggles.softTarget = AccWideUI_AccountData.accountWideSoftTargetVariables or true
		self.db.profile.syncToggles.tutorialTooltips = AccWideUI_AccountData.accountWideTutorialTooltipVariables or true
		self.db.profile.syncToggles.battlefieldMap = AccWideUI_AccountData.accountWideBattlefieldMapVariables or true
		self.db.profile.syncToggles.mouseoverCast = AccWideUI_AccountData.accountWideMouseoverCastVariables or true
		self.db.profile.syncToggles.empowerTap = AccWideUI_AccountData.accountWideEmpowerTapVariables or true
		self.db.profile.syncToggles.lossOfControl = AccWideUI_AccountData.accountWideLossOfControlVariables or true
		self.db.profile.syncToggles.arenaFrames = AccWideUI_AccountData.accountWideArenaFrames or true
		self.db.profile.syncToggles.spellOverlay = AccWideUI_AccountData.accountWideSpellOverlayVariables or true
		
		self.db.profile.syncToggles.bagOrganisation = AccWideUI_AccountData.accountWideBagOrganisationVariables or false
		if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true) then
			self.db.global.allowExperimentalSyncs = true
		end
		
		self.db.profile.blizzChannels.general = (AccWideUI_AccountData.ChatChannels.BlockGeneral == true and "block" or "default")
		self.db.profile.blizzChannels.localDefense = (AccWideUI_AccountData.ChatChannels.BlockLocalDefense == true and "block" or "default")
		self.db.profile.blizzChannels.trade = (AccWideUI_AccountData.ChatChannels.BlockTrade == true and "block" or "default")
		self.db.profile.blizzChannels.lookingForGroup = (AccWideUI_AccountData.ChatChannels.BlockLookingForGroup == true and "block" or "default")
		self.db.profile.blizzChannels.services = (AccWideUI_AccountData.ChatChannels.BlockServices == true and "block" or "default")
		self.db.profile.blizzChannels.worldDefense = (AccWideUI_AccountData.ChatChannels.BlockWorldDefense == true and "block" or "default")
		self.db.profile.blizzChannels.guildRecruitment = (AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment == true and "block" or "default")
		self.db.profile.blizzChannels.hardcoreDeaths = (AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths == true and "block" or "default")
		
		self.db.profile.syncData.editModeLayoutID = AccWideUI_AccountData.accountWideLayoutID or 1
		self.db.profile.syncData.actionBars.visible = AccWideUI_AccountData.ActionBars or {}
		self.db.profile.syncData.actionBars.cvars = AccWideUI_AccountData.ActionBars.ActionBarVariables or {}
		self.db.profile.syncData.actionBars.visible.ActionBarVariables = nil
		self.db.profile.syncData.nameplates.cvars = AccWideUI_AccountData.Nameplates or {}
		self.db.profile.syncData.arenaFrames.cvars = AccWideUI_AccountData.ArenaFrames or {}
		self.db.profile.syncData.raidFrames.cvars = AccWideUI_AccountData.RaidFrames or {}
		self.db.profile.syncData.raidFrames.profiles = AccWideUI_AccountData.RaidFrameProfiles or {}
		self.db.profile.syncData.blockSocial.cvars = AccWideUI_AccountData.BlockSocial or {}
		self.db.profile.syncData.spellOverlay.cvars = AccWideUI_AccountData.SpellOverlay or {}
		self.db.profile.syncData.autoLoot.cvars = AccWideUI_AccountData.AutoLoot or {}
		self.db.profile.syncData.softTarget.cvars = AccWideUI_AccountData.SoftTarget or {}
		self.db.profile.syncData.tutorialTooltips.cvars = AccWideUI_AccountData.TutorialTooltips or {}
		self.db.profile.syncData.battlefieldMap.cvars = AccWideUI_AccountData.BattlefieldMap or {}
		self.db.profile.syncData.battlefieldMap.options = AccWideUI_AccountData.BattlefieldMapOptions or {}
		self.db.profile.syncData.lossOfControl.cvars = AccWideUI_AccountData.LossOfControl or {}
		self.db.profile.syncData.cooldownViewer.cvars = AccWideUI_AccountData.CooldownViewer or {}
		
		self.db.profile.syncData.blockSocial.special.blockGuildInvites = AccWideUI_AccountData.SpecialVariables.BlockGuildInvites or false
		
		if (AccWideUIAceAddon:IsMainline()) then
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
		
		-- Character
		if (AccWideUI_CharData ~= nil) then
			self.db.char.useEditModeLayout.spec1 = AccWideUI_CharData.accWideSpec1 or true
			self.db.char.useEditModeLayout.spec2 = AccWideUI_CharData.accWideSpec2 or true
			self.db.char.useEditModeLayout.spec3 = AccWideUI_CharData.accWideSpec3 or true
			self.db.char.useEditModeLayout.spec4 = AccWideUI_CharData.accWideSpec4 or true
			self.db.char.useEditModeLayout.spec5 = AccWideUI_CharData.accWideSpec5 or true
		else
			self.db.char.useEditModeLayout.spec1 = AccWideUI_AccountData.accountWideLayout or true
			self.db.char.useEditModeLayout.spec2 = AccWideUI_AccountData.accountWideLayout or true
			self.db.char.useEditModeLayout.spec3 = AccWideUI_AccountData.accountWideLayout or true
			self.db.char.useEditModeLayout.spec4 = AccWideUI_AccountData.accountWideLayout or true
			self.db.char.useEditModeLayout.spec5 = AccWideUI_AccountData.accountWideLayout or true
		end
		
		
		-- Flag to show migration has been done
		AccWideUI_AccountData.HasDoneV1Migration = true
		
		self:Print("Migrated settings over from old version of addon.")
		
	end

end