local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

AccWideUIAceAddon.CVars = {

	Nameplates = {
		"ColorNameplateNameBySelection",
		"clampTargetNameplateToScreen",
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
		"nameplateShowOnlyNames",
		"nameplateNotSelectedAlpha",
		"nameplateRemovalAnimation",
		"nameplateCommentatorMaxDistance",
		"showVKeyCastbarSpellName",
		"showVKeyCastbarOnlyOnTarget",
		"nameplateShowCastBars",
		"nameplateSimplifiedScale",
		"nameplateUseClassColorForFriendlyPlayerUnitNames"
	},

	RaidFrames = {
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
		"fullSizeFocusFrame",
		"showDispelDebuffs",
		"showCastableBuffs",
		"threatWarning",
		"noBuffDebuffFilterOnTarget",
		"raidFramesCenterBigDefensive",
		"raidFramesDispelIndicatorOverlay",
		"raidFramesDispelIndicatorType",
		"raidFramesDisplayLargerRoleSpecificDebuffs",
		"raidFramesHealthBarColor",
		"raidFramesHealthBarColorBG"
	},

	ArenaFrames = {
		"showArenaEnemyCastbar",
		"showArenaEnemyFrames",
		"showArenaEnemyPets",
		"pvpOptionDisplayPets",
		"pvpFramesHealthText",
		"pvpFramesDisplayPowerBars",
		"pvpFramesDisplayClassColor",
		"pvpFramesDisplayOnlyHealerPowerBars",
		"spellDiminishPVPEnemiesEnabled",
		"spellDiminishPVPOnlyTriggerableByMe"
	},
	
	BlockChannelInvites = {
		"blockChannelInvites"
	},

	BlockTrades = {
		"blockTrades"
	},

	SpellOverlay = {
		"displaySpellActivationOverlays",
		"spellActivationOverlayOpacity"
	},

	AutoLoot = {
		"autoLootDefault",
		"autoLootRate"
	},

	LossOfControl = {
		"lossOfControl",
		"lossOfControlFull",
		"lossOfControlInterrupt",
		"lossOfControlRoot",
		"lossOfControlSilence"
	},

	SoftTarget = {
		"SoftTargetEnemy",
		"SoftTargetEnemyArc",
		"SoftTargetEnemyRange",
		"SoftTargetForce",
		"SoftTargetFriend",
		"SoftTargetFriendArc",
		"SoftTargetFriendRange"
	},

	TutorialTooltip = {
		"closedInfoFrames",
		"closedExtraAbiltyTutorials",
		"lastVoidStorageTutorial" --[[,
		"covenantMissionTutorial",
		"orderHallMissionTutorial",
		"lastGarrisonMissionTutorial",
		"shipyardMissionTutorialAreaBuff",
		"shipyardMissionTutorialBlockade",
		"shipyardMissionTutorialFirst",
		"dangerousShipyardMissionWarningAlreadyShown",
		"soulbindsActivatedTutorial",
		"soulbindsLandingPageTutorial",
		"soulbindsViewedTutorial"]]
	},

	BattlefieldMap = {
		"showBattlefieldMinimap"
	},

	ActionBars = {
		--"enableMultiActionBars",
		"multiBarRightVerticalLayout"
	},

	CooldownViewer = {
		"cooldownViewerEnabled"
	},

	MouseoverCast = {
		"enableMouseoverCast"
	},
	
	SelfCast = {
		"autoSelfCast"
	},

	EmpowerTap = {
		"empowerTapControls"
	},
	
	AssistedCombat = {
		"assistedCombatHighlight"
	},
		
	DamageMeter = {
		"damageMeterEnabled",
		"damageMeterResetOnNewInstance"
	},
	
	WorldMap = {
		"mapFade",
		"miniWorldMap",
		"questLogOpen",
		"questPOI",
		"questPOILocalStory",
		"questPOIWQ",
		"scrollToLogQuest",
		"showDelveEntrancesOnMap",
		"showQuestObjectivesInLog",
		"showQuestObjectivesOnMap",
		"showDungeonEntrancesOnMap",
		"showTamers",
		"showTamersWQ",
		"dragonRidingRacesFilter",
		"dragonRidingRacesFilterWQ",
		"worldQuestFilterAnima",
		"worldQuestFilterArtifactPower",
		"worldQuestFilterEquipment",
		"worldQuestFilterGold",
		"worldQuestFilterProfessionMaterials",
		"worldQuestFilterReputation",
		"worldQuestFilterResources",
		"primaryProfessionsFilter",
		"secondaryProfessionsFilter",
		"contentTrackingFilter",
		"questHelper",
		"showBosses",
		"worldMapOpacity"
	},
	
	Minimap = {
		"minimapInsideZoom",
		"minimapShowArchBlobs",
		"minimapShowQuestBlobs",
		"minimapZoom",
		"minimapTrackingShowAll"
	},
	
	CalendarFilters = {
		"calendarShowBattlegrounds",
		"calendarShowDarkmoon",
		"calendarShowHolidays",
		"calendarShowLockouts",
		"calendarShowResets",
		"calendarShowWeeklyHolidays"
	},
	
	Camera = {
		"cameraSavedDistance",
		"cameraSavedPetBattleDistance",
		"cameraSavedPitch",
		"cameraSavedVehicleDistance",
		"cameraDistanceFixedValue",
		"cameraBobbing"
	},
	
	ExternalDefensives = {
		"externalDefensivesEnabled"
	},
	
	CombatMisc = {
		"assistAttack",
		"autoRangedCombat",
		"stopAutoAttackOnTargetChange",
		"TargetAutoEnemy",
		"TargetAutoFriend",
		"TargetAutoLock",
		"TargetEnemyAttacker"
	},
	
	UIMisc = {
		"characterFrameCollapsed",
		"equipmentManager",
		"AutoPushSpellToActionBar",
		"friendsSmallView",
		"friendsViewButtons",
		"guildNewsFilter",
		"guildRewardsCategory",
		"guildRewardsUsable",
		"miniCommunitiesFrame",
		"miniDressUpFrame",
		"consolidateBuffs",
		"previewTalentsOption",
		"collapseExpandBuffs",
		"auctionSortByBuyoutPrice",
		"auctionSortByUnitPrice",
		"showHonorAsExperience",
		"showCustomSetDetails"
	},

	-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_ChatFrameBase/Shared/ChatTypeInfoConstants.lua
	ChatTypes = {
		"SYSTEM",
		"SAY",
		"PARTY",
		"RAID",
		"GUILD",
		"OFFICER",
		"YELL",
		"WHISPER",
		"SMART_WHISPER",
		"WHISPER_INFORM",
		"REPLY",
		"EMOTE",
		"TEXT_EMOTE",
		"MONSTER_SAY",
		"MONSTER_PARTY",
		"MONSTER_YELL",
		"MONSTER_WHISPER",
		"MONSTER_EMOTE",
		"CHANNEL",
		"CHANNEL_JOIN",
		"CHANNEL_LEAVE",
		"CHANNEL_LIST",
		"CHANNEL_NOTICE",
		"CHANNEL_NOTICE_USER",
		"TARGETICONS",
		"AFK",
		"DND",
		"IGNORED",
		"SKILL",
		"LOOT",
		"CURRENCY",
		"MONEY",
		"OPENING",
		"TRADESKILLS",
		"PET_INFO",
		"COMBAT_MISC_INFO",
		"COMBAT_XP_GAIN",
		"COMBAT_HONOR_GAIN",
		"COMBAT_FACTION_CHANGE",
		"BG_SYSTEM_NEUTRAL",
		"BG_SYSTEM_ALLIANCE",
		"BG_SYSTEM_HORDE",
		"RAID_LEADER",
		"RAID_WARNING",
		"RAID_BOSS_WHISPER",
		"RAID_BOSS_EMOTE",
		"QUEST_BOSS_EMOTE",
		"FILTERED",
		"INSTANCE_CHAT",
		"INSTANCE_CHAT_LEADER",
		"RESTRICTED",
		"CHANNEL1",
		"CHANNEL2",
		"CHANNEL3",
		"CHANNEL4",
		"CHANNEL5",
		"CHANNEL6",
		"CHANNEL7",
		"CHANNEL8",
		"CHANNEL9",
		"CHANNEL10",
		"CHANNEL11",
		"CHANNEL12",
		"CHANNEL13",
		"CHANNEL14",
		"CHANNEL15",
		"CHANNEL16",
		"CHANNEL17",
		"CHANNEL18",
		"CHANNEL19",
		"CHANNEL20",
		"ACHIEVEMENT",
		"GUILD_ACHIEVEMENT",
		"PARTY_LEADER",
		"BN_WHISPER",
		"BN_WHISPER_INFORM",
		"BN_ALERT",
		"BN_BROADCAST",
		"BN_BROADCAST_INFORM",
		"BN_INLINE_TOAST_ALERT",
		"BN_INLINE_TOAST_BROADCAST",
		"BN_INLINE_TOAST_BROADCAST_INFORM",
		"BN_WHISPER_PLAYER_OFFLINE",
		"PET_BATTLE_COMBAT_LOG",
		"PET_BATTLE_INFO",
		"GUILD_ITEM_LOOTED",
		"COMMUNITIES_CHANNEL",
		"VOICE_TEXT",
		"PING"
	}
	
}