--[[
=====================================================
Account Wide Interface Option Settings
https://github.com/NinerBull/AccWideUILayoutSelection
=====================================================
]]--


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

AccWideUI_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
AccWideUI_Frame:RegisterEvent("SETTINGS_LOADED")
AccWideUI_Frame:RegisterEvent("PLAYER_LOGOUT")
AccWideUI_Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
AccWideUI_Frame:RegisterEvent("CHANNEL_UI_UPDATE")
AccWideUI_Frame:RegisterEvent("DISABLE_DECLINE_GUILD_INVITE")
AccWideUI_Frame:RegisterEvent("ENABLE_DECLINE_GUILD_INVITE")
AccWideUI_Frame:RegisterEvent("ADDON_LOADED")
AccWideUI_Frame:RegisterEvent("LOADING_SCREEN_DISABLED")
AccWideUI_Frame:RegisterEvent("LOADING_SCREEN_ENABLED")

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	AccWideUI_Frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

local AccWideUI_TextName = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("<Account Wide Interface>")
local AccWideUI_TextSlash = ITEM_LEGENDARY_COLOR:WrapTextInColorCode("/awi")
local AccWideUI_ThisCategory = nil

	

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
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
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
						if (GetChannelName((GetChannelName("General"))) > 0) then
							LeaveChannelByName("General")
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockLocalDefense == true) then
						if (GetChannelName((GetChannelName("LocalDefense"))) > 0) then
							LeaveChannelByName("LocalDefense")
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockTrade == true) then
						if (GetChannelName((GetChannelName("Trade"))) > 0) then
							LeaveChannelByName("Trade")
						end
					end
					
					if (AccWideUI_AccountData.ChatChannels.BlockLookingForGroup == true) then
						if (GetChannelName((GetChannelName("LookingForGroup"))) > 0) then
							LeaveChannelByName("LookingForGroup")
						end
					end
					
					if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
						if (AccWideUI_AccountData.ChatChannels.BlockServices == true) then
							if (GetChannelName((GetChannelName("Services"))) > 0) then
								LeaveChannelByName("Services")
							end
						end
					end
					
					if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
						if (AccWideUI_AccountData.ChatChannels.BlockWorldDefense == true) then
							if (GetChannelName((GetChannelName("WorldDefense"))) > 0) then
								LeaveChannelByName("WorldDefense")
							end
						end
					end
				
				
				end
			
			end
			
		
		end

	end)

	function AccWideUI_Frame:InitializeOptionsFrame()
	
	
			AccWideUI_OptionsPanelFrame = CreateFrame("Frame");
			
			AccWideUI_Category = Settings.RegisterCanvasLayoutCategory(AccWideUI_OptionsPanelFrame, "Account Wide Interface Option Setting")
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
			title2:SetText("Makes your chosen Interface Options apply for all of your characters and specs.")
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then

				thisPointY = thisPointY - 20
				
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
				
				
				thisPointY = thisPointY - 30
				
				--Enable by Default
				local chkEnableDefault = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkEnableDefault:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkEnableDefault.Text:SetText("Enable Edit Mode by default for all New Characters")
				chkEnableDefault:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableAccountWide = chkEnableDefault:GetChecked()
				end)
				chkEnableDefault:SetChecked(AccWideUI_AccountData.enableAccountWide)
		
			end
			
			
			thisPointY = thisPointY - 25
			
			
			-- Show Text
			local chkShowText = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkShowText:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkShowText.Text:SetText("Output to chat when addon is loaded")
			chkShowText:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.enableTextOutput = chkShowText:GetChecked()
			end)
			chkShowText:SetChecked(AccWideUI_AccountData.enableTextOutput)
			
			
			
			
			thisPointY = -160
			
			
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
			titleSA2:SetText("What kind of UI settings would you like to save Account Wide?")
			
			local thisPointY2 = thisPointY
			
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				thisPointY = thisPointY - 25 
			
				-- Save Edit Mode Layout
				local chkSaveEditModeLayout = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveEditModeLayout:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveEditModeLayout.Text:SetText("Chosen Edit Mode Layout")
				chkSaveEditModeLayout:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLayout = chkSaveEditModeLayout:GetChecked()
				end)
				chkSaveEditModeLayout:SetChecked(AccWideUI_AccountData.accountWideLayout)
			
			end


			thisPointY = thisPointY - 25 
			
			
			-- Save Action Bars
			local chkSaveActionBar = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveActionBar:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkSaveActionBar.Text:SetText("Visible Action Bars")
			chkSaveActionBar:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideActionBars = chkSaveActionBar:GetChecked()
			end)
			chkSaveActionBar:SetChecked(AccWideUI_AccountData.accountWideActionBars)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Nameplates
			local chkSaveNameplates = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveNameplates:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkSaveNameplates.Text:SetText("Nameplate Settings")
			chkSaveNameplates:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideNameplates = chkSaveNameplates:GetChecked()
			end)
			chkSaveNameplates:SetChecked(AccWideUI_AccountData.accountWideNameplates)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Raid Frames
			local chkSaveRaidFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveRaidFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkSaveRaidFrames.Text:SetText("Party/Raid Frame Settings")
			chkSaveRaidFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideRaidFrames = chkSaveRaidFrames:GetChecked()
			end)
			chkSaveRaidFrames:SetChecked(AccWideUI_AccountData.accountWideRaidFrames)
			
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY = thisPointY - 25 
				
				
				-- Save Arena Frames
				local chkSaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkSaveArenaFrames.Text:SetText("Arena Frame Settings")
				chkSaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideArenaFrames = chkSaveArenaFrames:GetChecked()
				end)
				chkSaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideArenaFrames)
			end
			
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Chat Window
			local chkSaveChatWindow = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveChatWindow:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkSaveChatWindow.Text:SetText("Chat Window Settings")
			chkSaveChatWindow:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatWindowVariables = chkSaveChatWindow:GetChecked()
			end)
			chkSaveChatWindow:SetChecked(AccWideUI_AccountData.accountWideChatWindowVariables)
			
			thisPointY = thisPointY - 25 
			
			
			-- Save Chat Channels
			local chkSaveChatChannels = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveChatChannels:SetPoint("TOPLEFT", thisPointX, thisPointY)
			chkSaveChatChannels.Text:SetText("+ Custom Chat Channels (Req. Chat Window Settings)")
			chkSaveChatChannels:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideChatChannelVariables = chkSaveChatChannels:GetChecked()
			end)
			chkSaveChatChannels:SetChecked(AccWideUI_AccountData.accountWideChatChannelVariables)
			
			
			
			
			
			
			-- 2nd Column
			
			thisPointX = 230
			
			thisPointY2 = thisPointY2 - 25 
							
			
			-- Block Social Variables
			local chkSaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkSaveArenaFrames.Text:SetText("Block Guild/Trade/Channel Invite Settings")
			chkSaveArenaFrames:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideBlockSocialVariables = chkSaveArenaFrames:GetChecked()
			end)
			chkSaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideBlockSocialVariables)
			
			
			if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
				thisPointY2 = thisPointY2 - 25 
				
				
				-- Spell Overlay Variables
				local chkSaveArenaFrames = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveArenaFrames:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkSaveArenaFrames.Text:SetText("Spell Overlay Settings")
				chkSaveArenaFrames:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideSpellOverlayVariables = chkSaveArenaFrames:GetChecked()
				end)
				chkSaveArenaFrames:SetChecked(AccWideUI_AccountData.accountWideSpellOverlayVariables)
			end
			
			
			
			thisPointY2 = thisPointY2 - 25 
			
			
			-- Auto Loot Variables
			local chkSaveAutoLoot = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveAutoLoot:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkSaveAutoLoot.Text:SetText("Auto Loot Settings")
			chkSaveAutoLoot:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideAutoLootVariables = chkSaveAutoLoot:GetChecked()
			end)
			chkSaveAutoLoot:SetChecked(AccWideUI_AccountData.accountWideAutoLootVariables)
			
			
			
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
				
				thisPointY2 = thisPointY2 - 25 
			
				-- Save Loss of Control Variables
				local chkSaveLossOfControl = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkSaveLossOfControl:SetPoint("TOPLEFT", thisPointX, thisPointY2)
				chkSaveLossOfControl.Text:SetText("Loss of Control Settings")
				chkSaveLossOfControl:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.accountWideLossOfControlVariables = chkSaveLossOfControl:GetChecked()
				end)
				chkSaveLossOfControl:SetChecked(AccWideUI_AccountData.accountWideLossOfControlVariables)
			
			end
			
			
			
			thisPointY2 = thisPointY2 - 25 
			
			
			-- Soft Target Variables
			local chkSaveSoftTarget = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
			chkSaveSoftTarget:SetPoint("TOPLEFT", thisPointX, thisPointY2)
			chkSaveSoftTarget.Text:SetText("Action Targeting Settings")
			chkSaveSoftTarget:HookScript("OnClick", function(_, btn, down)
					AccWideUI_AccountData.accountWideSoftTargetVariables = chkSaveSoftTarget:GetChecked()
			end)
			chkSaveSoftTarget:SetChecked(AccWideUI_AccountData.accountWideSoftTargetVariables)
			
			
			
			
			
			--Chat Channels
			
			if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
				
				thisPointX = 16
				
				thisPointY = -400
				
				
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
				local chkBlockGeneralChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkBlockGeneralChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkBlockGeneralChat.Text:SetText("General")
				chkBlockGeneralChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockGeneral = chkBlockGeneralChat:GetChecked()
				end)
				chkBlockGeneralChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockGeneral)
				
				thisPointX = thisPointX + 128
				
				-- Trade Chat
				local chkBlockTradeChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkBlockTradeChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkBlockTradeChat.Text:SetText("Trade")
				chkBlockTradeChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockTrade = chkBlockTradeChat:GetChecked()
				end)
				chkBlockTradeChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockTrade)
				
				thisPointX = thisPointX + 128
				
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					-- Services Chat
					local chkBlockServicesChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkBlockServicesChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkBlockServicesChat.Text:SetText("Services")
					chkBlockServicesChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockServices = chkBlockServicesChat:GetChecked()
					end)
					chkBlockServicesChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockServices)
					
					thisPointX = thisPointX + 128
				end
				
				
				-- LocalDefense Chat
				local chkBlockLocalDefenseChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkBlockLocalDefenseChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkBlockLocalDefenseChat.Text:SetText("LocalDefense")
				chkBlockLocalDefenseChat:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockLocalDefense = chkBlockLocalDefenseChat:GetChecked()
				end)
				chkBlockLocalDefenseChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockLocalDefense)
				
				thisPointX = thisPointX + 128
				
				
				if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
					-- WorldDefense Chat
					local chkBlockWorldDefenseChat = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkBlockWorldDefenseChat:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkBlockWorldDefenseChat.Text:SetText("WorldDefense")
					chkBlockWorldDefenseChat:HookScript("OnClick", function(_, btn, down)
							AccWideUI_AccountData.ChatChannels.BlockWorldDefense = chkBlockWorldDefenseChat:GetChecked()
					end)
					chkBlockWorldDefenseChat:SetChecked(AccWideUI_AccountData.ChatChannels.BlockWorldDefense)
					
					thisPointX = thisPointX + 128
				end
				
				
				-- LookingForGroup Chat
				local chkBlockLookingForGroup = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
				chkBlockLookingForGroup:SetPoint("TOPLEFT", thisPointX, thisPointY)
				chkBlockLookingForGroup.Text:SetText("LFG")
				chkBlockLookingForGroup:HookScript("OnClick", function(_, btn, down)
						AccWideUI_AccountData.ChatChannels.BlockLookingForGroup = chkBlockLookingForGroup:GetChecked()
				end)
				chkBlockLookingForGroup:SetChecked(AccWideUI_AccountData.ChatChannels.BlockLookingForGroup)
				
				--thisPointX = thisPointX + 128
				
				
				
				
				
				
				
			
			end
			
			
			
			
			
			
			thisPointX = 16

			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == false) then
					thisPointY = -490
				else
					thisPointY = -400
				end
		
				
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
				
					
				
					local chkEnableSpec1 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableSpec1:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableSpec1.Text:SetText(AccWideUI_SpecName[1])
					chkEnableSpec1:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 1] = chkEnableSpec1:GetChecked()
					end)
					chkEnableSpec1:SetChecked(AccWideUI_CharData["accWideSpec" .. 1])

				end
				
				if (AccWideUI_NumSpecializations >= 2) then
				
					thisPointX = thisPointX + 128
				
					local chkEnableSpec2 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableSpec2:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableSpec2.Text:SetText(AccWideUI_SpecName[2])
					chkEnableSpec2:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 2] = chkEnableSpec2:GetChecked()
					end)
					chkEnableSpec2:SetChecked(AccWideUI_CharData["accWideSpec" .. 2])

				end
				
				if (AccWideUI_NumSpecializations >= 3) then
				
					thisPointX = thisPointX + 128
				
					local chkEnableSpec3 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableSpec3:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableSpec3.Text:SetText(AccWideUI_SpecName[3])
					chkEnableSpec3:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 3] = chkEnableSpec3:GetChecked()
					end)
					chkEnableSpec3:SetChecked(AccWideUI_CharData["accWideSpec" .. 3])

				end
				
				if (AccWideUI_NumSpecializations >= 4) then
				
					thisPointX = thisPointX + 128
				
					local chkEnableSpec4 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableSpec4:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableSpec4.Text:SetText(AccWideUI_SpecName[4])
					chkEnableSpec4:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 4] = chkEnableSpec4:GetChecked()
					end)
					chkEnableSpec4:SetChecked(AccWideUI_CharData["accWideSpec" .. 4])

				end
				
				if (AccWideUI_NumSpecializations >= 5) then
				
					thisPointX = thisPointX + 128
				
					local chkEnableSpec5 = CreateFrame("CheckButton", nil, AccWideUI_OptionsPanelFrame, "InterfaceOptionsCheckButtonTemplate")
					chkEnableSpec5:SetPoint("TOPLEFT", thisPointX, thisPointY)
					chkEnableSpec5.Text:SetText(AccWideUI_SpecName[5])
					chkEnableSpec5:HookScript("OnClick", function(_, btn, down)
						AccWideUI_CharData["accWideSpec" .. 5] = chkEnableSpec5:GetChecked()
					end)
					chkEnableSpec5:SetChecked(AccWideUI_CharData["accWideSpec" .. 5])

				end
				
			
			end
		
		
			
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
			
		
		
			-- Chat Window Settings
			
			if (AccWideUI_AccountData.accountWideChatWindowVariables == true and doNotLoadChatSettings == false) then
			
				if (AccWideUI_AccountData.enableDebug == true) then
					print(AccWideUI_TextName .. " Loading Chat Window Settings.")
				end
				
				
				if (AccWideUI_AccountData.accountWideChatChannelVariables == true) then
				
					C_Timer.After(5, function() 
						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Joining Chat Channels.")
						end
						-- Chat Channels
						for k, v in pairs(AccWideUI_AccountData.ChatChannelsJoined) do
							JoinChannelByName(v)
						end
					end)
					
					C_Timer.After(10, function() 
					
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
					
	
					
					C_Timer.After(12, function() 
						if (AccWideUI_AccountData.enableDebug == true) then
							print(AccWideUI_TextName .. " Setting Chat Channel Colors.")
						end
						-- Chat Colours
						for k, v in pairs(AccWideUI_Table_ChatTypes) do
							if (type(ChatTypeInfo[v]) == "table") then
								ChangeChatColor(v, AccWideUI_AccountData.ChatInfo[v][1].r, AccWideUI_AccountData.ChatInfo[v][1].g, AccWideUI_AccountData.ChatInfo[v][1].b)
								
								SetChatColorNameByClass(v, AccWideUI_AccountData.ChatInfo[v][1].colorNameByClass)
								
							end
						end
					end)
				
				
				end
				
				
				
				
				-- Individual Chat Window/Tab Settings
				for thisChatFrame = 1, NUM_CHAT_WINDOWS do
					
					local thisChatFrameVar = _G["ChatFrame" .. thisChatFrame]
					
					
					SetChatWindowAlpha(
						thisChatFrame, 
						AccWideUI_AccountData.ChatWindows[thisChatFrame].ChatWindowInfo.a
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
					C_Timer.After((15 + (thisChatFrame * 2)), function() 
					
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
				
				-- Special
				--AccWideUI_AccountData.SpecialVariables.BlockGuildInvites = GetAutoDeclineGuildInvites()
			
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



