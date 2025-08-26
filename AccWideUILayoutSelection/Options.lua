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
		name = L["ACCWUI_ADDONNAME"],
		handler = AccWideUIAceAddon,
		args = {
			desc = {
				type = "description",
				fontSize = "small",
				order = 1,
				width = "full",
				name = L["ACCWUI_OPT_TITLE_DESC"]
			},
			optionsSyncSettings = {
				type = "group",
				name = L["ACCWUI_OPT_SYNCSETTINGS_TITLE"],
				desc = L["ACCWUI_OPT_SYNCSETTINGS_DESC"],
				order = 2,
				args = {
					syncToggles = {
						type = "group",
						name = L["ACCWUI_OPT_MODULES_TITLE"],
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
								name = L["ACCWUI_OPT_MODULES_DESC"]
							},
							softTarget = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_TARGETING"],
								order = 2,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_TARGETING_DESC"],
							},
							arenaFrames = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_ARENA"],
								order = 3,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_ARENA_DESC"],
							},
							autoLoot = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT"],
								order = 4,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT_DESC"],
							},
							bagOrganisation = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_BAGS"],
								order = 6,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_BAGS_DESC"],
							},
							blockSocial = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_TRADEGUILD"],
								order = 7,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_TRADEGUILD_DESC"],
							},
							chatWindow = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW"],
								order = 8,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW_DESC"],
							},
							chatWindowPosition = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION"],
								order = 9,
								width = "full",
								disabled = "ShouldChatOptsDisable",
								desc = L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION_DESC"],
							},
							chatChannels = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS"],
								order = 10,
								width = "full",
								disabled = "ShouldChatOptsDisable",
								desc = L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS_DESC"],
							},
							cooldownViewer = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_COOLDOWN"],
								order = 11,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_COOLDOWN_DESC"],
							},
							editModeLayout = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_EDITMODE"],
								order = 12,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_EDITMODE_DESC"],
							},
							empowerTap = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_EMPOWERED"],
								order = 13,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_EMPOWERED_DESC"],
							},
							lossOfControl = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_LOC"],
								order = 14,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_LOC_DESC"],
							},
							mouseoverCast = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER"],
								order = 15,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER_DESC"],
							},
							nameplates = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES"],
								order = 16,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES_DESC"],
							},
							raidFrames = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_PARTYRAID"],
								order = 17,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_PARTYRAID_DESC"],
							},
							spellOverlay = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY"],
								order = 18,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY_DESC"],
							},
							tutorialTooltips = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP"],
								order = 19,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP_DESC"] ,
							},
							actionBars = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS"],
								order = 20,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS_DESC"],
							},
							battlefieldMap = {
								type = "toggle",
								name = L["ACCWUI_OPT_MODULES_CHK_BTLMAP"],
								order = 21,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_BTLMAP_DESC"],
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
								name = L["ACCWUI_OPT_MODULES_CHK_EDITMODE"],
								order = 1,
								width = "full",
								desc = L["ACCWUI_OPT_MODULES_CHK_EDITMODE_DESC"],
							},
							editModeOnByDefault = {
								type = "toggle",
								name = L["ACCWUI_OPT_CHK_EDITMODE"],
								order = 2,
								width = "full",
								desc = L["ACCWUI_OPT_CHK_EDITMODE_DESC"],
							},
							header1 = {
								type = "header",
								name = string.format(L["ACCWUI_CHARSPECIFIC_TITLE"], UnitNameUnmodified("player")),
								order = 3,
							},
							desc1 = {
								type = "description",
								fontSize = "medium",
								order = 4,
								width = "full",
								name = L["ACCWUI_CHARSPECIFIC_DESC"]
							},
						}
					},
					
				}
				
			},
			blockChannelToggles = {
				type = "group",
				name = L["ACCWUI_BLOCKBLIZZ_TITLE"],
				desc = L["ACCWUI_BLOCKBLIZZ_DESC"],
				order = 4,
				args = {
					desc = {
						type = "description",
						fontSize = "medium",
						order = 1,
						width = "full",
						name = L["ACCWUI_BLOCKBLIZZ_TEXT_DESC"]
					},
					togglesGroup = {
						type = "group",
						name = L["ACCWUI_BLOCKBLIZZ_TITLE"],
						inline = true,
						order = 1,
						get = "GetBlockChannelToggle",
						set = "SetBlockChannelToggle",
						args = {
							general = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.general),
								width = "full",
								order = 2,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.general),
							},
							trade = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.trade),
								width = "full",
								order = 3,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.trade),
							},
							localDefense = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.localDefense),
								width = "full",
								order = 4,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.localDefense),
							},
							lookingForGroup = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.lookingForGroup),
								width = "full",
								order = 5,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.lookingForGroup),
							},
							services = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.services),
								width = "full",
								order = 6,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.services),
							},
							guildRecruitment = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.guildRecruitment),
								width = "full",
								order = 7,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.guildRecruitment),
							},
							worldDefense = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.worldDefense),
								width = "full",
								order = 8,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.worldDefense),
							},
							hardcoreDeaths = {
								type = "toggle",
								name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.hardcoreDeaths),
								width = "full",
								order = 9,
								desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.hardcoreDeaths),
							},
						}
					}
				}
			},
			optionsDebug = {
				type = "group",
				name = ADVANCED_OPTIONS,
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
						name = L["ACCWUI_DEBUG_DESC"],
					},
					enableTextOutput = {
						type = "toggle",
						name = L["ACCWUI_OPT_CHK_TOCHAT"],
						width = "full",
						order = 3,
						desc = L["ACCWUI_OPT_CHK_TOCHAT_DESC"],
					},
					printWhenLastSaved = {
						type = "toggle",
						name = L["ACCWUI_OPT_CHK_SHOWLASTSAVED"],
						width = "full",
						order = 4,
						desc = L["ACCWUI_OPT_CHK_SHOWLASTSAVED_DESC"],
					},
					printDebugTextToChat = {
						type = "toggle",
						name = L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT"],
						width = "full",
						order = 6,
						desc = L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT_DESC"],
					},
					btnForceLoad = {
						type = "execute",
						name = L["ACCWUI_DEBUG_BTN_FORCELOAD"],
						desc = L["ACCWUI_DEBUG_BTN_FORCELOAD_DESC"],
						order = 7,
						func = function() 
							self:CancelAllTimers(); 
							self:Print(L["ACCWUI_DEBUG_TXT_FORCELOAD"]);
							self:LoadUISettings();
						end,
					},
					btnForceSave = {
						type = "execute",
						name = L["ACCWUI_DEBUG_BTN_FORCESAVE"],
						desc = L["ACCWUI_DEBUG_BTN_FORCESAVE_DESC"],
						order = 8,
						func = function() 
							self:Print(L["ACCWUI_DEBUG_TXT_FORCESAVE"]);
							self:SaveUISettings(); 
							self:SaveBagFlagSettings(true); 
						end,
					},
					headerDiv1 = {
						type = "header",
						name = L["ACCWUI_ADDONNAME"],
						order = 21
					},
					desc1 = {
						type = "description",
						fontSize = "medium",
						order = 22,
						width = "full",
						name = string.format(L["ACCWUI_ABOUT"], C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "Version"), C_AddOns.GetAddOnMetadata("AccWideUILayoutSelection", "Author"))
					},
					desc2 = {
						type = "description",
						fontSize = "small",
						order = 23,
						width = "full",
						name = L["ACCWUI_ISSUES"]
					},
					
					
				}
			}
		}
	}
	
	
	-- Edit Mode Specs
	if (AccWideUIAceAddon:IsMainline()) then
	
		local NumOfSpecs = GetNumSpecializations(false, false)

		for ThisSpecX = 1, NumOfSpecs, 1 do
			
			local thisSpecName = PlayerUtil.GetSpecNameBySpecID(select(1, C_SpecializationInfo.GetSpecializationInfo(ThisSpecX)))
		
			optionsData.args.optionsSyncSettings.args.editModeSettings.args["spec" .. ThisSpecX] = {
				type = "toggle",
				name = thisSpecName,
				order = (5 + ThisSpecX),
				width = "full",
				get = "GetEditModeSpec",
				set = "SetEditModeSpec",
				desc = string.format(L["ACCWUI_CHARSPECIFIC_CHECK_DESC"], UnitNameUnmodified("player"), thisSpecName),
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
		optionsData.args.blockChannelToggles.args.togglesGroup.args.worldDefense = nil
		optionsData.args.blockChannelToggles.args.togglesGroup.args.HardcoreDeaths = nil
	end

	if (AccWideUIAceAddon:IsClassicWrath() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.togglesGroup.args.guildRecruitment = nil
	end

	if (AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.togglesGroup.args.hardcoreDeaths = nil
	end
	
	if (AccWideUIAceAddon:IsMainline() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		optionsData.args.blockChannelToggles.args.togglesGroup.args.services = nil
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
