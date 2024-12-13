--[[
=====================================================
Account Wide Interface Option Settings
https://github.com/NinerBull/AccWideUILayoutSelection
=====================================================
]]--


local AccWideUI_SaveVersion = 2

local AccWideUI_Frame = CreateFrame("Frame")


local AccWideUI_Frame_HasLoadedSettings = false
local AccWideUI_Frame_HasDoneInitialLoad = false

local AccWideUI_OptionsPanelFrame
local AccWideUI_Category

local function AccWideUI_ToBoolean(str)
	local bool = false
	if str == "true" then
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

--AccWideUI_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
--AccWideUI_Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
--AccWideUI_Frame:RegisterEvent("ADDON_LOADED")
--AccWideUI_Frame:RegisterEvent("LOADING_SCREEN_ENABLED")

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	AccWideUI_Frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

local AccWideUI_TextName = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("<Account Wide Interface>")
local AccWideUI_TextSlash = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("/awi")
local AccWideUI_ThisCategory = nil
local AccWideUI_DividerGraphic = "interface\\friendsframe\\ui-friendsframe-onlinedivider"


AccWideUI_ChatName_General = "General"
AccWideUI_ChatName_Trade = "Trade"
AccWideUI_ChatName_Services = "Services"
AccWideUI_ChatName_LocalDefense = "LocalDefense"
AccWideUI_ChatName_WorldDefense = "WorldDefense"
AccWideUI_ChatName_LookingForGroup = "LookingForGroup"


-- https://wago.tools/db2/ChatChannels

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_Services = C_ChatInfo.GetChannelShortcutForChannelID(42)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

end


if (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_WorldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

end


if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then

	AccWideUI_ChatName_General = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUI_ChatName_Trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUI_ChatName_Services = C_ChatInfo.GetChannelShortcutForChannelID(45)
	AccWideUI_ChatName_LocalDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUI_ChatName_WorldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUI_ChatName_LookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(24)

end

	

	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		
		hooksecurefunc(C_EditMode, "OnEditModeExit", function()
		
			if (AccWideUI_AccountData.accountWideLayout == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Acc Wide UI.")
				end
					
				
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = tostring(GetSpecialization())
				
				if (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then

					--Set the spec
					AccWideUI_AccountData.accountWideLayoutID = currentActiveLayout
					
					AccWideUI_Frame:SaveUISettings()

				end
				
				
				
				
				
			end -- EO accountWideLayout
				
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
		"nameplateShowOnlyNames"
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
		--"activeCUFProfile",
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
	
	
	AccWideUI_Table_ActionBarVariables = {
		"multiBarRightVerticalLayout"
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
	
	
	

	AccWideUI_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

		if (InCombatLockdown() == false) then
			-- do nothing if in combat
			
			
		
			

			if (event == "SETTINGS_LOADED") then
			
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
					local getLayoutsTable = C_EditMode.GetLayouts()
					local currentActiveLayout = getLayoutsTable["activeLayout"]
					
				end		
				
				
				if (type(AccWideUI_AccountData.SaveVersion) ~= "number") then
					AccWideUI_AccountData.SaveVersion = AccWideUI_SaveVersion
				end


				if (type(AccWideUI_AccountData) ~= "table") then
					AccWideUI_AccountData = {}
				end
				
				if (type(AccWideUI_AccountData.SpecialVariables) ~= "table") then
					AccWideUI_AccountData.SpecialVariables = {}
				end
				
				if (type(AccWideUI_AccountData.ChatChannels) ~= "table") then
					AccWideUI_AccountData.ChatChannels = {}
				end
				
				if (type(AccWideUI_AccountData.enableDebug) ~= "boolean") then
					AccWideUI_AccountData.enableDebug = false
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
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					if (type(AccWideUI_AccountData.accountWideArenaFrames) ~= "boolean") then
						AccWideUI_AccountData.accountWideArenaFrames = true
					end
				end
				
				if (type(AccWideUI_AccountData.accountWideBlockSocialVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideBlockSocialVariables = true
				end
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					if (type(AccWideUI_AccountData.accountWideSpellOverlayVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideSpellOverlayVariables = true
					end
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
				
				
				--[[if (type(AccWideUI_AccountData.accountWideBagSortingSettings) ~= "boolean") then
					AccWideUI_AccountData.accountWideBagSortingSettings = true
				end]]
				
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					
					if (type(AccWideUI_AccountData.accountWideLossOfControlVariables) ~= "boolean") then
						AccWideUI_AccountData.accountWideLossOfControlVariables = true
					end
					
				end
				

				
				if (type(AccWideUI_AccountData.accountWideChatWindowVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideChatWindowVariables = true
				end
				
				if (type(AccWideUI_AccountData.accountWideChatChannelVariables) ~= "boolean") then
					AccWideUI_AccountData.accountWideChatChannelVariables = true
				end
				
				
				
				
				--Special
				if (type(AccWideUI_AccountData.SpecialVariables.BlockGuildInvites) ~= "boolean") then
					AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = GetAutoDeclineGuildInvites()
				end
				
				
				--[[if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					if (type(AccWideUI_AccountData.SpecialVariables.SortBagsRightToLeft) ~= "boolean") then
						AccWideUI_AccountData.SpecialVariables.SortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
					end
					
					if (type(AccWideUI_AccountData.SpecialVariables.InsertItemsLeftToRight) ~= "boolean") then
						AccWideUI_AccountData.SpecialVariables.InsertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
					end
				end]]
				
				
				
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
				
				end
				
				
				
				
				
				-- Action Bar Variables
				if (type(AccWideUI_AccountData.ActionBars) ~= "table") then
					AccWideUI_AccountData.ActionBars = {}
				end
				
				
				-- CVars
				if (type(AccWideUI_AccountData.ActionBars.ActionBarVariables) ~= "table") then
					AccWideUI_AccountData.ActionBars.ActionBarVariables = {}
				end
				
				for k, v in pairs(AccWideUI_Table_ActionBarVariables) do
					if (type(AccWideUI_AccountData.ActionBars.ActionBarVariables[v]) == "nil") then
						AccWideUI_AccountData.ActionBars.ActionBarVariables[v] = GetCVar(v) or nil
					end
				end
				
				
				
				AccWideUI_ActionBarsDefault = {}
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
					AccWideUI_ActionBarsDefault.Bar2, AccWideUI_ActionBarsDefault.Bar3, AccWideUI_ActionBarsDefault.Bar4, AccWideUI_ActionBarsDefault.Bar5, AccWideUI_ActionBarsDefault.Bar6, AccWideUI_ActionBarsDefault.Bar7, AccWideUI_ActionBarsDefault.Bar8 = GetActionBarToggles()
				
				else
				
					AccWideUI_ActionBarsDefault.Bar2, AccWideUI_ActionBarsDefault.Bar3, AccWideUI_ActionBarsDefault.Bar4, AccWideUI_ActionBarsDefault.Bar5 = GetActionBarToggles()
				
				end
				

			
				if (type(AccWideUI_AccountData.ActionBars.Bar2) ~= "boolean") then
					AccWideUI_AccountData.ActionBars.Bar2 = AccWideUI_ActionBarsDefault.Bar2
				end
				
				if (type(AccWideUI_AccountData.ActionBars.Bar3) ~= "boolean") then
					AccWideUI_AccountData.ActionBars.Bar3 = AccWideUI_ActionBarsDefault.Bar3
				end
				
				if (type(AccWideUI_AccountData.ActionBars.Bar4) ~= "boolean") then
					AccWideUI_AccountData.ActionBars.Bar4 = AccWideUI_ActionBarsDefault.Bar4
				end
				
				if (type(AccWideUI_AccountData.ActionBars.Bar5) ~= "boolean") then
					AccWideUI_AccountData.ActionBars.Bar5 = AccWideUI_ActionBarsDefault.Bar5
				end
				
				
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					
					if (type(AccWideUI_AccountData.ActionBars.Bar6) ~= "boolean") then
						AccWideUI_AccountData.ActionBars.Bar6 = AccWideUI_ActionBarsDefault.Bar6
					end
				
					if (type(AccWideUI_AccountData.ActionBars.Bar7) ~= "boolean") then
						AccWideUI_AccountData.ActionBars.Bar7 = AccWideUI_ActionBarsDefault.Bar7
					end
					
					if (type(AccWideUI_AccountData.ActionBars.Bar8) ~= "boolean") then
						AccWideUI_AccountData.ActionBars.Bar8 = AccWideUI_ActionBarsDefault.Bar8
					end
				
				end



				
				-- Nameplates Variables
				if (type(AccWideUI_AccountData.Nameplates) ~= "table") then
					AccWideUI_AccountData.Nameplates = {}
				end
				
				for k, v in pairs(AccWideUI_Table_NameplateVariables) do
					if (type(AccWideUI_AccountData.Nameplates[v]) == "nil") then
						AccWideUI_AccountData.Nameplates[v] = GetCVar(v) or nil
					end
				end
				
				
				-- Raid Frame Variables
				if (type(AccWideUI_AccountData.RaidFrames) ~= "table") then
					AccWideUI_AccountData.RaidFrames = {}
				end
				
				for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
					if (type(AccWideUI_AccountData.RaidFrames[v]) == "nil") then
						AccWideUI_AccountData.RaidFrames[v] = GetCVar(v) or nil
					end
				end
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Raid Frame Profile Settings
					if (type(AccWideUI_AccountData.RaidFrameProfiles) ~= "table") then
						AccWideUI_AccountData.RaidFrameProfiles = {}
						
						for i=1, GetMaxNumCUFProfiles() do
													
							local thisRaidProfileName = GetRaidProfileName(i) or nil
						
							if (type(thisRaidProfileName) ~= "nil") then
								if (RaidProfileExists(thisRaidProfileName)) then
								
									
									AccWideUI_AccountData.RaidFrameProfiles[i] = {}
								
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
						
					end
				
				end

				
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					-- Arena Frame Variables
					if (type(AccWideUI_AccountData.ArenaFrames) ~= "table") then
						AccWideUI_AccountData.ArenaFrames = {}
					end
					
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						if (type(AccWideUI_AccountData.ArenaFrames[v]) == "nil") then
							AccWideUI_AccountData.ArenaFrames[v] = GetCVar(v) or nil
						end
					end
				end
				
				
				-- Block Social Variables
				if (type(AccWideUI_AccountData.BlockSocial) ~= "table") then
					AccWideUI_AccountData.BlockSocial = {}
				end
				
				for k, v in pairs(AccWideUI_Table_BlockSocialVariables) do
					if (type(AccWideUI_AccountData.BlockSocial[v]) == "nil") then
						AccWideUI_AccountData.BlockSocial[v] = GetCVar(v) or nil
					end
				end
				
				
				-- Spell Overlay Variables
				if (type(AccWideUI_AccountData.SpellOverlay) ~= "table") then
					AccWideUI_AccountData.SpellOverlay = {}
				end
				
				for k, v in pairs(AccWideUI_Table_SpellOverlayVariables) do
					if (type(AccWideUI_AccountData.SpellOverlay[v]) == "nil") then
						AccWideUI_AccountData.SpellOverlay[v] = GetCVar(v) or nil
					end
				end
				
				
				-- Auto Loot Variables
				if (type(AccWideUI_AccountData.AutoLoot) ~= "table") then
					AccWideUI_AccountData.AutoLoot = {}
				end
				
				for k, v in pairs(AccWideUI_Table_AutoLootVariables) do
					if (type(AccWideUI_AccountData.AutoLoot[v]) == "nil") then
						AccWideUI_AccountData.AutoLoot[v] = GetCVar(v) or nil
					end
				end
				
				
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- Loss Of Control Variables
					if (type(AccWideUI_AccountData.LossOfControl) ~= "table") then
						AccWideUI_AccountData.LossOfControl = {}
					end
					
					for k, v in pairs(AccWideUI_Table_LossOfControlVariables) do
						if (type(AccWideUI_AccountData.LossOfControl[v]) == "nil") then
							AccWideUI_AccountData.LossOfControl[v] = GetCVar(v) or nil
						end
					end
				end
			
			
				-- Soft Target Variables
				if (type(AccWideUI_AccountData.SoftTarget) ~= "table") then
					AccWideUI_AccountData.SoftTarget = {}
				end
				
				for k, v in pairs(AccWideUI_Table_SoftTargetVariables) do
					if (type(AccWideUI_AccountData.SoftTarget[v]) == "nil") then
						AccWideUI_AccountData.SoftTarget[v] = GetCVar(v) or nil
					end
				end
				
				
				
				-- Tutorial Variables
				if (type(AccWideUI_AccountData.TutorialTooltips) ~= "table") then
					AccWideUI_AccountData.TutorialTooltips = {}
				end
				
				for k, v in pairs(AccWideUI_Table_TutorialTooltipVariables) do
					if (type(AccWideUI_AccountData.TutorialTooltips[v]) == "nil") then
						AccWideUI_AccountData.TutorialTooltips[v] = GetCVar(v) or nil
					end
				end
				
				
				
				
				-- Chat Window Variables
				if (type(AccWideUI_AccountData.ChatWindows) ~= "table") then
					AccWideUI_AccountData.ChatWindows = {}
				end
				
				
				
				
				
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do
				
					local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame]) ~= "table") then
						AccWideUI_AccountData.ChatWindows[thisChatFrame] = {}
					end
						
					-- Chat Window Info
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo) ~= "table") then
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
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions) ~= "table") then
						local point, xOffset, yOffset = GetChatWindowSavedPosition(thisChatFrame);
						AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions = {
							["point"] = point,
							["xOffset"] = xOffset,
							["yOffset"] = yOffset
						}
					end

					
					--Dimensions
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions) ~= "table") then
						local width, height = GetChatWindowSavedDimensions(thisChatFrame);
						AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions = {
							["width"] = width,
							["height"] = height
						}
					end
	
					
					--Message Types
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].MessageTypes) ~= "table") then
						AccWideUI_AccountData.ChatWindows[thisChatFrame].MessageTypes = {GetChatWindowMessages(thisChatFrame)}
					end
					
					
					--Chat Channels
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible) ~= "table") then
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible = {}
						
						local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
						
						for i = 1, #thisWindowChannels, 2 do
							local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
							table.insert(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible, chn)
						end
						
					end
					
					
					


				end -- eo ChatFrame
				
				
				
				
				
				
				-- Chat Types
				if (type(AccWideUI_AccountData.ChatChannelsJoined) ~= "table") then
					AccWideUI_AccountData.ChatChannelsJoined = {}
					local channels = {GetChannelList()}
					for i = 1, #channels, 3 do
						local id, name, disabled = channels[i], channels[i+1], channels[i+2]
						AccWideUI_AccountData.ChatChannelsJoined[id] = name
					end
				end
				
				
				--Chat Colours Etc
				if (type(AccWideUI_AccountData.ChatInfo) ~= "table") then
					AccWideUI_AccountData.ChatInfo = {}
					for k, v in pairs(AccWideUI_Table_ChatTypes) do
						if (type(ChatTypeInfo[v]) == "table") then
							
							local thisChatTypeInfo = ChatTypeInfo[v]
							
							AccWideUI_AccountData.ChatInfo[v] = { ChatTypeInfo[v] }
						end
					end
				end
				
				
			
			
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

					if ((type(AccWideUI_CharData) == "table") and (AccWideUI_CharData["accWideSpec1"] == nil)) then
						AccWideUI_CharData = nil
						print(AccWideUI_TextName .. " Removed Invalid Char Data.")
					end
					
					
					if (type(AccWideUI_CharData) ~= "table") then
				
						AccWideUI_CharData = {
								["accWideSpec1"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec2"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec3"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec4"] = AccWideUI_AccountData.enableAccountWide,
								["accWideSpec5"] = AccWideUI_AccountData.enableAccountWide --Temp Spec for fresh chars, adding just in case
						}
					
						if (AccWideUI_AccountData.enableTextOutput == true) then
						
							print(AccWideUI_TextName .. " This is the first time you have logged in to this character with the Account Wide Interface Option Settings addon installed.")
						
						end
					
					
					else
					
						if (AccWideUI_AccountData.enableTextOutput == true) then
					
							print(AccWideUI_TextName .. " Account Wide Interface Option Settings Addon Loaded! Type " .. AccWideUI_TextSlash .. " to configure.")
						
						end
					
					end
					
				
				else
				
					if (AccWideUI_AccountData.enableTextOutput == true) then
					
							print(AccWideUI_TextName .. " Account Wide Interface Option Settings Addon Loaded! Type " .. AccWideUI_TextSlash .. " to configure.")
						
					end
						
				end
				
				
				-- Update Notices
				if (AccWideUI_AccountData.SaveVersion < 2) then
					AccWideUI_UpdateNotice2 = WHITE_FONT_COLOR:WrapTextInColorCode(AccWideUI_TextName .. " Updated! The addon can now synchronise many of your chat settings and the Pop-Up Tutorial Tooltips you have viewed. Type " .. AccWideUI_TextSlash .. " to configure.")
					C_Timer.After(10, function() 
						print(AccWideUI_UpdateNotice2)
					end)
				end
				
						
				AccWideUI_AccountData.SaveVersion = AccWideUI_SaveVersion
				
				
				AccWideUI_Frame:InitializeOptionsFrame()
				AccWideUI_Frame.InitializeOptionsSettings()
				
				AccWideUI_Frame_HasLoadedSettings = true
			
			end
			
			



			if (event == "LOADING_SCREEN_DISABLED" and AccWideUI_Frame_HasLoadedSettings == true and AccWideUI_Frame_HasDoneInitialLoad == false) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Doing Initial Load.")
				end
		
				
				C_Timer.After(5, function() 
					AccWideUI_Frame:LoadUISettings()
					AccWideUI_Frame_HasDoneInitialLoad = true
				end)
			
				
	
			end --EO Settings Loaded
			
			
			if  (event == "PLAYER_SPECIALIZATION_CHANGED" and arg1 == "player") then
				
				AccWideUI_Frame:SaveUISettings()
				AccWideUI_Frame:LoadUISettings(true)
	
			end --EO Settings Loaded
			
			
			
			
			-- Save all settings when logging out
			if  (event == "PLAYER_LOGOUT") then
				AccWideUI_Frame:SaveUISettings()
			end
			
			
			--Save Block Guild Setting with these 2
			if (event == "DISABLE_DECLINE_GUILD_INVITE") then
				AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = false
			end
			
			if (event == "ENABLE_DECLINE_GUILD_INVITE") then
				AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = true
			end
			
			
			if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then

				-- Remove player from channels if they're blocked
				if (event == "CHANNEL_UI_UPDATE") then
		
					if (AccWideUI_AccountData.ChatChannels.BlockGeneral == true) then
						if (GetChannelName((GetChannelName(AccWideUI_ChatName_General))) > 0) then
							LeaveChannelByName(AccWideUI_ChatName_General)
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockLocalDefense == true) then
						if (GetChannelName((GetChannelName(AccWideUI_ChatName_LocalDefense))) > 0) then
							LeaveChannelByName(AccWideUI_ChatName_LocalDefense)
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockTrade == true) then
						if (GetChannelName((GetChannelName(AccWideUI_ChatName_Trade))) > 0) then
							LeaveChannelByName(AccWideUI_ChatName_Trade)
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockLookingForGroup == true) then
						if (GetChannelName((GetChannelName(AccWideUI_ChatName_LookingForGroup))) > 0) then
							LeaveChannelByName(AccWideUI_ChatName_LookingForGroup)
						end
					end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
						if (AccWideUI_AccountData.ChatChannels.BlockServices == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_Services))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_Services)
							end
						end
					end
					
					if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
						if (AccWideUI_AccountData.ChatChannels.BlockWorldDefense == true) then
							if (GetChannelName((GetChannelName(AccWideUI_ChatName_WorldDefense))) > 0) then
								LeaveChannelByName(AccWideUI_ChatName_WorldDefense)
							end
						end
					end
				
				
				end
			
			end
			
		
		end

	end)

	function AccWideUI_Frame:InitializeOptionsFrame()
	
	
			AccWideUI_OptionsPanelFrame = CreateFrame("Frame");
			
			AccWideUI_Category = Settings.RegisterCanvasLayoutCategory(AccWideUI_OptionsPanelFrame, "Account Wide Interface Option Settings")
			Settings.RegisterAddOnCategory(AccWideUI_Category)
			
			AccWideUI_OptionsPanelFrameCategoryID = AccWideUI_Category:GetID()
	
	
	end


	function AccWideUI_Frame:InitializeOptionsSettings()
	

			
			
			
			
			local thisPointX = 16
			local thisPointY = -10

			--Title
			local title = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			title:SetJustifyV('TOP')
			title:SetJustifyH('LEFT')
			title:SetPoint('TOPLEFT', thisPointX, thisPointY)
			title:SetText("Account Wide Interface Option Settings")
			
			thisPointY = thisPointY - 20
			
			--Title2
			local title2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			title2:SetJustifyV('TOP')
			title2:SetJustifyH('LEFT')
			title2:SetPoint('TOPLEFT', thisPointX, thisPointY)
			title2:SetText("Makes various Interface Options synchronise across all of your characters and specs.")
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

				thisPointY = thisPointY - 20
				
				
				--Enable by Default
				local chkAWIEnableDefault = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWIEnableDefault:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWIEnableDefault.Text:SetText("Enable Chosen Edit Mode by default for all New Characters")
				chkAWIEnableDefault:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableAccountWide = chkAWIEnableDefault:GetChecked()
				end)
				chkAWIEnableDefault:SetChecked(AccWideUI_AccountData.enableAccountWide)
				
				thisPointX = 360
				
				thisPointY = thisPointY - 2
				
				-- Add shortcut to Edit Mode
				local b1 = CreateFrame("Button", nil, AccWideUI_OptionsPanelFrame, "UIPanelButtonTemplate")
				b1:SetSize(140 ,20)
				b1:SetText("Open Edit Mode")
				b1:SetPoint("TOPLEFT",thisPointX, thisPointY)
				b1:SetScript("OnClick", function()
					if SettingsPanel:IsShown() then
						HideUIPanel(SettingsPanel)
					end
					ShowUIPanel(EditModeManagerFrame)
				end)
		
			end
			
			
			thisPointY = thisPointY - 25
			
			thisPointX = 16
			
			-- Show Text
			local chkAWIShowText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWIShowText:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWIShowText.Text:SetText("Output to chat when addon is loaded")
			chkAWIShowText:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableTextOutput = chkAWIShowText:GetChecked()
			end)
			chkAWIShowText:SetChecked(AccWideUI_AccountData.enableTextOutput)
			
			
			
			thisPointY = thisPointY - 30
			
			local acBorder1 = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
			acBorder1:SetHeight(8)
			acBorder1:SetPoint("TOPLEFT", thisPointX, thisPointY)
			acBorder1:SetPoint("RIGHT", thisPointX, 0)
			acBorder1:SetTexture(AccWideUI_DividerGraphic)

			
			thisPointY = thisPointY - 20
			
	
			
			--Title for Which Save Options
			local titleSA = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
			titleSA:SetJustifyV('TOP')
			titleSA:SetJustifyH('LEFT')
			titleSA:SetPoint('TOPLEFT', thisPointX, thisPointY)
			titleSA:SetText("Enable Account Wide Modules")
			
			
			thisPointY = thisPointY - 20
			
			

			
			
			--Title for  Which Save Options 2
			local titleSA2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
			titleSA2:SetJustifyV('TOP')
			titleSA2:SetJustifyH('LEFT')
			titleSA2:SetPoint('TOPLEFT', thisPointX, thisPointY)
			titleSA2:SetText("Which UI settings would you like to synchronise Account Wide?")
			
			local thisPointY2 = thisPointY
			
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				thisPointY = thisPointY - 25 
			
				-- Save Edit Mode Layout
				local chkAWISaveEditModeLayout = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveEditModeLayout:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWISaveEditModeLayout.Text:SetText("Chosen Edit Mode Layout")
				chkAWISaveEditModeLayout:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLayout = chkAWISaveEditModeLayout:GetChecked()
				end)
				chkAWISaveEditModeLayout:SetChecked(AccWideUI_AccountData.accountWideLayout)
			
			end


			thisPointY = thisPointY - 25 
			
			
			-- Save Action Bars
			local chkAWISaveActionBar = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveActionBar:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveActionBar.Text:SetText("Visible Action Bars")
			chkAWISaveActionBar:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideActionBars = chkAWISaveActionBar:GetChecked()
			end)
			chkAWISaveActionBar:SetChecked(AccWideUI_AccountData.accountWideActionBars)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Nameplates
			local chkAWISaveNameplates = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveNameplates:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveNameplates.Text:SetText("Nameplate Settings")
			chkAWISaveNameplates:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideNameplates = chkAWISaveNameplates:GetChecked()
			end)
			chkAWISaveNameplates:SetChecked(AccWideUI_AccountData.accountWideNameplates)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Raid Frames
			local chkAWISaveRaidFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveRaidFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveRaidFrames.Text:SetText("Party/Raid Frame Settings")
			chkAWISaveRaidFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideRaidFrames = chkAWISaveRaidFrames:GetChecked()
			end)
			chkAWISaveRaidFrames:SetChecked(AccWideUI_AccountData.accountWideRaidFrames)
			
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY = thisPointY - 25 
				
				
				-- Save Arena Frames
				local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkAWISaveArenaFrames.Text:SetText("Arena Frame Settings")
				chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideArenaFrames = chkAWISaveArenaFrames:GetChecked()
				end)
				chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideArenaFrames)
			end
			
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Chat Window
			local chkAWISaveChatWindow = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveChatWindow:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveChatWindow.Text:SetText("Chat Window Settings")
			chkAWISaveChatWindow:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatWindowVariables = chkAWISaveChatWindow:GetChecked()
					
					if (chkAWISaveChatWindow:GetChecked() == true) then
						chkAWISaveChatChannels:Enable()
					else
						chkAWISaveChatChannels:Disable()
					end
			end)
			chkAWISaveChatWindow:SetChecked(AccWideUI_AccountData.accountWideChatWindowVariables)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Chat Channels
			chkAWISaveChatChannels = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveChatChannels:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkAWISaveChatChannels.Text:SetText("+ Custom Chat Channels")
			chkAWISaveChatChannels:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatChannelVariables = chkAWISaveChatChannels:GetChecked()
			end)
			chkAWISaveChatChannels:SetChecked(AccWideUI_AccountData.accountWideChatChannelVariables)
			
			if (AccWideUI_AccountData.accountWideChatWindowVariables == true) then
				chkAWISaveChatChannels:Enable()
			else
				chkAWISaveChatChannels:Disable()
			end
			
			
			
			
			-- 2nd Column
			
			thisPointX = 230
			
			thisPointY2 = thisPointY2 - 25 
							
			
			-- Block Social Variables
			local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveArenaFrames.Text:SetText("Block Guild/Trade/Channel Invite Settings")
			chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideBlockSocialVariables = chkAWISaveArenaFrames:GetChecked()
			end)
			chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideBlockSocialVariables)
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY2 = thisPointY2 - 25 
				
				
				-- Spell Overlay Variables
				local chkAWISaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkAWISaveArenaFrames.Text:SetText("Spell Overlay Settings")
				chkAWISaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideSpellOverlayVariables = chkAWISaveArenaFrames:GetChecked()
				end)
				chkAWISaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideSpellOverlayVariables)
			end
			
			
			
			thisPointY2 = thisPointY2 - 25 
			
			
			-- Auto Loot Variables
			local chkAWISaveAutoLoot = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveAutoLoot:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveAutoLoot.Text:SetText("Auto Loot Settings")
			chkAWISaveAutoLoot:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideAutoLootVariables = chkAWISaveAutoLoot:GetChecked()
			end)
			chkAWISaveAutoLoot:SetChecked(AccWideUI_AccountData.accountWideAutoLootVariables)
			
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				thisPointY2 = thisPointY2 - 25 
			
				-- Save Loss of Control Variables
				local chkAWISaveLossOfControl = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveLossOfControl:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkAWISaveLossOfControl.Text:SetText("Loss of Control Settings")
				chkAWISaveLossOfControl:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLossOfControlVariables = chkAWISaveLossOfControl:GetChecked()
				end)
				chkAWISaveLossOfControl:SetChecked(AccWideUI_AccountData.accountWideLossOfControlVariables)
			
			end
			
			
			
			thisPointY2 = thisPointY2 - 25 
			
			
			-- Soft Target Variables
			local chkAWISaveSoftTarget = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveSoftTarget:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveSoftTarget.Text:SetText("Action Targeting Settings")
			chkAWISaveSoftTarget:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideSoftTargetVariables = chkAWISaveSoftTarget:GetChecked()
			end)
			chkAWISaveSoftTarget:SetChecked(AccWideUI_AccountData.accountWideSoftTargetVariables)
			
			
			
			thisPointY2 = thisPointY2 - 25 
			
			-- Tutorial Variables
			local chkAWISaveTutorials = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkAWISaveTutorials:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkAWISaveTutorials.Text:SetText("Viewed Tutorial Tooltips")
			chkAWISaveTutorials:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideTutorialTooltipVariables = chkAWISaveTutorials:GetChecked()
			end)
			chkAWISaveTutorials:SetChecked(AccWideUI_AccountData.accountWideTutorialTooltipVariables)
			
			
			
			
			
			--[[if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				thisPointY2 = thisPointY2 - 25 
			
				-- Save Bag Sorting Variables
				local chkAWISaveBagSorting = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkAWISaveBagSorting:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkAWISaveBagSorting.Text:SetText("Bag/Bank Sorting Settings")
				chkAWISaveBagSorting:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideBagSortingSettings = chkAWISaveBagSorting:GetChecked()
				end)
				chkAWISaveBagSorting:SetChecked(AccWideUI_AccountData.accountWideBagSortingSettings)
			
			end]]
			
			
			if (thisPointY2 < thisPointY) then
				thisPointY = thisPointY2
			end
			
			--Chat Channels
			
			if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
				
				thisPointX = 16
				
				thisPointY = thisPointY - 30
				
				thisPointYPlus = 128
				
			
				local acBorder2 = AccWideUI_OptionsPanelFrame:CreateTexture(nil, "BACKGROUND")
				acBorder2:SetHeight(8)
				acBorder2:SetPoint("TOPLEFT", thisPointX, thisPointY)
				acBorder2:SetPoint("RIGHT", thisPointX, 0)
				acBorder2:SetTexture(AccWideUI_DividerGraphic)
				

				
				thisPointY = thisPointY - 20
				
				
				
				--Title for Chat Channels
				local titleCAA = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				titleCAA:SetJustifyV('TOP')
				titleCAA:SetJustifyH('LEFT')
				titleCAA:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCAA:SetText("Block Blizzard Chat Channels Account Wide")
				
				
				thisPointY = thisPointY - 25
				
				
				--Title for  Chat Channels2
				local titleCAA2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				titleCAA2:SetJustifyV('TOP')
				titleCAA2:SetJustifyH('LEFT')
				titleCAA2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCAA2:SetText("Check the channels below that you do not want any of your characters on this account to join.")
				
				thisPointY = thisPointY - 20
				
				
				
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
				
				
				
				thisPointX = 16
				
				thisPointY = thisPointY - 24
				
				
				
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
				
				
				
				
				
				
				
				
				
				
				
				
			
			end
			
			
			
			
			
			
			thisPointX = 16

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
				
				
				thisPointY = thisPointY - 20
		
				
				local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
				

				

				
				--Title for Char Specific
				local titleCS = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
				titleCS:SetJustifyV('TOP')
				titleCS:SetJustifyH('LEFT')
				titleCS:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCS:SetText(classColorString:WrapTextInColorCode(UnitName("player")) .. " Specific Options")
				
				thisPointY = thisPointY - 25
				
				--Title for Char Specific2
				local titleCS2 = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlight")
				titleCS2:SetJustifyV('TOP')
				titleCS2:SetJustifyH('LEFT')
				titleCS2:SetPoint('TOPLEFT', thisPointX, thisPointY)
				titleCS2:SetText("Select whether to use the chosen Edit Mode layout for this character's Specializations.")
			

			
			
				--Specialisations
				AccWideUI_SpecName = {}
				AccWideUI_NumSpecializations = GetNumSpecializations(false, false)

				for specx = 1, AccWideUI_NumSpecializations, 1 do
					AccWideUI_SpecName[specx] = PlayerUtil.GetSpecNameBySpecID(select(1, GetSpecializationInfo(specx)))
					
				end
				
				thisPointY = thisPointY - 20
					

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
			
			
			
			
			local colorPet = CreateColor(0.3, 0.3, 0.3)
			local titlePet = AccWideUI_OptionsPanelFrame:CreateFontString("ARTWORK", nil, "GameFontHighlightSmall")
			titlePet:SetJustifyV('BOTTOM')
			titlePet:SetJustifyH('RIGHT')
			titlePet:SetPoint('BOTTOMRIGHT', -15, 15)
			titlePet:SetText(colorPet:WrapTextInColorCode("Dedicated to Petrel <3"))
		
		
			
			SLASH_ACCWIDEUI1 = "/accwideui"
			SLASH_ACCWIDEUI2 = "/accwideeditmode"
			SLASH_ACCWIDEUI3 = "/accwideinterface"
			SLASH_ACCWIDEUI4 = "/accwide"
			SLASH_ACCWIDEUI5 = "/awi"
			function SlashCmdList.ACCWIDEUI(msg)
				Settings.OpenToCategory(AccWideUI_OptionsPanelFrameCategoryID)
			end
			
			
		
	end





	
	function AccWideUI_Frame:LoadUISettings(doNotLoadChatSettings)
	
		doNotLoadChatSettings = doNotLoadChatSettings or false
	
		if (InCombatLockdown()) then
			if (AccWideUI_AccountData.enableDebug == true) then
				print(AccWideUI_TextName .. " Not loading UI Settings while in combat.")
			end
			
		else
		
			
		
			if (AccWideUI_AccountData.enableDebug == true) then
				print(AccWideUI_TextName .. " Loading UI Settings.")
			end
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				-- Use Acc Wide Layout
				local getLayoutsTable = C_EditMode.GetLayouts()
				local currentActiveLayout = getLayoutsTable["activeLayout"]
				local currentSpec = tostring(GetSpecialization())
				
				if (AccWideUI_AccountData.accountWideLayout == true) and (AccWideUI_CharData["accWideSpec" .. currentSpec] == true) then
				

					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Acc Wide UI.")
					end

					--Set the spec
					C_EditMode.SetActiveLayout(AccWideUI_AccountData.accountWideLayoutID)
			
				
			end -- eo accountWideLayout

			end
			
			-- Use Action Bars
			if (AccWideUI_AccountData.accountWideActionBars == true) then
					
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Action Bar Settings.")
				end
				
				
				for k, v in pairs(AccWideUI_Table_ActionBarVariables) do
					SetCVar(v, AccWideUI_AccountData.ActionBars.ActionBarVariables[v])
				end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
						
						SetActionBarToggles(AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5, AccWideUI_AccountData.ActionBars.Bar6, AccWideUI_AccountData.ActionBars.Bar7, AccWideUI_AccountData.ActionBars.Bar8)
					
					else
					
						SetActionBarToggles(AccWideUI_AccountData.ActionBars.Bar2, AccWideUI_AccountData.ActionBars.Bar3, AccWideUI_AccountData.ActionBars.Bar4, AccWideUI_AccountData.ActionBars.Bar5)
					
					end
					
					MultiActionBar_Update()
			
			end -- EO accountWideActionBars


			-- Use Nameplates
			if (AccWideUI_AccountData.accountWideNameplates == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Nameplate Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_NameplateVariables) do
					SetCVar(v, AccWideUI_AccountData.Nameplates[v])
				end
			
			end -- EO accountWideNameplates
			
			
			
			-- Use Raid Frames
			if (AccWideUI_AccountData.accountWideRaidFrames == true) then
		
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Raid Frame Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
					SetCVar(v, AccWideUI_AccountData.RaidFrames[v])
				end
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					
					for i=1, GetMaxNumCUFProfiles() do
					
						local thisRaidProfileName = GetRaidProfileName(i) or nil
						
						if (type(AccWideUI_AccountData.RaidFrameProfiles[i]) == "table") then
							if (type(AccWideUI_AccountData.RaidFrameProfiles[i].name) == "string") then

								if (RaidProfileExists(AccWideUI_AccountData.RaidFrameProfiles[i].name) == false) then
									CreateNewRaidProfile(AccWideUI_AccountData.RaidFrameProfiles[i].name)
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
								end
						
							end
						end
				
					end
					
					
					--remove old
					for i=1, GetMaxNumCUFProfiles() do
					
						local keepThisOne = false
							
						local thisRaidProfileName = GetRaidProfileName(i) or nil
						
						if (type(thisRaidProfileName) == "string") then
					
							for y=1, GetMaxNumCUFProfiles() do
							
								if (type(AccWideUI_AccountData.RaidFrameProfiles[y]) == "table") then
									if (thisRaidProfileName == (AccWideUI_AccountData.RaidFrameProfiles[y].name)) then
										keepThisOne = true
										if (AccWideUI_AccountData.enableDebug == true) then
											print(AccWideUI_TextName .. " Keep " .. thisRaidProfileName)
										end
									end
								end
							
							end
						
						end
						
						if (type(thisRaidProfileName) == "string" and keepThisOne == false) then
							if (AccWideUI_AccountData.enableDebug == true) then
								print(AccWideUI_TextName .. " Delete " .. thisRaidProfileName)
							end
							DeleteRaidProfile(thisRaidProfileName)
							AccWideUI_AccountData.RaidFrameProfiles[i] = nil
						end
						
					end
					

				end
				
	
				
			
			end -- EO accountWideRaidFrames
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				-- Use Arena Frames
				if (AccWideUI_AccountData.accountWideArenaFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Arena Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						SetCVar(v, AccWideUI_AccountData.ArenaFrames[v])
					end
				
				end -- EO accountWideArenaFrames
			end
			
			
			-- Block Social Variables
			if (AccWideUI_AccountData.accountWideBlockSocialVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Block Social Settings.")
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
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Spell Overlay Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_SpellOverlayVariables) do
						SetCVar(v, AccWideUI_AccountData.SpellOverlay[v])
					end
				
				end -- EO accountWideSpellOverlayVariables
			end
			
			
			-- Auto Loot Variables
			if (AccWideUI_AccountData.accountWideAutoLootVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Auto Loot Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_AutoLootVariables) do
					SetCVar(v, AccWideUI_AccountData.AutoLoot[v])
				end
			
			end -- EO accountWideAutoLootVariables
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				-- Loss of Control Variables
				if (AccWideUI_AccountData.accountWideLossOfControlVariables == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Loss of Control Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_LossOfControlVariables) do
						SetCVar(v, AccWideUI_AccountData.LossOfControl[v])
					end
				
				end -- EO accountWideLossOfControlVariables
			
			end
			
			
			-- Soft Target Variables
			if (AccWideUI_AccountData.accountWideSoftTargetVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Soft Target Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_SoftTargetVariables) do
					SetCVar(v, AccWideUI_AccountData.SoftTarget[v])
				end
			
			end -- EO accountWideSoftTargetVariables
			
			
			
			-- Tutorial Variables
			if (AccWideUI_AccountData.accountWideTutorialTooltipVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Tutorial Tooltip Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_TutorialTooltipVariables) do
					SetCVar(v, AccWideUI_AccountData.TutorialTooltips[v])
				end
			end -- EO accountWideTutorialVariables
			
			
			
			--[[if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				-- Bag Sorting Variables
				if (AccWideUI_AccountData.accountWideBagSortingSettings == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Loading Bag Sorting Settings.")
					end
				
					C_Container.SetSortBagsRightToLeft(AccWideUI_AccountData.SpecialVariables.SortBagsRightToLeft)
					C_Container.SetInsertItemsLeftToRight(AccWideUI_AccountData.SpecialVariables.InsertItemsLeftToRight)
				
				end -- EO accountWideBagSortingSettings
			
			end]]
		
		
			-- Chat Window Settings
			
			if (AccWideUI_AccountData.accountWideChatWindowVariables == true and doNotLoadChatSettings == false) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Chat Window Settings.")
				end
				
				
				if (AccWideUI_AccountData.accountWideChatChannelVariables == true) then
				
					C_Timer.After(10, function() 
						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Joining Chat Channels.")
						end
						-- Chat Channels
						for k, v in pairs(AccWideUI_AccountData.ChatChannelsJoined) do
							JoinChannelByName(v)
						end
					end)
					
					
					
					C_Timer.After(14, function() 
					
						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Reordering Chat Channels.")
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
						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Setting Chat Channel Colors.")
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
					
					local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					
					FCF_SetWindowAlpha(
						thisChatFrameVar, 
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.a
					)
					
					SetChatWindowAlpha(
						thisChatFrame, 
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.a
					)
					
					FCF_SetWindowColor(
						thisChatFrameVar,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.r,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.g,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.b
					)
					
					SetChatWindowColor(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.r,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.g,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.b
					)
					
					SetChatWindowDocked(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked
					)
					
					SetChatWindowLocked(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isLocked
					)
					
					SetChatWindowShown(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isShown
					)
					
					SetChatWindowUninteractable(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isUninteractable
					)
					
					SetChatWindowName(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.name
					)
					
					SetChatWindowSize(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.size
					)
					
					SetChatWindowSavedDimensions(
						thisChatFrame,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions.width,
						AccWideUI_AccountData.ChatWindows[thisChatFrame].Dimensions.height
					)
					
					
					if (type(AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.xOffset) ~= "nil") then
						SetChatWindowSavedPosition(
							thisChatFrame,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.point,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.xOffset,
							AccWideUI_AccountData.ChatWindows[thisChatFrame].Positions.yOffset
						)
					end
					
					--Visible Chat Channels
					C_Timer.After((18 + (thisChatFrame * 2)), function() 
					
						local thisWindowChannels = {GetChatWindowChannels(thisChatFrame)}
					
						for i = 1, #thisWindowChannels, 2 do
							local chn, idx = thisWindowChannels[i], thisWindowChannels[i+1]
							
							if (AccWideUI_AccountData.enableDebug == true) then
								print(AccWideUI_TextName .. " Removing " .. chn .. " From Chat Window " .. thisChatFrame .. ".")
							end
							
							ChatFrame_RemoveChannel(thisChatFrameVar, chn)
						end
					
						for k,v in pairs(AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatChannelsVisible) do
						
							if (AccWideUI_AccountData.enableDebug == true) then
								print(AccWideUI_TextName .. " Adding " .. v .. " To Chat Window " .. thisChatFrame .. ".")
							end
							
							ChatFrame_AddChannel(thisChatFrameVar, v)
							
						end
						
					
					
						
					
					end)
					
					
					-- Types of Chat
					C_Timer.After((20 + (thisChatFrame * 2)), function() 
					
						if ((AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isShown == true) or (AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.isDocked)) then
					
							if (AccWideUI_AccountData.enableDebug == true) then
								print(AccWideUI_TextName .. " Setting Chat Types for Chat Window " .. thisChatFrame .. ".")
							end
						
						
							ChatFrame_RemoveAllMessageGroups(thisChatFrameVar)
							
							for k,v in pairs(AccWideUI_AccountData.ChatWindows[thisChatFrame].MessageTypes) do
								 ChatFrame_AddMessageGroup(thisChatFrameVar, v)
								 if (AccWideUI_AccountData.enableDebug == true) then
									print(AccWideUI_TextName .. " Adding " .. v .. " to Chat Window " .. thisChatFrame .. ".")
								 end
							end
						
						end
						
					end)
					
					
					
					
					
					FloatingChatFrame_Update(thisChatFrame)

				end
			
				FCF_DockUpdate()
			
			end
		
		end
	
	end




	function AccWideUI_Frame:SaveUISettings()
	
	
		if (InCombatLockdown()) then
			if (AccWideUI_AccountData.enableDebug == true) then
				print(AccWideUI_TextName .. " Not saving UI Settings while in combat.")
			end
			
		else
		
			if (AccWideUI_AccountData.enableDebug == true) then
				print(AccWideUI_TextName .. " Saving UI Settings.")
			end
			
		
			--Save Shown Action Bars
			if (AccWideUI_AccountData.accountWideActionBars == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Action Bar Settings.")
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
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Nameplate Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_NameplateVariables) do
					AccWideUI_AccountData.Nameplates[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideNameplates
			
			
			
			-- Save Raid Frames
			if (AccWideUI_AccountData.accountWideRaidFrames == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Raid Frame Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_RaidFrameVariables) do
					AccWideUI_AccountData.RaidFrames[v] = GetCVar(v) or nil
				end
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
					for i=1, GetMaxNumCUFProfiles() do
														
						local thisRaidProfileName = GetRaidProfileName(i) or nil
					
						if (type(thisRaidProfileName) ~= "nil") then
							if (RaidProfileExists(thisRaidProfileName)) then
							
								
								AccWideUI_AccountData.RaidFrameProfiles[i] = {}
							
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
			end
				
			
			end -- EO accountWideRaidFrames
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				-- Save Arena Frames
				if (AccWideUI_AccountData.accountWideArenaFrames == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Arena Frame Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_ArenaFrameVariables) do
						AccWideUI_AccountData.ArenaFrames[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideArenaFrames
			end
			
			
			-- Save Social Variables
			if (AccWideUI_AccountData.accountWideBlockSocialVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Block Social Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_BlockSocialVariables) do
					AccWideUI_AccountData.BlockSocial[v] = GetCVar(v) or nil
				end
				
			
			end -- EO accountWideBlockSocialVariables
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				-- Save Spell Overlay Variables
				if (AccWideUI_AccountData.accountWideSpellOverlayVariables == true) then
				
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Spell Overlay Settings.")
					end
				
					for k, v in pairs(AccWideUI_Table_SpellOverlayVariables) do
						AccWideUI_AccountData.SpellOverlay[v] = GetCVar(v) or nil
					end
				
				end -- EO accountWideSpellOverlayVariables
			end
			
			
			-- Save Auto Loot Variables
			if (AccWideUI_AccountData.accountWideAutoLootVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Auto Loot Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_AutoLootVariables) do
					AccWideUI_AccountData.AutoLoot[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideAutoLootVariables
			
			
			
			-- Save Loss of Control Variables
			if (AccWideUI_AccountData.accountWideLossOfControlVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Loss of Control Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_LossOfControlVariables) do
					AccWideUI_AccountData.LossOfControl[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideLossOfControlVariables
			
			
			-- Save Soft Target Variables
			if (AccWideUI_AccountData.accountWideSoftTargetVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Soft Target Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_SoftTargetVariables) do
					AccWideUI_AccountData.SoftTarget[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideSoftTargetVariables
			
			
			-- Save Tutorial Variables
			if (AccWideUI_AccountData.accountWideTutorialTooltipVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Tutorial Tooltip Settings.")
				end
			
				for k, v in pairs(AccWideUI_Table_TutorialTooltipVariables) do
					AccWideUI_AccountData.TutorialTooltips[v] = GetCVar(v) or nil
				end
			
			end -- EO accountWideTutorialVariables
			
			
			
			--[[if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				-- Save Bag Sorting Variables
				if (AccWideUI_AccountData.accountWideBagSortingSettings == true) then
					
					if (AccWideUI_AccountData.enableDebug == true) then
						print(AccWideUI_TextName .. " Saving Bag Sorting Settings.")
					end
				
					AccWideUI_AccountData.SpecialVariables.SortBagsRightToLeft = C_Container.GetSortBagsRightToLeft()
					AccWideUI_AccountData.SpecialVariables.InsertItemsLeftToRight = C_Container.GetInsertItemsLeftToRight()
				
				end -- EO accountWideBagSortingSettings
			
			end]]
			
			
			-- Save Chat Window Variables
			if (AccWideUI_AccountData.accountWideChatWindowVariables == true) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Saving Chat Window Settings.")
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








	function AccWideUI_Frame:CompartmentIsSpecActive(thisSpec)
	
		if (thisSpec == true) then
			return("|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t")
		else
			return("|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t")
		end	
	
	end
	
	

	
	
	
	
	--Addon Compartment
	local AccWideUI_Tooltip

	function AccWideUI_CompartmentClick(addonName, buttonName)
		Settings.OpenToCategory(AccWideUI_OptionsPanelFrameCategoryID)
	end

	function AccWideUI_CompartmentHover(addonName, buttonName)
	
			if (not AccWideUI_Tooltip) then
				AccWideUI_Tooltip = CreateFrame("GameTooltip", "AccWideUI_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
			end
			
			local classColorString = C_ClassColor.GetClassColor(UnitClass("player")) or NORMAL_FONT_COLOR
			
			AccWideUI_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
			AccWideUI_Tooltip:SetText("Account Wide Interface Option Settings")
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				AccWideUI_Tooltip:AddLine(" ")
				AccWideUI_Tooltip:AddLine("Current Settings for " .. classColorString:WrapTextInColorCode(UnitName("player")) .. ":",  WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
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
			AccWideUI_Tooltip:AddLine("Click to change settings.",  GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
			
			AccWideUI_Tooltip:Show()
		
	end

	function AccWideUI_CompartmentLeave(buttonName)
			AccWideUI_Tooltip:Hide()
	end



