local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:GenerateDefaultDB()

	local defaults = {
		global = {
			hasDoneFirstTimeSetup = false,
			printDebugTextToChat = false,
			printWhenLastSaved = false,
			enableTextOutput = false
		},
		profile = {
			lastSaved = {
				character = "Unknown",
				unixTime = GetServerTime()
			},
			syncToggles = {
				editModeLayout = true,
				editModeOnByDefault = true,
				actionBars = true,
				nameplates = true,
				raidFrames = true,
				blockSocial = true,
				autoLoot = true,
				softTarget = true,
				tutorialTooltips = true,
				battlefieldMap = true,
				mouseoverCast = true,
				empowerTap = true,
				cooldownViewer = true,
				lossOfControl = true,
				bagOrganisation = false,
				arenaFrames = true,
				spellOverlay = true,
				chatWindow = true,
				chatWindowPosition = true,
				chatChannels = true
			},
			syncData = {
				editModeLayoutID = "unset",
				actionBars = {
					visible = {},
					cvars = {}
				},
				nameplates = {
					cvars = {}
				},
				arenaFrames = {
					cvars = {}
				},
				empowerTap = {
					cvars = {}
				},
				raidFrames = {
					cvars = {},
					profiles = {}
				},
				blockSocial = {
					cvars = {},
					special = {
						blockGuildInvites = nil
					}
				},
				spellOverlay = {
					cvars = {}
				},
				autoLoot = {
					cvars = {}
				},
				softTarget = {
					cvars = {}
				},
				tutorialTooltips = {
					cvars = {}
				},
				battlefieldMap = { 
					options = { -- Defaults from https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_BattlefieldMap/Blizzard_BattlefieldMap.lua#L11
						opacity = 0.7,
						locked = true,
						showPlayers = true,
						position = {
							x = nil,
							y = nil
						},
					},
					
					cvars = {}
				},
				mouseoverCast = {
					cvars = {}
				},
				lossOfControl = {
					cvars = {}
				},
				cooldownViewer = {
					cvars = {}
				},
				chat = {
					windows = {},
					channelsJoined = {},
					info = {}
				},
				bagOrganisation = {
					bags = {
					
					},
					settings = {
						SortBagsRightToLeft = nil,
						InsertItemsLeftToRight = nil,
						BackpackAutosortDisabled = nil,
						BackpackSellJunkDisabled = nil,
						BankAutosortDisabled = nil,
					}
				}
			},
			blockChannels = {
				general = false,
				localDefense = false,
				trade = false,
				lookingForGroup = false,
				services = false,
				worldDefense = false,
				guildRecruitment = false,
				hardcoreDeaths = false
			}
		},
		char = {
			useEditModeLayout = {
				spec1 = nil,
				spec2 = nil,
				spec3 = nil,
				spec4 = nil,
				spec5 = nil
			}
		
		}
	}

	return defaults

end



function AccWideUIAceAddon:GenerateOptions()

	local optionsData = {
		type = "group",
		name = "Account Wide Interface Options Settings",
		handler = AccWideUIAceAddon,
		args = {
			desc = {
				type = "description",
				fontSize = "small",
				order = 1,
				width = "full",
				name = "Synchronises various Character-Specific Interface Settings Account Wide."
			},
			optionsSyncSettings = {
				type = "group",
				name = "Sync Settings",
				order = 2,
				args = {
					syncToggles = {
						type = "group",
						name = "Synchronisation Toggles",
						order = 3,
						inline = true,
						get = "GetSyncToggle",
						set = "SetSyncToggle",
						args = {
							desc = {
								type = "description",
								fontSize = "medium",
								order = 1,
								width = "full",
								name = "Which UI Settings would you like to synchronise Account Wide?"
							},
							softTarget = {
								type = "toggle",
								name = "Action Targeting Settings",
								order = 2,
								width = "full",
								--desc = "some description",
							},
							arenaFrames = {
								type = "toggle",
								name = "Arena Frame Settings",
								order = 3,
								width = "full",
								--desc = "some description",
							},
							autoLoot = {
								type = "toggle",
								name = "Auto Loot Settings",
								order = 4,
								width = "full",
								--desc = "some description",
							},
							bagOrganisation = {
								type = "toggle",
								name = "Bag Organisation Settings",
								order = 6,
								width = "full",
								--desc = "some description",
							},
							blockSocial = {
								type = "toggle",
								name = "Block Guild/Trade/Chat Channel Invite Settings",
								order = 7,
								width = "full",
								--desc = "some description",
							},
							chatWindow = {
								type = "toggle",
								name = "Chat Window Settings",
								order = 8,
								width = "full",
								--desc = "some description",
							},
							chatWindowPosition = {
								type = "toggle",
								name = "Chat Window Positions",
								order = 9,
								width = "full",
								disabled = "ShouldChatOptsDisable"
								--desc = "some description",
							},
							chatChannels = {
								type = "toggle",
								name = "Custom Chat Channels",
								order = 10,
								width = "full",
								disabled = "ShouldChatOptsDisable"
								--desc = "some description",
							},
							cooldownViewer = {
								type = "toggle",
								name = "Cooldown Viewer Setting",
								order = 11,
								width = "full",
								--desc = "some description",
							},
							editModeLayout = {
								type = "toggle",
								name = "Chosen Edit Mode Layout",
								order = 12,
								width = "full",
								--desc = "some description",
							},
							empowerTap = {
								type = "toggle",
								name = "Empowered Tap/Hold Setting",
								order = 13,
								width = "full",
								--desc = "some description",
							},
							lossOfControl = {
								type = "toggle",
								name = "Loss of Control Settings",
								order = 14,
								width = "full",
								--desc = "some description",
							},
							mouseoverCast = {
								type = "toggle",
								name = "Mouseover/Self Cast Settings",
								order = 15,
								width = "full",
								--desc = "some description",
							},
							nameplates = {
								type = "toggle",
								name = "Nameplate Settings",
								order = 16,
								width = "full",
								--desc = "some description",
							},
							raidFrames = {
								type = "toggle",
								name = "Raid Frame Settings",
								order = 17,
								width = "full",
								--desc = "some description",
							},
							spellOverlay = {
								type = "toggle",
								name = "Spell Overlay Settings",
								order = 18,
								width = "full",
								--desc = "some description",
							},
							tutorialTooltips = {
								type = "toggle",
								name = "Tutorial Tooltip Settings",
								order = 19,
								width = "full",
								--desc = "some description",
							},
							actionBars = {
								type = "toggle",
								name = "Visible Action Bars",
								order = 20,
								width = "full",
								--desc = "some description",
							},
							battlefieldMap = {
								type = "toggle",
								name = "Zone Map Settings",
								order = 21,
								width = "full",
								--desc = "some description",
							},						
						},
					},
					headerDiv2 = {
						type = "header",
						name = "",
						order = 4
					},
					editModeSettings = {
						type = "group",
						name = "Edit Mode Specific Settings",
						order = 5,
						inline = true,
						get = "GetSyncToggle",
						set = "SetSyncToggle",
						args = {
							editModeLayout = {
								type = "toggle",
								name = "Sync Chosen Edit Mode Layout",
								order = 1,
								width = "full",
								--desc = "some description",
							},
							editModeOnByDefault = {
								type = "toggle",
								name = "Enable Chosen Edit Mode Layout by default for all New Characters",
								order = 2,
								width = "full",
								--desc = "some description",
							},
							header1 = {
								type = "header",
								name = UnitNameUnmodified("player") .. " Specific Options",
								order = 3,
							},
							desc1 = {
								type = "description",
								fontSize = "medium",
								order = 4,
								width = "full",
								name = "Select whether to use the chosen Edit Mode layout for this character's Specializations."
							},
						}
					},
					
				}
				
			},
			blockChannelToggles = {
				type = "group",
				name = "Block Chat Channel Settings",
				order = 4,
				get = "GetBlockChannelToggle",
				set = "SetBlockChannelToggle",
				args = {
					desc = {
						type = "description",
						fontSize = "medium",
						order = 1,
						width = "full",
						name = "Check the channels below that you do not want any of your characters to join."
					},
					general = {
						type = "toggle",
						name = "General Channel",
						width = "full",
						order = 2,
						--desc = "some description",
					},
					trade = {
						type = "toggle",
						name = "Trade Channel",
						width = "full",
						order = 3,
						--desc = "some description",
					},
					localDefense = {
						type = "toggle",
						name = "LocalDefense Channel",
						width = "full",
						order = 4,
						--desc = "some description",
					},
					lookingForGroup = {
						type = "toggle",
						name = "LookingForGroup Channel",
						width = "full",
						order = 5,
						--desc = "some description",
					},
					services = {
						type = "toggle",
						name = "Services Channel",
						width = "full",
						order = 6,
						--desc = "some description",
					},
					guildRecruitment = {
						type = "toggle",
						name = "GuildRecruitment Channel",
						width = "full",
						order = 7,
						--desc = "some description",
					},
					worldDefense = {
						type = "toggle",
						name = "WorldDefense Channel",
						width = "full",
						order = 8,
						--desc = "some description",
					},
					hardcoreDeaths = {
						type = "toggle",
						name = "HardcoreDeaths Channel",
						width = "full",
						order = 9,
						--desc = "some description",
					},
				}
			},
			optionsDebug = {
				type = "group",
				name = "Advanced",
				--handler = AccWideUIAceAddon,
				get = "GetGlobalToggle",
				set = "SetGlobalToggle",
				order = 5,
				args = {
					desc = {
						type = "description",
						fontSize = "medium",
						order = 1,
						width = "full",
						name = "Settings on this page will apply to all profiles on your account.",
					},
					enableTextOutput = {
						type = "toggle",
						name = "Output to chat when the addon has loaded.",
						width = "full",
						order = 3,
						--desc = "some description",
					},
					printWhenLastSaved = {
						type = "toggle",
						name = "Output to chat when settings were last saved.",
						width = "full",
						order = 4,
						--desc = "some description",
					},
					printDebugTextToChat = {
						type = "toggle",
						name = "Output verbose debug text to chat.",
						width = "full",
						order = 6,
						--desc = "some description",
					},
					btnForceLoad = {
						type = "execute",
						name = "Force Load Settings",
						order = 7,
						func = function() self:CancelAllTimers(); self:LoadUISettings() end,
					},
					btnForceSave = {
						type = "execute",
						name = "Force Save Settings",
						order = 8,
						func = function() self:SaveUISettings(); self:SaveBagFlagSettings(true); end,
					}
				}
			}
		}
	}
	
	
	-- Edit Mode Specs
	if (AccWideUIAceAddon:IsMainline()) then
	
		local NumOfSpecs = GetNumSpecializations(false, false)

		for ThisSpecX = 1, NumOfSpecs, 1 do
			optionsData.args.optionsSyncSettings.args.editModeSettings.args["spec" .. ThisSpecX] = {
				type = "toggle",
				name = PlayerUtil.GetSpecNameBySpecID(select(1, C_SpecializationInfo.GetSpecializationInfo(ThisSpecX))),
				order = (5 + ThisSpecX),
				get = "GetEditModeSpec",
				set = "SetEditModeSpec"
				--desc = "some description",
			}
		end
	
	else
		optionsData.args.optionsSyncSettings.args.editModeSettings = nil
	end
	
	
	
	
	
	
	
	-- Hide Block Chat Channels if BlockBlizzChatChannels is installed
	if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == true) then
		optionsData.args.optionsSyncSettings.args.blockChannelToggles = nil
	end
	
	
	-- Remove Sync options that are not applicable to various versions
	if (AccWideUIAceAddon:IsMainline() == false) then
		optionsData.args.optionsSyncSettings.args.editModeSettings = nil	
		optionsData.args.optionsSyncSettings.args.headerDiv2 = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.bagOrganisation = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.cooldownViewer = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.editModeLayout = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.empowerTap = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.lossOfControl = nil
	end
	
	if (AccWideUIAceAddon:IsClassicEra() == true) then
		optionsData.args.optionsSyncSettings.args.syncToggles.args.arenaFrames = nil
		optionsData.args.optionsSyncSettings.args.syncToggles.args.spellOverlay = nil
	end



	-- Remove Chat options that are not applicable to various versions
	if (AccWideUIAceAddon:IsMainline()) then
		optionsData.args.blockChannelToggles.args.worldDefense = nil
		optionsData.args.blockChannelToggles.args.HardcoreDeaths = nil
	end

	if (AccWideUIAceAddon:IsClassicWrath() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.guildRecruitment = nil
	end

	if (AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.hardcoreDeaths = nil
	end
	
	if (AccWideUIAceAddon:IsMainline() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.services = nil
	end
	
	
	

	
	return optionsData


end




-- for documentation on the info table
-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables#title-4-1
function AccWideUIAceAddon:GetSyncToggle(info)
	return self.db.profile.syncToggles[info[#info]]
end

function AccWideUIAceAddon:SetSyncToggle(info, value)
	self.db.profile.syncToggles[info[#info]] = value
end

function AccWideUIAceAddon:GetBlockChannelToggle(info)
	return self.db.profile.blockChannels[info[#info]]
end

function AccWideUIAceAddon:SetBlockChannelToggle(info, value)
	self.db.profile.blockChannels[info[#info]] = value
end

function AccWideUIAceAddon:GetGlobalToggle(info)
	return self.db.global[info[#info]]
end

function AccWideUIAceAddon:SetGlobalToggle(info, value)
	self.db.global[info[#info]] = value
end

function AccWideUIAceAddon:GetEditModeSpec(info)
	return self.db.char.useEditModeLayout[info[#info]]
end

function AccWideUIAceAddon:SetEditModeSpec(info, value)
	self.db.char.useEditModeLayout[info[#info]] = value
end

function AccWideUIAceAddon:ShouldChatOptsDisable()
	if (self.db.profile.syncToggles.chatWindow == true) then
		return false
	else
		return true
	end
end
