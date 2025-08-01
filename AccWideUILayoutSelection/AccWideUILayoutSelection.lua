--[[
=====================================================
Account Wide Interface Option Settings
https://github.com/NinerBull/AccWideUILayoutSelection
=====================================================
]]--

local _, L = ...;

local AccWideUI_SaveVersion = 5

local AccWideUI_Frame = CreateFrame("Frame")

local AccWideUI_Frame_HasLoadedSettings = false
local AccWideUI_Frame_HasDoneInitialLoad = false
local AccWideUI_IsCurrentlyLoadingSettings = false

local AccWideUI_OptionsPanelFrame
local AccWideUI_Category

-- Checkboxes
local chkAWISaveChatChannels
local chkAWISaveChatPosition
local debugSaveBtn
local debugLoadBtn
local chkDebugText

local function AccWideUI_ToBoolean(str)
	local bool = false
	if (str == "true" or str == true) then
		bool = true
	end
	return bool
end


AccWideUI_Frame:RegisterEvent("SETTINGS_LOADED")
AccWideUI_Frame:RegisterEvent("PLAYER_LOGOUT")
AccWideUI_Frame:RegisterEvent("CHANNEL_UI_UPDATE")
AccWideUI_Frame:RegisterEvent("DISABLE_DECLINE_GUILD_INVITE")
AccWideUI_Frame:RegisterEvent("ENABLE_DECLINE_GUILD_INVITE")
AccWideUI_Frame:RegisterEvent("LOADING_SCREEN_DISABLED")

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	AccWideUI_Frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	AccWideUI_Frame:RegisterEvent("BAG_SLOT_FLAGS_UPDATED")
	AccWideUI_Frame:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
end

local AccWideUI_TextName = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("<" .. L.ACCWUI_ADDONNAME_SHORT .. ">")
local AccWideUI_TextSlash = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("/awi")
local AccWideUI_ThisCategory = nil
local AccWideUI_DividerGraphic = "interface\\friendsframe\\ui-friendsframe-onlinedivider"

local AccWideUI_ThisPlayerName, AccWideUI_ThisPlayerRealm = UnitFullName("player") 


--Chat Channel Stuff
AccWideUI_ChatName_General = "General"
AccWideUI_ChatName_Trade = "Trade"
AccWideUI_ChatName_Services = "Services"
AccWideUI_ChatName_LocalDefense = "LocalDefense"
AccWideUI_ChatName_WorldDefense = "WorldDefense"
AccWideUI_ChatName_LookingForGroup = "LookingForGroup"
AccWideUI_ChatName_HardcoreDeaths = "HardcoreDeaths"
AccWideUI_ChatName_GuildRecruitment = "GuildRecruitment"


-- https://wago.tools/db2/ChatChannels

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_Services = C_ChatInfo.GetChannelShortcutForChannelID(42)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_WorldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then --China Wrath

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_WorldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUI_ChatName_GuildRecruitment = C_ChatInfo.GetChannelShortcutForChannelID(25)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_Services = C_ChatInfo.GetChannelShortcutForChannelID(45)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_WorldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(24)
	AccWideUI_ChatName_HardcoreDeaths = C_ChatInfo.GetChannelShortcutForChannelID(44)
	AccWideUI_ChatName_GuildRecruitment = C_ChatInfo.GetChannelShortcutForChannelID(25)

end

	

	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		
		hooksecurefunc(C_EditMode, "OnEditModeExit", function()
		
			if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
			
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = tostring(GetSpecialization())
		
				if (AccWideUI_AccountData.accountWideLayout == true) and (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Debug] Saving Chosen Edit Mode Layout.")
					end

					if (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then

						--Set the spec
						AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout
						
						AccWideUI_Frame:SaveUISettings()

					end
					
				end -- EO accountWideLayout
				
			end 
				
		end)
	
	end
	

	
	
	AccWideUI_Table_NameplateVariables = {
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
		"nameplateCommentatorMaxDistance"
	}
	
	
	
	AccWideUI_Table_RaidFrameVariables = {
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
		"threatWarning"
	}
	
	
	AccWideUI_Table_ArenaFrameVariables = {
		"showArenaEnemyCastbar",
		"showArenaEnemyFrames",
		"showArenaEnemyPets",
		"pvpOptionDisplayPets",
		"pvpFramesHealthText",
		"pvpFramesDisplayPowerBars",
		"pvpFramesDisplayClassColor",
		"pvpFramesDisplayOnlyHealerPowerBars",
	}
	
	AccWideUI_Table_BlockSocialVariables = {
		"blockChannelInvites",
		"blockTrades"
	}
	
	AccWideUI_Table_SpellOverlayVariables = {
		"displaySpellActivationOverlays",
		"spellActivationOverlayOpacity"
	}
	
	AccWideUI_Table_AutoLootVariables = {
		"autoLootDefault",
		"autoLootRate"
	}
	
	AccWideUI_Table_LossOfControlVariables = {
		"lossOfControl",
		"lossOfControlFull",
		"lossOfControlInterrupt",
		"lossOfControlRoot",
		"lossOfControlSilence"
	}
	
	AccWideUI_Table_SoftTargetVariables = {
		"SoftTargetEnemy",
		"SoftTargetEnemyArc",
		"SoftTargetEnemyRange",
		"SoftTargetForce",
		"SoftTargetFriend",
		"SoftTargetFriendArc",
		"SoftTargetFriendRange"
	}
	
	AccWideUI_Table_TutorialTooltipVariables = {
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
	}
	
	AccWideUI_Table_BattlefieldMapVariables = {
		"showBattlefieldMinimap"
	}
		
	
	AccWideUI_Table_ActionBarVariables = {
		"multiBarRightVerticalLayout"
	}
	
	AccWideUI_Table_CooldownViewerVariables = {
		"cooldownViewerEnabled"
	}
	
	AccWideUI_Table_MouseoverCastVariables = {
		"enableMouseoverCast",
		"autoSelfCast"
	}
	
	AccWideUI_Table_EmpowerTapVariables = {
		"empowerTapControls"
	}
	
	-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_ChatFrameBase/Mainline/ChatFrame.lua#L65
	AccWideUI_Table_ChatTypes = {
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
	
	
	
	
	-- Popups for first time set up
	StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP"] = {
		text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L.ACCWUI_ADDONNAME .. "\n--------------------------------") .. "\n\n" .. L.ACCWUI_FIRSTTIME_LINE1 .. "\n" .. L.ACCWUI_FIRSTTIME_LINE2,
		button1 = string.format(L.ACCWUI_FIRSTTIME_BTN1, UnitName("player")),
		button2 = L.ACCWUI_FIRSTTIME_BTN2,
		verticalButtonLayout = true,
		OnAccept  = function()
			AccWideUI_AccountData.HasDoneFirstTimeSetup = true
			AccWideUI_Frame:SaveUISettings()
			AccWideUI_Frame_HasDoneInitialLoad = true
			AccWideUI_Frame:InitializeOptionsFrame()
			AccWideUI_Frame.InitializeOptionsSettings()
			AccWideUI_AccountData.SaveVersion = AccWideUI_SaveVersion
			AccWideUI_Frame_HasLoadedSettings = true
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = tostring(GetSpecialization())
				if (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then
					AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout
				end
			end
			if (AccWideUI_AccountData.enableTextOutput == true) then
				print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LOAD_REGULAR, AccWideUI_TextSlash))	
			end
			C_Timer.After(0.1, function() 
				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP_ACCEPTED")
			end)
		end,
		OnCancel = function()
			C_Timer.After(0.1, function() 
				StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP_DECLINED")
			end)
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
	}
	
	StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP_ACCEPTED"] = {
		text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L.ACCWUI_ADDONNAME .. "\n--------------------------------") .. "\n\n" .. L.ACCWUI_FIRSTTIME_ACCEPTED_LINE1 .. "\n" .. string.format(L.ACCWUI_FIRSTTIME_ACCEPTED_LINE2, AccWideUI_TextSlash),
		button1 = OKAY,
		timeout = 0,
		sound = SOUNDKIT.GS_CHARACTER_CREATION_CREATE_CHAR,
		whileDead = true,
		hideOnEscape = false,
		
	}
	
	StaticPopupDialogs["ACCWIDEUI_FIRSTTIMEPOPUP_DECLINED"] = {
		text = FAIR_DIFFICULTY_COLOR:WrapTextInColorCode(L.ACCWUI_ADDONNAME .. "\n--------------------------------") .. "\n\n" .. L.ACCWUI_FIRSTTIME_DECLINED_LINE1,
		button1 = OKAY,
		timeout = 0,
		sound = SOUNDKIT.LOOT_WINDOW_OPEN_EMPTY,
		whileDead = true,
		hideOnEscape = false,
	}
	

	AccWideUI_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)


			if (event == "SETTINGS_LOADED") then
			
				AccWideUI_ThisPlayerName, AccWideUI_ThisPlayerRealm = UnitFullName("player")
			
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
					local getLayoutsTable = C_EditMode.GetLayouts()
					local currentActiveLayout = getLayoutsTable["activeLayout"]
					
				end		
	
	
				if (type(AccWideUI_AccountData) ~= "table") then
					AccWideUI_AccountData = {}
				end
				
				if (type(AccWideUI_AccountData.ShowDebugSettings) ~= "boolean") then
					AccWideUI_AccountData.ShowDebugSettings = false
				end
				
				if (type(AccWideUI_AccountData.printDebugTextToChat) ~= "boolean") then
					AccWideUI_AccountData.printDebugTextToChat = false
				end
				
				if (type(AccWideUI_AccountData.FirstSaved) ~= "table") then
					AccWideUI_AccountData.FirstSaved = {}
				end
				if (type(AccWideUI_AccountData.FirstSaved.Character) ~= "string") then
					AccWideUI_AccountData.FirstSaved.Character = AccWideUI_ThisPlayerName .. "-" .. AccWideUI_ThisPlayerRealm
				end
				if (type(AccWideUI_AccountData.FirstSaved.UnixTime) ~= "number") then
					AccWideUI_AccountData.FirstSaved.UnixTime = GetServerTime()
				end
				
				if (type(AccWideUI_AccountData.LastSaved) ~= "table") then
					AccWideUI_AccountData.LastSaved = {}
				end
				if (type(AccWideUI_AccountData.LastSaved.Character) ~= "string") then
					AccWideUI_AccountData.LastSaved.Character = "Unknown"
				end
				if (type(AccWideUI_AccountData.LastSaved.UnixTime) ~= "number") then
					AccWideUI_AccountData.LastSaved.UnixTime = GetServerTime()
				end
				
				if (type(AccWideUI_AccountData.printWhenLastSaved) ~= "boolean") then
					AccWideUI_AccountData.printWhenLastSaved = false
				end
				
				
				if (type(AccWideUI_AccountData.HasDoneFirstTimeSetup) ~= "boolean") then
					AccWideUI_AccountData.HasDoneFirstTimeSetup = false
				end
				
				if (type(AccWideUI_AccountData.SaveVersion) ~= "number") then
					AccWideUI_AccountData.SaveVersion = AccWideUI_SaveVersion
				end
				
				-- Upgrade from older version
				if (type(AccWideUI_AccountData.ActionBars) == "table") then
					if (type(AccWideUI_AccountData.ActionBars.Bar2) == "boolean") then
						AccWideUI_AccountData.HasDoneFirstTimeSetup = true
					end
				end
				
				if (type(AccWideUI_AccountData.SpecialVariables) ~= "table") then
					AccWideUI_AccountData.SpecialVariables = {}
				end
				
				if (type(AccWideUI_AccountData.ChatChannels) ~= "table") then
					AccWideUI_AccountData.ChatChannels = {}
				end
				
				if (type(AccWideUI_AccountData.enableAccountWide) ~= "boolean") then
					AccWideUI_AccountData.enableAccountWide = true
				end
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					if (type(AccWideUI_AccountData.accountWideLayoutID) ~= "number") then
						AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout or 1
					end
					
					if (type(AccWideUI_AccountData.accountWideLayout) ~= "boolean") then
						AccWideUI_AccountData.accountWideLayout = true
					end
				end
	
				if (type(AccWideUI_AccountData.enableTextOutput) ~= "boolean") then
					AccWideUI_AccountData.enableTextOutput = true
				end

				if (type(AccWideUI_AccountData.accountWideActionBars) ~= "boolean") then
					AccWideUI_AccountData.accountWideActionBars = true
				end
				
				if (type(AccWideUI_AccountData.accountWideNameplates) ~= "boolean") then
					AccWideUI_AccountData.accountWideNameplates = true
				end
				
				if (type(AccWideUI_AccountData.accountWideRaidFrames) ~= "boolean") then
					AccWideUI_AccountData.accountWideRaidFrames = true
				end
				
				
				if (type(AccWideUI_AccountData.accountWideBlockSocialVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideBlockSocialVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideAutoLootVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideAutoLootVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideSoftTargetVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideSoftTargetVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideTutorialTooltipVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideTutorialTooltipVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideBattlefieldMapVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideBattlefieldMapVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideMouseoverCastVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideMouseoverCastVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideEmpowerTapVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideEmpowerTapVariables = true
				end
								
				if (type(AccWideUI_AccountData.accountWideChatWindowVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideChatWindowVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideChatWindowPosition) ~= "boolean") then
					AccWideUI_AccountData.accountWideChatWindowPosition = true
				end
				
				if (type(AccWideUI_AccountData.accountWideChatChannelVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideChatChannelVariables = true
				end
				
				--Special
				if (type(AccWideUI_AccountData.SpecialVariables.BlockGuildInvites) ~= "boolean") then
					AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = GetAutoDeclineGuildInvites()
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					if (type(AccWideUI_AccountData.accountWideCooldownViewerVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideCooldownViewerVariables = true
					end
					
					if (type(AccWideUI_AccountData.accountWideLossOfControlVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideLossOfControlVariables = true
					end
					
					if (type(AccWideUI_AccountData.accountWideBagOrganisationVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideBagOrganisationVariables = false
					end
									
				end
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					if (type(AccWideUI_AccountData.accountWideArenaFrames) ~= "boolean") then
						AccWideUI_AccountData.accountWideArenaFrames = true
					end
					
					if (type(AccWideUI_AccountData.accountWideSpellOverlayVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideSpellOverlayVariables = true
					end
				end
				
				
				
				if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
				
					--Chat Channels
					if (type(AccWideUI_AccountData.ChatChannels.BlockGeneral) ~= "boolean") then
						AccWideUI_AccountData.ChatChannels.BlockGeneral = false
					end
					
					if (type(AccWideUI_AccountData.ChatChannels.BlockLocalDefense) ~= "boolean") then
						AccWideUI_AccountData.ChatChannels.BlockLocalDefense = false
					end
					
					if (type(AccWideUI_AccountData.ChatChannels.BlockTrade) ~= "boolean") then
						AccWideUI_AccountData.ChatChannels.BlockTrade = false
					end
					
					if (type(AccWideUI_AccountData.ChatChannels.BlockLookingForGroup) ~= "boolean") then
						AccWideUI_AccountData.ChatChannels.BlockLookingForGroup = false
					end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
						if (type(AccWideUI_AccountData.ChatChannels.BlockServices) ~= "boolean") then
							AccWideUI_AccountData.ChatChannels.BlockServices = false
						end
					end
					
					if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
						if (type(AccWideUI_AccountData.ChatChannels.BlockWorldDefense) ~= "boolean") then
							AccWideUI_AccountData.ChatChannels.BlockWorldDefense = false
						end
					end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
						if (type(AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment) ~= "boolean") then
							AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment = false
						end
					end
						
					if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
						if (type(AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths) ~= "boolean") then
							AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths = false
						end
					end
									
				end
				
				
				-- Action Bar Variables
				if (type(AccWideUI_AccountData.ActionBars) ~= "table") then
					AccWideUI_AccountData.ActionBars = {}
				end
				
				
				-- CVars
				if (type(AccWideUI_AccountData.ActionBars.ActionBarVariables) ~= "table") then
					AccWideUI_AccountData.ActionBars.ActionBarVariables = {}
				end
				
				
				-- Nameplates Variables
				if (type(AccWideUI_AccountData.Nameplates) ~= "table") then
					AccWideUI_AccountData.Nameplates = {}
				end
				
				
				-- Raid Frame Variables
				if (type(AccWideUI_AccountData.RaidFrames) ~= "table") then
					AccWideUI_AccountData.RaidFrames = {}
				end
	
				
				-- Block Social Variables
				if (type(AccWideUI_AccountData.BlockSocial) ~= "table") then
					AccWideUI_AccountData.BlockSocial = {}
				end
							
				
				-- Spell Overlay Variables
				if (type(AccWideUI_AccountData.SpellOverlay) ~= "table") then
					AccWideUI_AccountData.SpellOverlay = {}
				end				
				
				-- Auto Loot Variables
				if (type(AccWideUI_AccountData.AutoLoot) ~= "table") then
					AccWideUI_AccountData.AutoLoot = {}
				end	

				-- Soft Target Variables
				if (type(AccWideUI_AccountData.SoftTarget) ~= "table") then
					AccWideUI_AccountData.SoftTarget = {}
				end	
				
				-- Tutorial Variables
				if (type(AccWideUI_AccountData.TutorialTooltips) ~= "table") then
					AccWideUI_AccountData.TutorialTooltips = {}
				end
				
				-- Battlefield Map Variables
				if (type(AccWideUI_AccountData.BattlefieldMap) ~= "table") then
					AccWideUI_AccountData.BattlefieldMap = {}
				end
				
				if (type(AccWideUI_AccountData.BattlefieldMapOptions) ~= "table") then
					AccWideUI_AccountData.BattlefieldMapOptions = {}
				end
				
				-- Mouseover Cast Variables
				if (type(AccWideUI_AccountData.MouseoverCast) ~= "table") then
					AccWideUI_AccountData.MouseoverCast = {}
				end
				
					
				-- Chat Window Variables
				if (type(AccWideUI_AccountData.ChatWindows) ~= "table") then
					AccWideUI_AccountData.ChatWindows = {}
				end
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- Loss Of Control Variables
					if (type(AccWideUI_AccountData.LossOfControl) ~= "table") then
						AccWideUI_AccountData.LossOfControl = {}
					end
					
					-- Cooldown Viewer Variables
					if (type(AccWideUI_AccountData.CooldownViewer) ~= "table") then
						AccWideUI_AccountData.CooldownViewer = {}
					end
					
					-- Empower Tap Variables
					if (type(AccWideUI_AccountData.EmpowerTap) ~= "table") then
						AccWideUI_AccountData.EmpowerTap = {}
					end
					
					-- Bag Organisation Variables
					if (type(AccWideUI_AccountData.BagOrganisation) ~= "table") then
						AccWideUI_AccountData.BagOrganisation = {}
					end
					
					if (type(AccWideUI_AccountData.BagOrganisation.Bags) ~= "table") then
						AccWideUI_AccountData.BagOrganisation.Bags = {}
					end
					
					C_Timer.After(2, function() 
					
						if (type(AccWideUI_AccountData.BagOrganisation.SortBagsRightToLeft) ~= "boolean") then
							AccWideUI_AccountData.BagOrganisation.SortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
						end
						
						if (type(AccWideUI_AccountData.BagOrganisation.InsertItemsLeftToRight) ~= "boolean") then
							AccWideUI_AccountData.BagOrganisation.InsertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
						end
						
						if (type(AccWideUI_AccountData.BagOrganisation.BackpackAutosortDisabled) ~= "boolean") then
							AccWideUI_AccountData.BagOrganisation.BackpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled()
						end
						
						if (type(AccWideUI_AccountData.BagOrganisation.BackpackSellJunkDisabled) ~= "boolean") then
							AccWideUI_AccountData.BagOrganisation.BackpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled()
						end
						
						if (type(AccWideUI_AccountData.BagOrganisation.BankAutosortDisabled) ~= "boolean") then
							AccWideUI_AccountData.BagOrganisation.BankAutosortDisabled = C_Container.GetBankAutosortDisabled()
						end
						
					end)

				end
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
					-- Raid Frame Profile Settings
					if (type(AccWideUI_AccountData.RaidFrameProfiles) ~= "table") then
						AccWideUI_AccountData.RaidFrameProfiles = {}
					end
				end
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Arena Frame Variables
					if (type(AccWideUI_AccountData.ArenaFrames) ~= "table") then
						AccWideUI_AccountData.ArenaFrames = {}
					end
				end
				
				
				
				
				
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do
				
					local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame]) ~= "table") then
						AccWideUI_AccountData.ChatWindows[thisChatFrame] = {}
					end
						

				end -- eo ChatFrame
				
				
				
				
				
				
				-- Chat Types
				if (type(AccWideUI_AccountData.ChatChannelsJoined) ~= "table") then
					AccWideUI_AccountData.ChatChannelsJoined = {}
				end
				
				
				--Chat Colours Etc
				if (type(AccWideUI_AccountData.ChatInfo) ~= "table") then
					AccWideUI_AccountData.ChatInfo = {}
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

					if ((type(AccWideUI_CharData) == "table") and (AccWideUI_CharData["accWideSpec1"] == nil)) then
						AccWideUI_CharData = nil
						print(AccWideUI_TextName .. " Removed Invalid Character Data.")
					end

					if (type(AccWideUI_CharData) ~= "table") then
						AccWideUI_CharData = {
								["accWideSpec1"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec2"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec3"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec4"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec5"] = AccWideUI_AccountData.enableAccountWide --Temp Spec for fresh chars, adding just in case
						}
					end
				end
	
				
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
				
					AccWideUI_AccountData.SaveVersion = AccWideUI_SaveVersion
					AccWideUI_Frame:InitializeOptionsFrame()
					AccWideUI_Frame.InitializeOptionsSettings()
					AccWideUI_Frame_HasLoadedSettings = true
					
					if (AccWideUI_AccountData.enableTextOutput == true) then
						print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LOAD_REGULAR, AccWideUI_TextSlash))	
					end
				
				else
					StaticPopup_Show("ACCWIDEUI_FIRSTTIMEPOPUP")
				end
				
			
			end
			
			



			if (event == "LOADING_SCREEN_DISABLED" and AccWideUI_Frame_HasLoadedSettings == true and AccWideUI_Frame_HasDoneInitialLoad == false) then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Debug] Doing Initial Load.")
					end
			
					
					C_Timer.After(5, function() 
						AccWideUI_Frame:LoadUISettings()
						AccWideUI_Frame_HasDoneInitialLoad = true
					end)
					
				end
	
			end --EO Settings Loaded
			
			
			
			
			
			
			if  (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
					AccWideUI_Frame:SaveUISettings()
					AccWideUI_Frame:LoadUISettings(true)
				end
	
			end --EO Player Specialisation Changed
			
			
			
			
			-- Save all settings when logging out
			if (event == "PLAYER_LOGOUT") then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
					AccWideUI_Frame:SaveUISettings()
				end
			end
			
			
			-- Save Bag Flag Settings
			if (event == "BAG_SLOT_FLAGS_UPDATED" or event == "BANK_BAG_SLOT_FLAGS_UPDATED") then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
					if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true and AccWideUI_IsCurrentlyLoadingSettings == false) then
						AccWideUI_Frame:SaveBagFlagSettings(true)
					end
				end
			end
			
			
			--Save Block Guild Setting with these 2
			if (event == "DISABLE_DECLINE_GUILD_INVITE") then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
					AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = false
				end
			end
			
			if (event == "ENABLE_DECLINE_GUILD_INVITE") then
				if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
					AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = true
				end
			end
			
			
			
			if (event == "CHANNEL_UI_UPDATE" and AccWideUI_Frame_HasLoadedSettings == true) then
				if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
				
					if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then

						-- Remove player from channels if they're blocked
						
						if (AccWideUI_AccountData.ChatChannels.BlockGeneral == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_General))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_General)
								print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_General, AccWideUI_TextSlash))	
							end
						end
						
						if (AccWideUI_AccountData.ChatChannels.BlockLocalDefense == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_LocalDefense))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_LocalDefense)
								print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_LocalDefense, AccWideUI_TextSlash))	
							end
						end
						
						if (AccWideUI_AccountData.ChatChannels.BlockTrade == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_Trade))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_Trade)
								print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_Trade, AccWideUI_TextSlash))	
							end
						end
						
						if (AccWideUI_AccountData.ChatChannels.BlockLookingForGroup == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_LookingForGroup))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_LookingForGroup)
								print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_LookingForGroup, AccWideUI_TextSlash))	
							end
						end
						
						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
							if (AccWideUI_AccountData.ChatChannels.BlockServices == true) then
								if (GetChannelName((GetChannelName(AccWideUI_ChatName_Services))) > 0) then
									LeaveChannelByName(AccWideUI_ChatName_Services)
									print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_Services, AccWideUI_TextSlash))	
								end
							end
						end
						
						if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
							if (AccWideUI_AccountData.ChatChannels.BlockWorldDefense == true) then
								if (GetChannelName((GetChannelName(AccWideUI_ChatName_WorldDefense))) > 0) then
									LeaveChannelByName(AccWideUI_ChatName_WorldDefense)
									print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_WorldDefense, AccWideUI_TextSlash))	
								end
							end
						end
						
						
						if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
							if (AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment == true) then
								if (GetChannelName((GetChannelName(AccWideUI_ChatName_GuildRecruitment))) > 0) then
									LeaveChannelByName(AccWideUI_ChatName_GuildRecruitment)
									print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_GuildRecruitment, AccWideUI_TextSlash))	
								end
							end
						end
							
						if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
							if (AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths == true) then
								if (GetChannelName((GetChannelName(AccWideUI_ChatName_HardcoreDeaths))) > 0) then
									LeaveChannelByName(AccWideUI_ChatName_HardcoreDeaths)
									print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LEAVING_CHANNEL, AccWideUI_ChatName_HardcoreDeaths, AccWideUI_TextSlash))	
								end
							end
						end	
				
				end
			
			end
			
		end
		

	end)

	function AccWideUI_Frame:InitializeOptionsFrame()
		
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
	
	
			AccWideUI_OptionsPanelFrame = CreateFrame("Frame");
			
			AccWideUI_Category = Settings.RegisterCanvasLayoutCategory(AccWideUI_OptionsPanelFrame, L.ACCWUI_ADDONNAME)
			Settings.RegisterAddOnCategory(AccWideUI_Category)
			
			AccWideUI_OptionsPanelFrameCategoryID = AccWideUI_Category:GetID()
			
		end
	
	
	end


	function AccWideUI_Frame:InitializeOptionsSettings()
	
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
			
			local thisPointX = 10
			local thisPointY = -10

			--Title
			local title = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			title:SetJustifyV('TOP')
			title:SetJustifyH('LEFT')
			title:SetPoint('TOPLEFT', thisPointX, thisPointY)
			title:SetText(L.ACCWUI_ADDONNAME)
			
			thisPointY = thisPointY - 16
			
			--Title2
			local title2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			title2:SetJustifyV('TOP')
			title2:SetJustifyH('LEFT')
			title2:SetPoint('TOPLEFT', thisPointX, thisPointY)
			title2:SetText(L.ACCWUI_OPT_TITLE_DESC)
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

				thisPointY = thisPointY - 16
				
				
				--Enable by Default
				local chkAWIEnableDefault = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIEnableDefault:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIEnableDefault.Text:SetText(L.ACCWUI_OPT_CHK_EDITMODE)
				chkAWIEnableDefault:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableAccountWide = chkAWIEnableDefault:GetChecked()
				end)
				chkAWIEnableDefault:SetChecked(AccWideUI_AccountData.enableAccountWide)
				
				thisPointX = 360
				
				thisPointY = thisPointY - 2
				
				-- Add shortcut to Edit Mode
				local b1 = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
				b1:SetSize(140 ,20)
				b1:SetText(L.ACCWUI_OPT_BTN_EDITMODE)
				b1:SetPoint("TOPLEFT",thisPointX, thisPointY)
				b1:SetScript("OnClick", function()
					if SettingsPanel:IsShown() then
						HideUIPanel(SettingsPanel)
					end
					ShowUIPanel(EditModeManagerFrame)
				end)
		
			end
			
			
			thisPointY = thisPointY - 22
			
			thisPointX = 10
			
			-- Show Text
			local chkAWIShowText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWIShowText:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWIShowText.Text:SetText(L.ACCWUI_OPT_CHK_TOCHAT)
			chkAWIShowText:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableTextOutput = chkAWIShowText:GetChecked()
			end)
			chkAWIShowText:SetChecked(AccWideUI_AccountData.enableTextOutput)
			
			
			thisPointX = 260
			
			
			-- Show When Last Saved
			local chkAWIShowLastSaved = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWIShowLastSaved:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWIShowLastSaved.Text:SetText(L.ACCWUI_OPT_CHK_SHOWLASTSAVED)
			chkAWIShowLastSaved:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.printWhenLastSaved = chkAWIShowLastSaved:GetChecked()
			end)
			chkAWIShowLastSaved:SetChecked(AccWideUI_AccountData.printWhenLastSaved)
			
			
			
			
			thisPointX = 10
			
			thisPointY = thisPointY - 30
			
			local acBorder1 = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
			acBorder1:SetHeight(8)
			acBorder1:SetPoint("TOPLEFT", thisPointX, thisPointY)
			acBorder1:SetPoint("RIGHT", thisPointX, 0)
			acBorder1:SetTexture(AccWideUI_DividerGraphic)

			
			thisPointY = thisPointY - 16
			
	
			
			--Title for Which Save Options
			local titleSA = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			titleSA:SetJustifyV('TOP')
			titleSA:SetJustifyH('LEFT')
			titleSA:SetPoint('TOPLEFT', thisPointX, thisPointY)
			titleSA:SetText(L.ACCWUI_OPT_MODULES_TITLE)
			
			
			thisPointY = thisPointY - 22
			

			
			--Title for  Which Save Options 2
			local titleSA2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			titleSA2:SetJustifyV('TOP')
			titleSA2:SetJustifyH('LEFT')
			titleSA2:SetPoint('TOPLEFT', thisPointX, thisPointY)
			titleSA2:SetText(L.ACCWUI_OPT_MODULES_DESC)
			
			local thisPointY2 = thisPointY
			local thisPointY3 = thisPointY
			
			
			
			
			
			-- 1st Column

			thisPointY = thisPointY - 22 
			
			
			-- Save Action Bars
			local chkAWISaveActionBar = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveActionBar:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveActionBar.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_ACTIONBARS)
			chkAWISaveActionBar:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideActionBars = chkAWISaveActionBar:GetChecked()
			end)
			chkAWISaveActionBar:SetChecked(AccWideUI_AccountData.accountWideActionBars)
			
			thisPointY = thisPointY - 22 
			
	
			-- Save Raid Frames
			local chkAWISaveRaidFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveRaidFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveRaidFrames.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_PARTYRAID)
			chkAWISaveRaidFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideRaidFrames = chkAWISaveRaidFrames:GetChecked()
			end)
			chkAWISaveRaidFrames:SetChecked(AccWideUI_AccountData.accountWideRaidFrames)
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY = thisPointY - 22 
				
				-- Save Arena Frames
				local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWISaveArenaFrames.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_ARENA)
				chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideArenaFrames = chkAWISaveArenaFrames:GetChecked()
				end)
				chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideArenaFrames)
			end
			
					
			
			thisPointY = thisPointY - 22 
			
			-- Auto Loot Variables
			local chkAWISaveAutoLoot = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveAutoLoot:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveAutoLoot.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_AUTOLOOT)
			chkAWISaveAutoLoot:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideAutoLootVariables = chkAWISaveAutoLoot:GetChecked()
			end)
			chkAWISaveAutoLoot:SetChecked(AccWideUI_AccountData.accountWideAutoLootVariables)
			
			
			thisPointY = thisPointY - 22 
			
			
			-- Save Chat Window
			local chkAWISaveChatWindow = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveChatWindow:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveChatWindow.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_CHATWINDOW)
			chkAWISaveChatWindow:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatWindowVariables = chkAWISaveChatWindow:GetChecked()
					
					if (chkAWISaveChatWindow:GetChecked() == true) then
						chkAWISaveChatChannels:Enable()
						chkAWISaveChatPosition:Enable()
					else
						chkAWISaveChatChannels:Disable()
						chkAWISaveChatPosition:Disable()
					end
			end)
			chkAWISaveChatWindow:SetChecked(AccWideUI_AccountData.accountWideChatWindowVariables)
			
			thisPointY = thisPointY - 22 
			
			
			-- Save Chat Position
			chkAWISaveChatPosition = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveChatPosition:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveChatPosition.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_CHATPOSITION)
			chkAWISaveChatPosition:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatWindowPosition = chkAWISaveChatPosition:GetChecked()
			end)
			chkAWISaveChatPosition:SetChecked(AccWideUI_AccountData.accountWideChatWindowPosition)
			
			thisPointY = thisPointY - 22 
			
			
			-- Save Chat Channels
			chkAWISaveChatChannels = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveChatChannels:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveChatChannels.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_CHATCHANNELS)
			chkAWISaveChatChannels:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatChannelVariables = chkAWISaveChatChannels:GetChecked()
			end)
			chkAWISaveChatChannels:SetChecked(AccWideUI_AccountData.accountWideChatChannelVariables)
			
			
			
			if (AccWideUI_AccountData.accountWideChatWindowVariables == true) then
				chkAWISaveChatChannels:Enable()
				chkAWISaveChatPosition:Enable()
			else
				chkAWISaveChatChannels:Disable()
				chkAWISaveChatPosition:Disable()
			end
			
			
			
			
			
			
			
			
			
			
			
			
			-- 2nd Column
			
			thisPointX = 220
			
			
			thisPointY2 = thisPointY2 - 22 
			
			-- Save Nameplates
			local chkAWISaveNameplates = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveNameplates:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveNameplates.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_NAMEPLATES)
			chkAWISaveNameplates:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideNameplates = chkAWISaveNameplates:GetChecked()
			end)
			chkAWISaveNameplates:SetChecked(AccWideUI_AccountData.accountWideNameplates)
			

			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY2 = thisPointY2 - 22 
				
				-- Spell Overlay Variables
				local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkAWISaveArenaFrames.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY)
				chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideSpellOverlayVariables = chkAWISaveArenaFrames:GetChecked()
				end)
				chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideSpellOverlayVariables)
			end
			
			
	
			


			thisPointY2 = thisPointY2 - 22 
			
			-- Soft Target Variables
			local chkAWISaveSoftTarget = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveSoftTarget:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveSoftTarget.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_TARGETING)
			chkAWISaveSoftTarget:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideSoftTargetVariables = chkAWISaveSoftTarget:GetChecked()
			end)
			chkAWISaveSoftTarget:SetChecked(AccWideUI_AccountData.accountWideSoftTargetVariables)
			
			
			
			thisPointY2 = thisPointY2 - 22 
			
			-- Tutorial Variables
			local chkAWISaveTutorials = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveTutorials:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveTutorials.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP)
			chkAWISaveTutorials:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideTutorialTooltipVariables = chkAWISaveTutorials:GetChecked()
			end)
			chkAWISaveTutorials:SetChecked(AccWideUI_AccountData.accountWideTutorialTooltipVariables)
			
			
			
			thisPointY2 = thisPointY2 - 22 
			
			-- Zone Map Variables
			local chiAWISaveBattlefieldMap = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chiAWISaveBattlefieldMap:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chiAWISaveBattlefieldMap.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_BTLMAP)
			chiAWISaveBattlefieldMap:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideBattlefieldMapVariables = chiAWISaveBattlefieldMap:GetChecked()
			end)
			chiAWISaveBattlefieldMap:SetChecked(AccWideUI_AccountData.accountWideBattlefieldMapVariables)
			
			
			
			
			thisPointY2 = thisPointY2 - 22 
		
			-- Save Mouseover/Self Cast Variables
			local chkAWISaveMouseoverCast = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveMouseoverCast:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveMouseoverCast.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_MOUSEOVER)
			chkAWISaveMouseoverCast:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideMouseoverCastVariables = chkAWISaveMouseoverCast:GetChecked()
			end)
			chkAWISaveMouseoverCast:SetChecked(AccWideUI_AccountData.accountWideMouseoverCastVariables)
			

			
			
			thisPointY2 = thisPointY2 - 22 
							
			-- Block Social Variables
			local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveArenaFrames.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_TRADEGUILD)
			chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideBlockSocialVariables = chkAWISaveArenaFrames:GetChecked()
			end)
			chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideBlockSocialVariables)
			
						
						
			
			
			
			
			
			
			if (thisPointY2 < thisPointY) then
				thisPointY = thisPointY2
			end
			
			
			
			
			-- 3rd Column
			
			thisPointX = 440
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				thisPointY3 = thisPointY3 - 22 
			
				-- Save Edit Mode Layout
				local chkAWISaveEditModeLayout = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveEditModeLayout:SetPoint("TOPLEFT", thisPointX, thisPointY3)
				chkAWISaveEditModeLayout.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_EDITMODE)
				chkAWISaveEditModeLayout:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLayout = chkAWISaveEditModeLayout:GetChecked()
				end)
				chkAWISaveEditModeLayout:SetChecked(AccWideUI_AccountData.accountWideLayout)
		
		
				thisPointY3 = thisPointY3 - 22 
			
				-- Save Cooldown Viewer Setting
				local chkAWISaveCooldownViewer = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveCooldownViewer:SetPoint("TOPLEFT", thisPointX, thisPointY3)
				chkAWISaveCooldownViewer.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_COOLDOWN)
				chkAWISaveCooldownViewer:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideCooldownViewerVariables = chkAWISaveCooldownViewer:GetChecked()
				end)
				chkAWISaveCooldownViewer:SetChecked(AccWideUI_AccountData.accountWideCooldownViewerVariables)
		
				
				thisPointY3 = thisPointY3 - 22 
			
				-- Save Loss of Control Variables
				local chkAWISaveLossOfControl = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveLossOfControl:SetPoint("TOPLEFT", thisPointX, thisPointY3)
				chkAWISaveLossOfControl.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_LOC)
				chkAWISaveLossOfControl:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLossOfControlVariables = chkAWISaveLossOfControl:GetChecked()
				end)
				chkAWISaveLossOfControl:SetChecked(AccWideUI_AccountData.accountWideLossOfControlVariables)
				
				
				thisPointY3 = thisPointY3 - 22 
			
				-- Save Empowered Tap/Hold Variables
				local chkAWISaveEmpoweredTap = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveEmpoweredTap:SetPoint("TOPLEFT", thisPointX, thisPointY3)
				chkAWISaveEmpoweredTap.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_EMPOWERED)
				chkAWISaveEmpoweredTap:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideEmpowerTapVariables = chkAWISaveEmpoweredTap:GetChecked()
				end)
				chkAWISaveEmpoweredTap:SetChecked(AccWideUI_AccountData.accountWideEmpowerTapVariables)
				
				
				thisPointY3 = thisPointY3 - 22 
				
				-- Save Bag Organisation Settings
				local chkAWISaveBagSettings = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveBagSettings:SetPoint("TOPLEFT", thisPointX, thisPointY3)
				chkAWISaveBagSettings.Text:SetText(L.ACCWUI_OPT_MODULES_CHK_BAGS)
				chkAWISaveBagSettings:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideBagOrganisationVariables = chkAWISaveBagSettings:GetChecked()
						if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true and AccWideUI_IsCurrentlyLoadingSettings == false) then
							AccWideUI_Frame:SaveBagFlagSettings(true)
						end
						
				end)
				chkAWISaveBagSettings:SetChecked(AccWideUI_AccountData.accountWideBagOrganisationVariables)
				

			
			end
			

			
			
			if (thisPointY3 < thisPointY) then
				thisPointY = thisPointY3
			end
			
			
			
			
			
			
			--Chat Channels
			
			if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
				
				thisPointX = 10
				
				thisPointY = thisPointY - 30
				
				thisPointYPlus = 128
				
			
				local acBorder2 = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
				acBorder2:SetHeight(8)
				acBorder2:SetPoint("TOPLEFT", thisPointX, thisPointY)
				acBorder2:SetPoint("RIGHT", thisPointX, 0)
				acBorder2:SetTexture(AccWideUI_DividerGraphic)
				

				
				thisPointY = thisPointY - 16
				
				
				
				--Title for Chat Channels
				local titleCAA = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				titleCAA:SetJustifyV('TOP')
				titleCAA:SetJustifyH('LEFT')
				titleCAA:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCAA:SetText(L.ACCWUI_BLOCKBLIZZ_TITLE)
				
				
				thisPointY = thisPointY - 22
				
				
				--Title for  Chat Channels2
				local titleCAA2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				titleCAA2:SetJustifyV('TOP')
				titleCAA2:SetJustifyH('LEFT')
				titleCAA2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCAA2:SetText(L.ACCWUI_BLOCKBLIZZ_DESC)
				
				thisPointY = thisPointY - 22
				
				
				
				-- General Chat
				local chkAWIBlockGeneralChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIBlockGeneralChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIBlockGeneralChat.Text:SetText(AccWideUI_ChatName_General)
				chkAWIBlockGeneralChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockGeneral = chkAWIBlockGeneralChat:GetChecked()
				end)
				chkAWIBlockGeneralChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockGeneral)
				
				thisPointX = thisPointX + thisPointYPlus
				
				
				
				-- Trade Chat
				local chkAWIBlockTradeChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIBlockTradeChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIBlockTradeChat.Text:SetText(AccWideUI_ChatName_Trade)
				chkAWIBlockTradeChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockTrade = chkAWIBlockTradeChat:GetChecked()
				end)
				chkAWIBlockTradeChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockTrade)
				
				thisPointX = thisPointX + thisPointYPlus
				
			
			
				-- LocalDefense Chat
				local chkAWIBlockLocalDefenseChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIBlockLocalDefenseChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIBlockLocalDefenseChat.Text:SetText(AccWideUI_ChatName_LocalDefense)
				chkAWIBlockLocalDefenseChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockLocalDefense = chkAWIBlockLocalDefenseChat:GetChecked()
				end)
				chkAWIBlockLocalDefenseChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockLocalDefense)
				
				thisPointX = thisPointX + thisPointYPlus
				
				
				
				-- LookingForGroup Chat
				local chkAWIBlockLookingForGroup = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIBlockLookingForGroup:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIBlockLookingForGroup.Text:SetText(AccWideUI_ChatName_LookingForGroup)
				chkAWIBlockLookingForGroup:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockLookingForGroup = chkAWIBlockLookingForGroup:GetChecked()
				end)
				chkAWIBlockLookingForGroup:SetChecked(AccWideUI_AccountData.ChatChannels.BlockLookingForGroup)
				
				
				
				thisPointX = 10
				
				thisPointY = thisPointY - 22
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
					-- Services Chat
					local chkAWIBlockServicesChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIBlockServicesChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIBlockServicesChat.Text:SetText(AccWideUI_ChatName_Services)
					chkAWIBlockServicesChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockServices = chkAWIBlockServicesChat:GetChecked()
					end)
					chkAWIBlockServicesChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockServices)
					
					thisPointX = thisPointX + thisPointYPlus
				end
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
					-- WorldDefense Chat
					local chkAWIBlockWorldDefenseChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIBlockWorldDefenseChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIBlockWorldDefenseChat.Text:SetText(AccWideUI_ChatName_WorldDefense)
					chkAWIBlockWorldDefenseChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockWorldDefense = chkAWIBlockWorldDefenseChat:GetChecked()
					end)
					chkAWIBlockWorldDefenseChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockWorldDefense)
					
					thisPointX = thisPointX + thisPointYPlus
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- ChromieTime Chat
					local chkAWIBlockChromieTimeChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIBlockChromieTimeChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIBlockChromieTimeChat.Text:SetText(AccWideUI_ChatName_WorldDefense)
					chkAWIBlockChromieTimeChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockChromieTime = chkAWIBlockChromieTimeChat:GetChecked()
					end)
					chkAWIBlockChromieTimeChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockChromieTime)
					
					thisPointX = thisPointX + thisPointYPlus
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
					-- GuildRecruitment Chat
					local chkAWIBlockGuildRecruitmentChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIBlockGuildRecruitmentChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIBlockGuildRecruitmentChat.Text:SetText(AccWideUI_ChatName_GuildRecruitment)
					chkAWIBlockGuildRecruitmentChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment = chkAWIBlockGuildRecruitmentChat:GetChecked()
					end)
					chkAWIBlockGuildRecruitmentChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockGuildRecruitment)
					
					thisPointX = thisPointX + thisPointYPlus
				end
				
					
				if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
					-- HardcoreDeaths Chat
					local chkAWIBlockHardcoreDeathsChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIBlockHardcoreDeathsChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIBlockHardcoreDeathsChat.Text:SetText(AccWideUI_ChatName_HardcoreDeaths)
					chkAWIBlockHardcoreDeathsChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths = chkAWIBlockHardcoreDeathsChat:GetChecked()
					end)
					chkAWIBlockHardcoreDeathsChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockHardcoreDeaths)
					
					thisPointX = thisPointX + thisPointYPlus
				end
				
				
				
				
				
				
				
				
				
				
				
				
			
			end
			
			
			
			
			
			
			thisPointX = 10

			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				--[[if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
					thisPointY = -470
				else
					thisPointY = -354
				end]]
				
				thisPointY = thisPointY - 30
				
				
				local acBorder3 = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
				acBorder3:SetHeight(8)
				acBorder3:SetPoint("TOPLEFT", thisPointX, thisPointY)
				acBorder3:SetPoint("RIGHT", thisPointX, 0)
				acBorder3:SetTexture(AccWideUI_DividerGraphic)
				
				
				thisPointY = thisPointY - 16
		
				
				local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
				
				
				--Title for Char Specific
				local titleCS = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				titleCS:SetJustifyV('TOP')
				titleCS:SetJustifyH('LEFT')
				titleCS:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCS:SetText(string.format(L.ACCWUI_CHARSPECIFIC_TITLE, classColorString:WrapTextInColorCode(UnitName("player"))))
				
				thisPointY = thisPointY - 22
				
				--Title for Char Specific2
				local titleCS2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				titleCS2:SetJustifyV('TOP')
				titleCS2:SetJustifyH('LEFT')
				titleCS2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCS2:SetText(L.ACCWUI_CHARSPECIFIC_DESC)
			

			
			
				--Specialisations
				AccWideUI_SpecName = {}
				AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

				for specx = 1, AccWideUI_NumSpecializations, 1 do
					AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
					
				end
				
				thisPointY = thisPointY - 22
					

				if (AccWideUI_NumSpecializations >= 1) then
				
					
				
					local chkAWIEnableSpec1 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIEnableSpec1:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIEnableSpec1.Text:SetText(AccWideUI_SpecName[1])
					chkAWIEnableSpec1:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 1] = chkAWIEnableSpec1:GetChecked()
					end)
					chkAWIEnableSpec1:SetChecked(AccWideUI_CharData["accWideSpec" .. 1])

				end
				
				if (AccWideUI_NumSpecializations >= 2) then
				
					thisPointX = thisPointX + 128
				
					local chkAWIEnableSpec2 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIEnableSpec2:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIEnableSpec2.Text:SetText(AccWideUI_SpecName[2])
					chkAWIEnableSpec2:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 2] = chkAWIEnableSpec2:GetChecked()
					end)
					chkAWIEnableSpec2:SetChecked(AccWideUI_CharData["accWideSpec" .. 2])

				end
				
				if (AccWideUI_NumSpecializations >= 3) then
				
					thisPointX = thisPointX + 128
				
					local chkAWIEnableSpec3 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIEnableSpec3:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIEnableSpec3.Text:SetText(AccWideUI_SpecName[3])
					chkAWIEnableSpec3:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 3] = chkAWIEnableSpec3:GetChecked()
					end)
					chkAWIEnableSpec3:SetChecked(AccWideUI_CharData["accWideSpec" .. 3])

				end
				
				if (AccWideUI_NumSpecializations >= 4) then
				
					thisPointX = thisPointX + 128
				
					local chkAWIEnableSpec4 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIEnableSpec4:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIEnableSpec4.Text:SetText(AccWideUI_SpecName[4])
					chkAWIEnableSpec4:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 4] = chkAWIEnableSpec4:GetChecked()
					end)
					chkAWIEnableSpec4:SetChecked(AccWideUI_CharData["accWideSpec" .. 4])

				end
				
				if (AccWideUI_NumSpecializations >= 5) then
				
					thisPointX = thisPointX + 128
				
					local chkAWIEnableSpec5 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkAWIEnableSpec5:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkAWIEnableSpec5.Text:SetText(AccWideUI_SpecName[5])
					chkAWIEnableSpec5:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 5] = chkAWIEnableSpec5:GetChecked()
					end)
					chkAWIEnableSpec5:SetChecked(AccWideUI_CharData["accWideSpec" .. 5])

				end
				
			
			end
			
			
			
			--Debug
			
			
			--[[local acBorderD = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
			acBorderD:SetHeight(8)
			acBorderD:SetPoint("BOTTOMRIGHT", -10, 35)
			acBorderD:SetPoint("RIGHT", -200, 0)
			acBorderD:SetTexture(AccWideUI_DividerGraphic)]]
			
			
			local chkShowDebugSettings = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkShowDebugSettings:SetPoint("BOTTOMLEFT", 10, 5)
				chkShowDebugSettings.Text:SetText(DARKGRAY_COLOR:WrapTextInColorCode(L.ACCWUI_DEBUG_CHK_SHOWDEBUGOPTIONS))
				chkShowDebugSettings:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.ShowDebugSettings	= chkShowDebugSettings:GetChecked()
					
					AccWideUI_Frame:ToggleShowDebugSettings()
					
				end)
				chkShowDebugSettings:SetChecked(AccWideUI_AccountData.ShowDebugSettings)
			
			
			debugSaveBtn = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
				debugSaveBtn:SetSize(100 ,20)
				debugSaveBtn:SetText(L.ACCWUI_DEBUG_BTN_FORCESAVE)
				debugSaveBtn:SetPoint("BOTTOMRIGHT", -10, 10)
				debugSaveBtn:SetScript("OnClick", function()
					print(AccWideUI_TextName .. " " .. L.ACCWUI_DEBUG_TXT_FORCESAVE)
					 AccWideUI_Frame:SaveUISettings()
					
				end)
				
				
			debugLoadBtn = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
				debugLoadBtn:SetSize(100 ,20)
				debugLoadBtn:SetText(L.ACCWUI_DEBUG_BTN_FORCELOAD)
				debugLoadBtn:SetPoint("BOTTOMRIGHT", -110, 10)
				debugLoadBtn:SetScript("OnClick", function()
					print(AccWideUI_TextName .. " " .. L.ACCWUI_DEBUG_TXT_FORCELOAD)
					 AccWideUI_Frame:LoadUISettings()
					
				end)
				
			chkDebugText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkDebugText:SetPoint("BOTTOMRIGHT", -310, 5)
				chkDebugText.Text:SetText(L.ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT)
				chkDebugText:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.printDebugTextToChat = chkDebugText:GetChecked()
				end)
				chkDebugText:SetChecked(AccWideUI_AccountData.printDebugTextToChat)


			--- <3
			local colorPet = CreateColor(0.25, 0.25, 0.25)
			local titlePet = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlightSmall")
			titlePet:SetJustifyV('TOP')
			titlePet:SetJustifyH('RIGHT')
			titlePet:SetPoint('TOPRIGHT', -20, -5)
			titlePet:SetText(colorPet:WrapTextInColorCode(GAME_VERSION_LABEL .. " " .. C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "Version") .. " - Dedicated to Petrel <3"))
		
		
		
		
			AccWideUI_Frame:ToggleShowDebugSettings()
			
			SLASH_ACCWIDEUI1 = "/accwideui"
			SLASH_ACCWIDEUI2 = "/accwideeditmode"
			SLASH_ACCWIDEUI3 = "/accwideinterface"
			SLASH_ACCWIDEUI4 = "/accwide"
			SLASH_ACCWIDEUI5 = "/awi"
			function SlashCmdList.ACCWIDEUI(msg)
				Settings.OpenToCategory(AccWideUI_OptionsPanelFrameCategoryID)
			end
			
		end
		
	end





	
	function AccWideUI_Frame:LoadUISettings(doNotLoadChatOrBagSettings)
	
		local LoadUIAllowSaveTime = 36
		
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
	
			doNotLoadChatOrBagSettings = doNotLoadChatOrBagSettings or false
			AccWideUI_IsCurrentlyLoadingSettings = true
			
				if (AccWideUI_AccountData.printWhenLastSaved == true) then
					print(AccWideUI_TextName .. " " .. string.format(L.ACCWUI_LOAD_LASTUPDATED, LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(AccWideUI_AccountData.LastSaved.Character), LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(date("%Y-%m-%d %H:%M", AccWideUI_AccountData.LastSaved.UnixTime))))
				end

			
				if (AccWideUI_AccountData.printDebugTextToChat == true) then
					print(AccWideUI_TextName .. " [Debug] Loading UI Settings.")
				end
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					-- Use Acc Wide Layout
					local currentSpec = tostring(GetSpecialization())
					
					if (AccWideUI_AccountData.accountWideLayout == true) and (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then
					

						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Debug] Loading Chosen Edit Mode Layout.")
						end

						--Set the spec
						C_EditMode.SetActiveLayout(AccWideUI_AccountData.accountWideLayoutID)
				
					
					end -- eo accountWideLayout

				end
				
				-- Use Action Bars
				if (AccWideUI_AccountData.accountWideActionBars == true) then
						
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Action Bars] Loading Settings.")
					end
					
					
					for k, v in pairs(AccWideUI_Table_ActionBarVariables) do
						SetCVar(v, AccWideUI_AccountData.ActionBars.ActionBarVariables[v])
					end
					
					if (type(AccWideUI_AccountData.ActionBars) == "table") then
					
						if (type(AccWideUI_AccountData.ActionBars.Bar2) == "boolean") then
						
							C_Timer.After(4, function() 
						
								if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
									
									SetActionBarToggles(AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5, AccWideUI_AccountData.ActionBars.Bar6, AccWideUI_AccountData.ActionBars.Bar7, AccWideUI_AccountData.ActionBars.Bar8)
								
								else
								
									SetActionBarToggles(AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5)
								
								end
							
							end)
						
						end
						
					end
					
					C_Timer.After(5, function() 
						MultiActionBar_Update()
					end)
				
				end -- EO accountWideActionBars


				-- Use Nameplates
				if (AccWideUI_AccountData.accountWideNameplates == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Nameplates] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_NameplateVariables) do
						SetCVar(v, AccWideUI_AccountData.Nameplates[v])
					end
				
				end -- EO accountWideNameplates
				
				
				
				-- Use Raid Frames
				if (AccWideUI_AccountData.accountWideRaidFrames == true) then
			
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Raid Frames] Loading Settings.")
					end
					
					
					C_Timer.After(4, function() 
					
						for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
							SetCVar(v, AccWideUI_AccountData.RaidFrames[v])
						end
					
						if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
						
							--How many Raid Profiles?
							
							local ThisNumRaidProfilesSaved = 0
							local HasSetRaidFramesActive = false
							local NamesOfSavedRaidProfiles = {}
							
							
							if (type(AccWideUI_AccountData.RaidFrameProfiles) == "table") then
								for key, value in pairs(AccWideUI_AccountData.RaidFrameProfiles) do 
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
										if (AccWideUI_AccountData.printDebugTextToChat == true) then
											print(AccWideUI_TextName .. " [Raid Frames] Deleting Old Raid Profile with Name " .. thisProfileName .. ".")
										end
										DeleteRaidProfile(thisProfileName)
									end
								
								end
							
								--Create/Update Raid Profiles
								for i=1, GetMaxNumCUFProfiles() do
										
									if (type(AccWideUI_AccountData.RaidFrameProfiles[i]) == "table") then
										if (type(AccWideUI_AccountData.RaidFrameProfiles[i].name) == "string") then
										
											--table.insert(NamesOfSavedRaidProfiles, AccWideUI_AccountData.RaidFrameProfiles[i].name)

											if (RaidProfileExists(AccWideUI_AccountData.RaidFrameProfiles[i].name) == false) then
												CreateNewRaidProfile(AccWideUI_AccountData.RaidFrameProfiles[i].name)
												
												if (AccWideUI_AccountData.printDebugTextToChat == true) then
													print(AccWideUI_TextName .. " [Raid Frames] Creating Raid Profile with Name " .. AccWideUI_AccountData.RaidFrameProfiles[i].name .. ".")
												end
												
											else
												if (AccWideUI_AccountData.printDebugTextToChat == true) then
													print(AccWideUI_TextName .. " [Raid Frames] Using Existing Raid Profile with Name " .. AccWideUI_AccountData.RaidFrameProfiles[i].name .. ".")
												end
											
											end
											
											SetRaidProfileSavedPosition(
												AccWideUI_AccountData.RaidFrameProfiles[i].name,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.isDynamic,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.topPoint,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.topOffset,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.bottomPoint,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.bottomOffset,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.leftPoint,
												AccWideUI_AccountData.RaidFrameProfiles[i].position.leftOffset
											)
											
											for k, v in pairs(AccWideUI_AccountData.RaidFrameProfiles[i].options) do
												SetRaidProfileOption(AccWideUI_AccountData.RaidFrameProfiles[i].name, tostring(k), v)
											end
													
											if (AccWideUI_AccountData.RaidFrameProfiles[i].isActive == true) then
												CompactUnitFrameProfiles_ActivateRaidProfile(AccWideUI_AccountData.RaidFrameProfiles[i].name)
												HasSetRaidFramesActive = true
											end
									
										end
									end
					
								end
								
							end
							
							
							
							
							--Fallback incase no raid frames profiles are set up.
							if (GetNumRaidProfiles() == 0) then
								if (AccWideUI_AccountData.printDebugTextToChat == true) then
									print(AccWideUI_TextName .. " [Raid Frames] No Raid Profiles found, resetting.")
								end
								CompactUnitFrameProfiles_ResetToDefaults()
							end
							
							--Fallback in case none of the profiles are set active for some reason.
							if (HasSetRaidFramesActive == false) then
								CompactUnitFrameProfiles_ActivateRaidProfile(GetRaidProfileName(1))
							end
							

					end
					
					
				end)
					
					
		
					
				
				end -- EO accountWideRaidFrames
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Use Arena Frames
					if (AccWideUI_AccountData.accountWideArenaFrames == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Arena Frames] Loading Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
							SetCVar(v, AccWideUI_AccountData.ArenaFrames[v])
						end
					
					end -- EO accountWideArenaFrames
				end
				
				
				-- Block Social Variables
				if (AccWideUI_AccountData.accountWideBlockSocialVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Social] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_BlockSocialVariables) do
						SetCVar(v, AccWideUI_AccountData.BlockSocial[v])
					end
					
					
					--Special
					SetAutoDeclineGuildInvites(AccWideUI_AccountData.SpecialVariables.BlockGuildInvites)
				
				end -- EO accountWideBlockSocialVariables
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Spell Overlay Variables
					if (AccWideUI_AccountData.accountWideSpellOverlayVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Spell Overlay] Loading Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_SpellOverlayVariables) do
							SetCVar(v, AccWideUI_AccountData.SpellOverlay[v])
						end
					
					end -- EO accountWideSpellOverlayVariables
				end
				
				
				-- Auto Loot Variables
				if (AccWideUI_AccountData.accountWideAutoLootVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Auto Loot] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_AutoLootVariables) do
						SetCVar(v, AccWideUI_AccountData.AutoLoot[v])
					end
				
				end -- EO accountWideAutoLootVariables
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					-- Loss of Control Variables
					if (AccWideUI_AccountData.accountWideLossOfControlVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Loss of Control] Loading Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_LossOfControlVariables) do
							SetCVar(v, AccWideUI_AccountData.LossOfControl[v])
						end
					
					end -- EO accountWideLossOfControlVariables
				
				end
				
				
				-- Soft Target Variables
				if (AccWideUI_AccountData.accountWideSoftTargetVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Soft Target] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_SoftTargetVariables) do
						SetCVar(v, AccWideUI_AccountData.SoftTarget[v])
					end
				
				end -- EO accountWideSoftTargetVariables
				
				
				
				-- Tutorial Variables
				if (AccWideUI_AccountData.accountWideTutorialTooltipVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Tutorial Tooltip] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_TutorialTooltipVariables) do
						SetCVar(v, AccWideUI_AccountData.TutorialTooltips[v])
					end
				end -- EO accountWideTutorialVariables
				
				
				-- Battlefield Map Variables
				if (AccWideUI_AccountData.accountWideBattlefieldMapVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Zone Map] Loading Settings.")
					end
					
					C_AddOns.LoadAddOn("Blizzard_BattlefieldMap")
				
					for k, v in pairs(AccWideUI_Table_BattlefieldMapVariables) do
						SetCVar(v, AccWideUI_AccountData.BattlefieldMap[v])
					end
					
					
					
					
					if (AccWideUI_AccountData.BattlefieldMapOptions) then
					
						-- Defaults from https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_BattlefieldMap/Blizzard_BattlefieldMap.lua#L11
						BattlefieldMapOptions = {
							opacity = 0.7,
							locked = true,
							showPlayers = true
						}

						if (type(AccWideUI_AccountData.BattlefieldMapOptions.opacity) == "number") then
							BattlefieldMapOptions.opacity = AccWideUI_AccountData.BattlefieldMapOptions.opacity
						end
						
						if (type(AccWideUI_AccountData.BattlefieldMapOptions.locked) == "boolean") then
							BattlefieldMapOptions.locked = AccWideUI_AccountData.BattlefieldMapOptions.locked
						end
						
						if (type(AccWideUI_AccountData.BattlefieldMapOptions.showPlayers) == "number") then
							BattlefieldMapOptions.showPlayers = AccWideUI_AccountData.BattlefieldMapOptions.showPlayers
						end
						
						if (type(AccWideUI_AccountData.BattlefieldMapOptions.position) == "table") then
							BattlefieldMapOptions.position = {}
							BattlefieldMapOptions.position.x = AccWideUI_AccountData.BattlefieldMapOptions.position.x
							BattlefieldMapOptions.position.y = AccWideUI_AccountData.BattlefieldMapOptions.position.y
						end
						
					end
					
					
					C_Timer.After(5, function() 
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Zone Map] Setting Placement etc.")
						end
						
						if (AccWideUI_AccountData.BattlefieldMap["showBattlefieldMinimap"] == "1") then
							BattlefieldMapFrame:Show()
						else
							BattlefieldMapFrame:Hide()
						end
						
						BattlefieldMapTab:ClearAllPoints();
						
						if ((AccWideUI_AccountData.BattlefieldMapOptions.position) and
						(AccWideUI_AccountData.BattlefieldMapOptions.position.x ~= 0) and (AccWideUI_AccountData.BattlefieldMapOptions.position.y ~= 0))then
							BattlefieldMapTab:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", AccWideUI_AccountData.BattlefieldMapOptions.position.x,AccWideUI_AccountData.BattlefieldMapOptions.position.y);
							BattlefieldMapTab:SetUserPlaced(true);
						end
						
						ValidateFramePosition(BattlefieldMapTab)
						
						if (AccWideUI_AccountData.BattlefieldMapOptions.opacity) then
							BattlefieldMapFrame:RefreshAlpha()
						end
						
						BattlefieldMapFrame:UpdateUnitsVisibility();
						BattlefieldMapFrame:StopMovingOrSizing();
						
						BattlefieldMapFrame:OnEvent("PLAYER_ENTERING_WORLD")
					
					end)
					
					
				end -- EO accountWideBattlefieldMapVariables
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					-- Cooldown Viewer Variables
					if (AccWideUI_AccountData.accountWideCooldownViewerVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Cooldown Viewer] Loading Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_CooldownViewerVariables) do
							SetCVar(v, AccWideUI_AccountData.CooldownViewer[v])
						end
					
					end -- EO accountWideCooldownViewerVariables
				
				end
					
				
				
				-- Mouseover/Self Cast Variables
				if (AccWideUI_AccountData.accountWideMouseoverCastVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Mouseover/Self Cast] Loading Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_MouseoverCastVariables) do
						SetCVar(v, AccWideUI_AccountData.MouseoverCast[v])
					end
				
				end -- EO accountWideMouseoverCastVariables
				
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
					-- Empowered Tap/Hold Variables
					if (AccWideUI_AccountData.accountWideEmpowerTapVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Empowered Tap/Hold] Loading Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_EmpowerTapVariables) do
							SetCVar(v, AccWideUI_AccountData.EmpowerTap[v])
						end
					
					end -- EO accountWideEmpowerTapVariables
					
					
					-- Bag Organisation Settings
					if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true and doNotLoadChatOrBagSettings == false) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Bags] Loading Settings.")
						end
						
						
						local extraTimer = 1
						local extraTimerAdd = 0.5
						
						C_Timer.After(4, function() 
						
							C_Container.SetSortBagsRightToLeft(AccWideUI_AccountData.BagOrganisation.SortBagsRightToLeft)
							C_Container.SetInsertItemsLeftToRight(AccWideUI_AccountData.BagOrganisation.InsertItemsLeftToRight)
							
							C_Container.SetBackpackAutosortDisabled(AccWideUI_AccountData.BagOrganisation.BackpackAutosortDisabled)
							C_Container.SetBackpackSellJunkDisabled(AccWideUI_AccountData.BagOrganisation.BackpackSellJunkDisabled)
							
							C_Container.SetBankAutosortDisabled(AccWideUI_AccountData.BagOrganisation.BankAutosortDisabled)
							
							
							for bagName, bagId in pairs(Enum.BagIndex) do
								
								if (type(AccWideUI_AccountData.BagOrganisation.Bags[bagName]) == "table") then	

										for k, v in pairs(Enum.BagSlotFlags) do
											if (type(AccWideUI_AccountData.BagOrganisation.Bags[bagName][tostring(k)]) == "boolean") then
											
												C_Timer.After(extraTimer, function() 
												
													if (AccWideUI_AccountData.printDebugTextToChat == true) then
														print(AccWideUI_TextName .. " [Bags] Setting " .. k .. " to " .. tostring(AccWideUI_AccountData.BagOrganisation.Bags[bagName][tostring(k)]) .. " for " .. bagName .. ".")
														--print("C_Container.SetBagSlotFlag(" .. bagId .. ", " .. Enum.BagSlotFlags[tostring(k)] .. ", " .. tostring(AccWideUI_ToBoolean(AccWideUI_AccountData.BagOrganisation.Bags[bagName][tostring(k)])) .. ")")
													end
												
													C_Container.SetBagSlotFlag(bagId, Enum.BagSlotFlags[tostring(k)], AccWideUI_ToBoolean(AccWideUI_AccountData.BagOrganisation.Bags[bagName][tostring(k)]))
												
												end)
												
												extraTimer = extraTimer + extraTimerAdd
												
											end
										end

									
										
								end
							
							end
							
						end)
						
					
					end -- EO accountWideBagOrganisationVariables
				
				end
			
			
			
				-- Chat Window Settings
				
				if (AccWideUI_AccountData.accountWideChatWindowVariables == true and doNotLoadChatOrBagSettings == false) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Chat Window] Loading Settings.")
					end
					
					
					if (AccWideUI_AccountData.accountWideChatChannelVariables == true) then
					
						C_Timer.After(10, function() 
							if (AccWideUI_AccountData.printDebugTextToChat == true) then
								print(AccWideUI_TextName .. " [Chat Window] Joining Channels.")
							end
							-- Chat Channels
							for k, v in pairs(AccWideUI_AccountData.ChatChannelsJoined) do
								JoinChannelByName(v)
							end
						end)
						
						
						
						C_Timer.After(14, function() 
						
							if (AccWideUI_AccountData.printDebugTextToChat == true) then
								print(AccWideUI_TextName .. " [Chat Window] Reordering Channels.")
							end
							--Reorder Chat Channels
							for k, v in pairs(AccWideUI_AccountData.ChatChannelsJoined) do
								
								local id, name, instanceID, isCommunitiesChannel = GetChannelName(v)
								
								if (id ~= k) then
									-- Move Channel
									C_ChatInfo.SwapChatChannelsByChannelIndex(id, k)
								end
								
							end
						end)
						
		
						
						C_Timer.After(16, function() 
							if (AccWideUI_AccountData.printDebugTextToChat == true) then
								print(AccWideUI_TextName .. " [Chat Window] Setting Channel Colors.")
							end
							-- Chat Colours
							for k, v in pairs(AccWideUI_Table_ChatTypes) do
								if (type(ChatTypeInfo[v]) == "table") then
									if (type(AccWideUI_AccountData.ChatInfo[v][1]) == "table") then
										ChangeChatColor(v, AccWideUI_AccountData.ChatInfo[v][1].r, AccWideUI_AccountData.ChatInfo[v][1].g, AccWideUI_AccountData.ChatInfo[v][1].b)
										
										SetChatColorNameByClass(v, AccWideUI_AccountData.ChatInfo[v][1].colorNameByClass)
									end
								end
							end
						end)
					
					
					end
					
					
					
					
					-- Individual Chat Window/Tab Settings
					for thisChatFrame = 1, NUM_CHAT_WINDOWS do
						
						--local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
						local thisChatFrameVar = FCF_GetChatFrameByID(thisChatFrame);
						
						
						--[[FCF_SetWindowAlpha(
							thisChatFrameVar, 
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.a
						)]]
						
						SetChatWindowAlpha(
							thisChatFrame, 
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.a
						)
						
						--[[FCF_SetWindowColor(
							thisChatFrameVar,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.r,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.g,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.b
						)]]
						
						SetChatWindowColor(
							thisChatFrame,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.r,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.g,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.b
						)
						
						
						
						--[[if (AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked) then
							FCF_DockFrame(
								thisChatFrameVar,
								(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked or false)
							)
						else
							FCF_UnDockFrame(
								thisChatFrameVar
							)
						end]]
						
						SetChatWindowDocked(
							thisChatFrame,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked or false)
						)
						
						--[[FCF_SetLocked(
							thisChatFrameVar,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isLocked or false)
						)]]
						
						SetChatWindowLocked(
							thisChatFrame,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isLocked or false)
						)
						
						SetChatWindowShown(
							thisChatFrame,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isShown or false)
						)
						
						--[[if (AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isShown == true) then
							thisChatFrameVar:Show()
						else
							thisChatFrameVar:Hide()
						end]]
						
						SetChatWindowUninteractable(
							thisChatFrame,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
						)
						
						--[[FCF_SetUninteractable(
							thisChatFrameVar,
							(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isUninteractable or false)
						)]]
						
						SetChatWindowName(
							thisChatFrame,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.name
						)
						
						--[[FCF_SetWindowName(
							thisChatFrameVar,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.name
						)]]
						
							
						
						
						if (AccWideUI_AccountData.accountWideChatWindowPosition == true) then
							if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.xOffset) ~= "nil") then
								SetChatWindowSavedPosition(
									thisChatFrame,
									AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.point,
									AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.xOffset,
									AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.yOffset
								)
							end
							
							if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions.width) ~= "nil") then
								SetChatWindowSavedDimensions(
									thisChatFrame,
									AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions.width,
									AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions.height
								)
							end
							
							SetChatWindowSize(
								thisChatFrame,
								AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.size
							)
							
							
							--FCF_RestorePositionAndDimensions(thisChatFrameVar)
						end
						

						C_Timer.After(1, function()
							FloatingChatFrame_Update(thisChatFrame, true)
							
							--[[if (AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked) then
								FCF_UnDockFrame(thisChatFrameVar)
								FCF_DockFrame(thisChatFrameVar, AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked, thisChatFrame)
							end]]
							
						end)
						
						C_Timer.After(4, function()
						
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
							
						end)
						
						--Visible Chat Channels
						C_Timer.After((18 + (thisChatFrame * 2)), function() 
						
							local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
						
							for i = 1, #thisWindowChannels, 2 do
								local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
								
								if (AccWideUI_AccountData.printDebugTextToChat == true) then
									print(AccWideUI_TextName .. " [Chat Window] Removing " .. chn .. " From Window " .. thisChatFrame .. ".")
								end
								
								ChatFrame_RemoveChannel(thisChatFrameVar, chn)
							end
						
							for k,v in pairs(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible) do
							
								if (AccWideUI_AccountData.printDebugTextToChat == true) then
									print(AccWideUI_TextName .. " [Chat Window] Adding " .. v .. " To Window " .. thisChatFrame .. ".")
								end
								
								ChatFrame_AddChannel(thisChatFrameVar, v)
								
							end

						
						end)
						
						
						-- Types of Chat
						C_Timer.After((20 + (thisChatFrame * 2)), function() 
						
							if ((AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isShown == true) or (AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked)) then
						
								if (AccWideUI_AccountData.printDebugTextToChat == true) then
									print(AccWideUI_TextName .. " [Chat Window] Setting Chat Types for Window " .. thisChatFrame .. ".")
								end
							
							
								ChatFrame_RemoveAllMessageGroups(thisChatFrameVar)
								
								for k,v in pairs(AccWideUI_AccountData.ChatWindows[thisChatFrame].MessageTypes) do
									 ChatFrame_AddMessageGroup(thisChatFrameVar, v)
									 if (AccWideUI_AccountData.printDebugTextToChat == true) then
										print(AccWideUI_TextName .. " [Chat Window] Adding " .. v .. " to Window " .. thisChatFrame .. ".")
									 end
								end
							
							end
							
						end)
					
						
					end
				
					C_Timer.After(2, function()
						FCF_DockUpdate()
					end)
					
				
				else
				
					LoadUIAllowSaveTime = 15
					
				end
				
				
				if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true) then
					LoadUIAllowSaveTime = 124
				end
				
				
				C_Timer.After(LoadUIAllowSaveTime, function()
					AccWideUI_IsCurrentlyLoadingSettings = false
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Debug] Settings can now be saved.")
					end
				end)
				
			end
	
	end




	function AccWideUI_Frame:SaveUISettings()
	
		if AccWideUI_IsCurrentlyLoadingSettings == true then
		
			if (AccWideUI_AccountData.printDebugTextToChat == true) then
				print(AccWideUI_TextName .. " [Debug] Not saving UI Settings while settings are still loading.")
			end
		
		else
			
			if (InCombatLockdown()) then
				if (AccWideUI_AccountData.printDebugTextToChat == true) then
					print(AccWideUI_TextName .. " [Debug] Not saving UI Settings while in combat.")
				end
				
			else
			
				if (AccWideUI_AccountData.printDebugTextToChat == true) then
					print(AccWideUI_TextName .. " [Debug] Saving UI Settings.")
				end
				
				AccWideUI_AccountData.HasDoneFirstTimeSetup = true
				
				
				AccWideUI_AccountData.LastSaved.Character = AccWideUI_ThisPlayerName .. "-" .. AccWideUI_ThisPlayerRealm
				AccWideUI_AccountData.LastSaved.UnixTime = GetServerTime()
				
			
				--Save Shown Action Bars
				if (AccWideUI_AccountData.accountWideActionBars == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Action Bar] Saving Settings.")
					end
					
					for k, v in pairs(AccWideUI_Table_ActionBarVariables) do
						AccWideUI_AccountData.ActionBars.ActionBarVariables[v] = GetCVar(v) or nil
					end

						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
							AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5, AccWideUI_AccountData.ActionBars.Bar6, AccWideUI_AccountData.ActionBars.Bar7, AccWideUI_AccountData.ActionBars.Bar8 = GetActionBarToggles()
						else
							AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5 = GetActionBarToggles()
						end

				end
				
				
				-- Save Nameplates
				if (AccWideUI_AccountData.accountWideNameplates == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Nameplate] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_NameplateVariables) do
						AccWideUI_AccountData.Nameplates[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideNameplates
				
				
				
				-- Save Raid Frames
				if (AccWideUI_AccountData.accountWideRaidFrames == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Raid Frames] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
						AccWideUI_AccountData.RaidFrames[v] = GetCVar(v) or nil
					end
					
					
					if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
					
						--if (GetNumRaidProfiles() > 1) then
						
						AccWideUI_AccountData.RaidFrameProfiles = {}
						
							for i=1, GetNumRaidProfiles() do
							
								AccWideUI_AccountData.RaidFrameProfiles[i] = {}
																
								local thisRaidProfileName = GetRaidProfileName(i) or nil
							
								if (type(thisRaidProfileName) ~= "nil") then
									if (RaidProfileExists(thisRaidProfileName)) then
									
										if (AccWideUI_AccountData.printDebugTextToChat == true) then
											print(AccWideUI_TextName .. " [Raid Frame] Saving Raid Frame Profile with Name " .. thisRaidProfileName .. ".")
										end
									
										
										
									
										AccWideUI_AccountData.RaidFrameProfiles[i].name = thisRaidProfileName
										AccWideUI_AccountData.RaidFrameProfiles[i].isActive = false
										
										
										if (thisRaidProfileName == GetActiveRaidProfile()) then
											AccWideUI_AccountData.RaidFrameProfiles[i].isActive = true
										end
										
										
										AccWideUI_AccountData.RaidFrameProfiles[i].options =  GetRaidProfileFlattenedOptions(GetRaidProfileName(i))  
										
										local isDynamic, topPoint, topOffset, bottomPoint, bottomOffset, leftPoint, leftOffset = GetRaidProfileSavedPosition(GetRaidProfileName(i))
										
										AccWideUI_AccountData.RaidFrameProfiles[i].position = {
											["isDynamic"] = isDynamic,
											["topPoint"] = topPoint,
											["topOffset"] = topOffset,
											["bottomPoint"] = bottomPoint,
											["bottomOffset"] = bottomOffset,
											["leftPoint"] = leftPoint,
											["leftOffset"] = leftOffset
										}
										
									
									else
											
										AccWideUI_AccountData.RaidFrameProfiles[i] = nil

									end
								end
								
							end
						--else
						
						
						--end
				end
					
				
				end -- EO accountWideRaidFrames
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Save Arena Frames
					if (AccWideUI_AccountData.accountWideArenaFrames == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Arena Frames] Saving Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
							AccWideUI_AccountData.ArenaFrames[v] = GetCVar(v) or nil
						end
					
					end -- EO accountWideArenaFrames
				end
				
				
				-- Save Social Variables
				if (AccWideUI_AccountData.accountWideBlockSocialVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Social] Saving  Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_BlockSocialVariables) do
						AccWideUI_AccountData.BlockSocial[v] = GetCVar(v) or nil
					end
					
				
				end -- EO accountWideBlockSocialVariables
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Save Spell Overlay Variables
					if (AccWideUI_AccountData.accountWideSpellOverlayVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Spell Overlay] Saving Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_SpellOverlayVariables) do
							AccWideUI_AccountData.SpellOverlay[v] = GetCVar(v) or nil
						end
					
					end -- EO accountWideSpellOverlayVariables
				end
				
				
				-- Save Auto Loot Variables
				if (AccWideUI_AccountData.accountWideAutoLootVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Auto Loot] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_AutoLootVariables) do
						AccWideUI_AccountData.AutoLoot[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideAutoLootVariables
				
				
				
				-- Save Loss of Control Variables
				if (AccWideUI_AccountData.accountWideLossOfControlVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Loss of Control] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_LossOfControlVariables) do
						AccWideUI_AccountData.LossOfControl[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideLossOfControlVariables
				
				
				-- Save Soft Target Variables
				if (AccWideUI_AccountData.accountWideSoftTargetVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Soft Target] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_SoftTargetVariables) do
						AccWideUI_AccountData.SoftTarget[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideSoftTargetVariables
				
				
				-- Save Tutorial Variables
				if (AccWideUI_AccountData.accountWideTutorialTooltipVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Tutorial Tooltip] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_TutorialTooltipVariables) do
						AccWideUI_AccountData.TutorialTooltips[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideTutorialVariables
				
				
				-- Save Battlefield Map Variables
				if (AccWideUI_AccountData.accountWideBattlefieldMapVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Zone Map] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_BattlefieldMapVariables) do
						AccWideUI_AccountData.BattlefieldMap[v] = GetCVar(v) or nil
					end
					
					AccWideUI_AccountData.BattlefieldMapOptions = {}
					
					if (type(BattlefieldMapOptions.locked) == "boolean") then
						AccWideUI_AccountData.BattlefieldMapOptions.locked = BattlefieldMapOptions.locked 
					end
					
					if (type(BattlefieldMapOptions.opacity) == "number") then
						AccWideUI_AccountData.BattlefieldMapOptions.opacity = BattlefieldMapOptions.opacity 
					end
					
					if (type(BattlefieldMapOptions.showPlayers) == "boolean") then
						AccWideUI_AccountData.BattlefieldMapOptions.showPlayers = BattlefieldMapOptions.showPlayers 
					end
					
					AccWideUI_AccountData.BattlefieldMapOptions.position = {}
					AccWideUI_AccountData.BattlefieldMapOptions.position.x, AccWideUI_AccountData.BattlefieldMapOptions.position.y = BattlefieldMapTab:GetCenter();
						
					
					
				
				end -- EO accountWideTutorialVariables
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- Save Cooldown Manager Setting
					if (AccWideUI_AccountData.accountWideCooldownViewerVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Cooldown Manager] Saving Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_CooldownViewerVariables) do
							AccWideUI_AccountData.CooldownViewer[v] = GetCVar(v) or nil
						end
					
					end -- EO accountWideCooldownViewerVariables
				end
				
				
				
				-- Save Mouseover/Self Cast Settings
				if (AccWideUI_AccountData.accountWideMouseoverCastVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Mouseover/Self Cast] Saving Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_MouseoverCastVariables) do
						AccWideUI_AccountData.MouseoverCast[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideMouseoverCastVariables
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- Save Empowered Tap/Hold Settings
					if (AccWideUI_AccountData.accountWideEmpowerTapVariables == true) then
					
						if (AccWideUI_AccountData.printDebugTextToChat == true) then
							print(AccWideUI_TextName .. " [Empowered Tap/Hold] Saving Settings.")
						end
					
						for k, v in pairs(AccWideUI_Table_EmpowerTapVariables) do
							AccWideUI_AccountData.EmpowerTap[v] = GetCVar(v) or nil
						end
					
					end -- EO accountWideEmpowerTapVariables
					
					
					-- Save Bag Organisation Settings
					AccWideUI_Frame:SaveBagFlagSettings(false)
		
					
				end

				
				-- Save Chat Window Variables
				if (AccWideUI_AccountData.accountWideChatWindowVariables == true) then
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Chat Window] Saving Settings.")
					end
				
				
					for thisChatFrame = 1, NUM_CHAT_WINDOWS do
					
						local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
						
							
						-- Chat Window Info
						do
							local name, size, r, g, b, a, isShown, isLocked, isDocked, isUninteractable = GetChatWindowInfo(thisChatFrame);
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo = {
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
						if (AccWideUI_AccountData.accountWideChatWindowPosition == true) then
							do
								local point, xOffset, yOffset = GetChatWindowSavedPosition(thisChatFrame);
								AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions = {
									["point"] = point,
									["xOffset"] = xOffset,
									["yOffset"] = yOffset
								}
							end
							
							--Dimensions
							do
								local width, height = GetChatWindowSavedDimensions(thisChatFrame);
								AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions = {
									["width"] = width,
									["height"] = height
								}
							end
						end

						
						
		
						
						--Message Types
						do
							AccWideUI_AccountData.ChatWindows[thisChatFrame].MessageTypes = {GetChatWindowMessages(thisChatFrame)}
						end
						
						
						--Chat Channels
						do
							AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible = {}
							
							local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
							
							for i = 1, #thisWindowChannels, 2 do
								local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
								table.insert(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible, chn)
							end
							
						end
							
						
						

					end -- eo ChatFrame
					
					
					if (AccWideUI_AccountData.accountWideChatChannelVariables == true) then
					
						-- Chat Channels
						do
							AccWideUI_AccountData.ChatChannelsJoined = {}
							local channels = {GetChannelList()}
							for i = 1, #channels, 3 do
								local id, name, disabled = channels[i], channels[i+1], channels[i+2]
								AccWideUI_AccountData.ChatChannelsJoined[id] = name
							end
						end
					
					end
					
					
					--Chat Colours Etc
					do
						AccWideUI_AccountData.ChatInfo = {}
						for k, v in pairs(AccWideUI_Table_ChatTypes) do
							if (type(ChatTypeInfo[v]) == "table") then
								
								local thisChatTypeInfo = ChatTypeInfo[v]
								
								AccWideUI_AccountData.ChatInfo[v] = { ChatTypeInfo[v] }
							end
						end
					end
				
				end

			end
		
		end

	end
	
	
	function AccWideUI_Frame:SaveBagFlagSettings(saveFlags)
	
		saveFlags = saveFlags or false
	
		if (AccWideUI_AccountData.accountWideBagOrganisationVariables == true) then
					
			AccWideUI_AccountData.BagOrganisation.SortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
			AccWideUI_AccountData.BagOrganisation.InsertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
		
			AccWideUI_AccountData.BagOrganisation.BackpackAutosortDisabled = C_Container.GetBackpackAutosortDisabled()
			AccWideUI_AccountData.BagOrganisation.BackpackSellJunkDisabled = C_Container.GetBackpackSellJunkDisabled() 
			
			AccWideUI_AccountData.BagOrganisation.BankAutosortDisabled = C_Container.GetBankAutosortDisabled()
			
			if (saveFlags == true) then 
				-- C_Container.GetBagSlotFlag always seems to return -false- when logging out. So save this only when BAG_SLOT_FLAGS_UPDATED or BANK_BAG_SLOT_FLAGS_UPDATED is triggered.
				
				C_Timer.After(5, function() 
				
					if (AccWideUI_AccountData.printDebugTextToChat == true) then
						print(AccWideUI_TextName .. " [Bags] Saving Settings and Flags.")
					end
			
					for bagName, bagId in pairs(Enum.BagIndex) do
						
						AccWideUI_AccountData.BagOrganisation.Bags[bagName] = {}
					
						for k, v in pairs(Enum.BagSlotFlags) do
						
							if (AccWideUI_AccountData.printDebugTextToChat == true) then
								--print(AccWideUI_TextName .. " Saving " .. k .. " for " .. bagName .. ".")
							end
						
							AccWideUI_AccountData.BagOrganisation.Bags[bagName][k] = C_Container.GetBagSlotFlag(bagId, tonumber(v))
							
						end

					end
				
				end)
			
			else
			
				if (AccWideUI_AccountData.printDebugTextToChat == true) then
					print(AccWideUI_TextName .. " [Bags] Saving Settings.")
				end
			
			end

		
		end -- EO accountWideBagOrganisationVariables
	
	
	
	end



	function AccWideUI_Frame:CompartmentIsSpecActive(thisSpec)
	
		if (thisSpec == true) then
			return("|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t")
		else
			return("|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t")
		end	
	
	end
	
	
	function AccWideUI_Frame:ToggleShowDebugSettings()
		if (AccWideUI_AccountData.ShowDebugSettings == true) then
			debugSaveBtn:Show()
			debugLoadBtn:Show()
			chkDebugText:Show()
		 else 
			debugSaveBtn:Hide()
			debugLoadBtn:Hide()
			chkDebugText:Hide()
		end
	end
	
	
	
	
	--Addon Compartment
	local AccWideUI_Tooltip

	function AccWideUI_CompartmentClick(addonName, buttonName)
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
			Settings.OpenToCategory(AccWideUI_OptionsPanelFrameCategoryID)
		end
	end

	function AccWideUI_CompartmentHover(addonName, buttonName)
	
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
	
			if (not AccWideUI_Tooltip) then
				AccWideUI_Tooltip = CreateFrame("GameTooltip", "AccWideUI_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
			end
			
			local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
			
			AccWideUI_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
			AccWideUI_Tooltip:SetText(L.ACCWUI_ADDONNAME)
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				AccWideUI_Tooltip:AddLine(" ")
				AccWideUI_Tooltip:AddLine(string.format(L.ACCWUI_ADCOM_CURRENT,classColorString:WrapTextInColorCode(UnitName("player"))),  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b) 
				AccWideUI_Tooltip:AddLine(" ")
				
				--Specialisations
				AccWideUI_SpecName = {}
				AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

				for specx = 1, AccWideUI_NumSpecializations, 1 do
					AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
				end
				
				if (AccWideUI_NumSpecializations >= 1) then
					AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[1] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 1]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				end
				
				if (AccWideUI_NumSpecializations >= 2) then
					AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[2] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 2]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				end
				
				if (AccWideUI_NumSpecializations >= 3) then
					AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[3] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 3]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				end
				
				if (AccWideUI_NumSpecializations >= 4) then
					AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[4] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 4]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				end
				
				if (AccWideUI_NumSpecializations >= 5) then
					AccWideUI_Tooltip:AddDoubleLine(AccWideUI_SpecName[5] .. ":", AccWideUI_Frame:CompartmentIsSpecActive(AccWideUI_CharData["accWideSpec" .. 5]), nil, nil, nil,  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				end
			
			end
			
			AccWideUI_Tooltip:AddLine(" ")
			AccWideUI_Tooltip:AddLine(L.ACCWUI_ADCOM_CHANGE,  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
			
			AccWideUI_Tooltip:Show()
		
		end
		
	end

	function AccWideUI_CompartmentLeave(buttonName)
		if (AccWideUI_AccountData.HasDoneFirstTimeSetup == true) then
			AccWideUI_Tooltip:Hide()
		end
	end



