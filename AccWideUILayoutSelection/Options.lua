local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

function AccWideUIAceAddon:GenerateDefaultDB()

	local defaults = {
		global = {
			disableAutoSaveLoad = false,
			disableAutoSave = false,
			hasDoneFirstTimeSetup = false,
			printDebugTextToChat = false,
			printWhenLastSaved = false,
			printWelcomeMessage = false,
			printBlizzChatChanges = false,
			useScreenSizeSpecificSettings = false,
			allowCustomCVars = false,
			allowExperimentalSyncs = false,
			minimapButton = {
				hide = true
			}
		},
		profile = {
			profileSaveVer = self.TempData.ProfileSaveVer,
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
				blockChannelInvites = true,
				blockGuildInvites = true,
				blockTrades = true,
				blockNeighborhoodInvites = true,
				locationVisibility = true,
				autoLoot = true,
				softTarget = true,
				tutorialTooltips = true,
				battlefieldMap = true,
				mouseoverCast = true,
				selfCast = true,
				empowerTap = true,
				cooldownViewer = true,
				assistedCombat = true,
				lossOfControl = true,
				bagOrganisation = false,
				arenaFrames = true,
				spellOverlay = true,
				damageMeter = true,
				externalDefensives = true,
				worldMap = true,
				calendarFilters = true,
				camera = true,
				combatMisc = true,
				uiMisc = true,
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
					cvars = {},
					special = {
					}
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
				blockChannelInvites = {
					cvars = {},
				},
				blockTrades = {
					cvars = {}
				},
				blockGuildInvites = {
					special = {
						blockGuildInvites = nil
					}
				},
				blockNeighborhoodInvites = {
					special = {
						blockNeighborhoodInvites = nil
					}
				},
				locationVisibility = {
					special = {
						allowRecentAlliesSeeLocation = nil
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
					options = {},
					cvars = {}
				},
				mouseoverCast = {
					cvars = {}
				},
				selfCast = {
					cvars = {}
				},
				lossOfControl = {
					cvars = {}
				},
				cooldownViewer = {
					cvars = {}
				},
				assistedCombat = {
					cvars = {}
				},
				damageMeter = {
					cvars = {},
					special = {
						settings = {},
						position = {},
						size = {}
					}
				},
				externalDefensives = {
					cvars = {}
				},
				worldMap = {
					cvars = {}
				},
				calendarFilters = {
					cvars = {}
				},
				camera = {
					cvars = {}
				},
				combatMisc = {
					cvars = {}
				},
				uiMisc = {
					cvars = {}
				},
				chat = {
					windows = {
						['**'] = {}
					},
					channelsJoined = {},
					info = {}
				},
				bagOrganisation = {
					bags = {},
					settings = {
						sortBagsRightToLeft = false,
						insertItemsLeftToRight = false,
						backpackAutosortDisabled = false,
						backpackSellJunkDisabled = false,
						bankAutosortDisabled = false,
					}
				},
				screenResolutionSpecific = {
					['**'] = {
						editModeLayoutID = "unset",
						chat = {
							windows = {
								['**'] = {}
							}
						},
						battlefieldMap = {
							options = {}
						}
					},
				},
				customCVars = {
					cvarList = "",
					cvarData = {},
				}

			},
			blizzChannels = {
				['**'] = "default"
			}
		},
		char = {
			useEditModeLayout = {
				hasBeenPrepared = false,
				specialization1 = true,
				specialization2 = true,
				specialization3 = true,
				specialization4 = true,
				specialization5 = true
			}
		}
	}

	return defaults

end



function AccWideUIAceAddon:GenerateOptions()

	local thisCheckboxWidth = 1.6
	local thisCheckboxWidth2 = 1.65

	AccWideUIAceAddon.optionsData = {
		type = "group",
		name = L["ACCWUI_ADDONNAME"],
		handler = AccWideUIAceAddon,
		childGroups = "tab",
		args = {
			desc = {
				type = "description",
				fontSize = "small",
				order = 1,
				width = "full",
				name = L["ACCWUI_OPT_TITLE_DESC"]
			},
			settings = {
				type = "group",
				name = L["ACCWUI_OPT_SYNCSETTINGS_TITLE"],
				desc = L["ACCWUI_OPT_SYNCSETTINGS_DESC"],
				order = 2,
				args = {
					syncToggles = {
						type = "group",
						name = L["ACCWUI_OPT_MODULES_TITLE"],
						order = 2,
						inline = true,
						args = {
							desc = {
								type = "description",
								fontSize = "medium",
								order = 10,
								width = "full",
								name = L["ACCWUI_OPT_MODULES_DESC"]
							},
							groupCombat = {
								type = "group",
								name = L["ACCWUI_OPT_GROUP_COMBAT"],
								order = 11,
								inline = true,
								get = "GetSyncToggle",
								set = "SetSyncToggle",
								width = "full",
								args = {
									softTarget = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_TARGETING"],
										order = 20,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_TARGETING_DESC"],
									},
									assistedCombat = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_ASSISTED"],
										order = 30,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_ASSISTED_DESC"],
									},
									autoLoot = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT"],
										order = 50,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT_DESC"],
									},
									empowerTap = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_EMPOWERED"],
										order = 120,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_EMPOWERED_DESC"],
									},
									lossOfControl = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_LOC"],
										order = 140,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_LOC_DESC"],
									},
									mouseoverCast = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER"],
										order = 150,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER_DESC"],
									},
									selfCast = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_SELFCAST"],
										order = 151,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_SELFCAST_DESC"],
									},
									combatMisc = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_COMBATMISC"],
										order = 1000,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_COMBATMISC_DESC"],
									},
								}
							},
							groupUnits = {
								type = "group",
								name = L["ACCWUI_OPT_GROUP_UNITS"],
								order = 12,
								inline = true,
								get = "GetSyncToggle",
								set = "SetSyncToggle",
								width = "full",
								args = {
									arenaFrames = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_ARENA"],
										order = 40,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_ARENA_DESC"],
									},
									nameplates = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES"],
										order = 160,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES_DESC"],
									},
									raidFrames = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_PARTYRAID"],
										order = 170,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_PARTYRAID_DESC"],
									},

								}
							},
							groupSocial = {
								type = "group",
								name = L["ACCWUI_OPT_GROUP_SOCIAL"],
								order = 14,
								inline = true,
								get = "GetSyncToggle",
								set = "SetSyncToggle",
								width = "full",
								args = {
									blockChannelInvites = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BLOCKCHANNEL"],
										order = 60,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BLOCKCHANNEL_DESC"],
									},
									blockGuildInvites = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BLOCKGUILD"],
										order = 61,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BLOCKGUILD_DESC"],
									},
									blockNeighborhoodInvites = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BLOCKNEIGHBORHOOD"],
										order = 62,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BLOCKNEIGHBORHOOD_DESC"],
									},
									blockTrades = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BLOCKTRADE"],
										order = 62,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BLOCKTRADE_DESC"],
									},
									chatWindow = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW"],
										order = 70,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW_DESC"],
									},
									chatWindowPosition = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION"],
										order = 80,
										width = thisCheckboxWidth,
										disabled = "ShouldChatOptsDisable",
										desc = L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION_DESC"],
									},
									chatChannels = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS"],
										order = 90,
										width = thisCheckboxWidth,
										disabled = "ShouldChatOptsDisable",
										desc = L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS_DESC"],
									},
									locationVisibility = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_LOCATIONVIS"],
										order = 130,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_LOCATIONVIS_DESC"],
									},
								}
							},
							groupInterface = {
								type = "group",
								name = L["ACCWUI_OPT_GROUP_INTERFACE"],
								order = 13,
								inline = true,
								get = "GetSyncToggle",
								set = "SetSyncToggle",
								width = "full",
								args = {
									calendarFilters = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_CALENDAR"],
										order = 65,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_CALENDAR_DESC"],
									},
									camera = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_CAMERA"],
										order = 68,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_CAMERA_DESC"],
									},
									cooldownViewer = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_COOLDOWN"],
										order = 100,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_COOLDOWN_DESC"],
									},
									damageMeter = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_DMGMETER"],
										order = 101,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_DMGMETER_DESC"],
									},
									editModeLayout = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_EDITMODE"],
										order = 110,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_EDITMODE_DESC"],
									},
									externalDefensives = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_EXTERNALDEF"],
										order = 120,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_EXTERNALDEF_DESC"],
									},
									spellOverlay = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY"],
										order = 180,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY_DESC"],
									},
									tutorialTooltips = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP"],
										order = 190,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP_DESC"] ,
									},
									actionBars = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS"],
										order = 200,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS_DESC"],
									},
									worldMap = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_WORLDMAP"],
										order = 205,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_WORLDMAP_DESC"],
									},
									battlefieldMap = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BTLMAP"],
										order = 210,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BTLMAP_DESC"],
									},
									uiMisc = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_UIMISC"],
										order = 1100,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_UIMISC_DESC"],
									},
								}
							},
							experimentalSyncToggles = {
								type = "group",
								name = L["ACCWUI_OPT_MODULES_EXP_TITLE"],
								order = 6002,
								inline = true,
								hidden = "ShouldExperimentalSyncsListBeHidden",
								get = "GetSyncToggle",
								set = "SetSyncToggle",
								args = {
									desc = {
										type = "description",
										fontSize = "medium",
										order = 1,
										width = "full",
										name = L["ACCWUI_OPT_MODULES_EXP_DESC"]
									},
									bagOrganisation = {
										type = "toggle",
										name = L["ACCWUI_OPT_MODULES_CHK_BAGS"],
										order = 6,
										width = thisCheckboxWidth,
										desc = L["ACCWUI_OPT_MODULES_CHK_BAGS_DESC"],
									},
								}
							},
						},
					},
					headerDiv2 = {
						type = "header",
						name = "",
						order = 5
					},
					editModeSettings = {
						type = "group",
						name = "Edit Mode Specific Settings",
						order = 6,
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
					headerDiv3 = {
						type = "header",
						name = "",
						order = 7,
						hidden = "ShouldCustomCVarListBeHidden"
					},
					cvarList = {
						type = "input",
						order = 8,
						width = "full",
						multiline = 6,
						hidden = "ShouldCustomCVarListBeHidden",
						get = "GetCustomCVarList",
						set = "SetCustomCVarList",
						name = L["ACCWUI_OPT_MODULES_CVARS"],
						desc = L["ACCWUI_OPT_MODULES_CVARS_DESC"]
					},

				}

			},
			channels = {
				type = "group",
				name = L["ACCWUI_BLOCKBLIZZ_TITLE"],
				desc = L["ACCWUI_BLOCKBLIZZ_DESC"],
				order = 4,
				get = "GetBlizzChannelToggle",
				set = "SetBlizzChannelToggle",
				args = {
					desc = {
						type = "description",
						fontSize = "medium",
						order = 1,
						width = "full",
						name = L["ACCWUI_BLOCKBLIZZ_TEXT_DESC"]
					},
					general = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.general or "General"),
						width = 1,
						order = 2,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.general or "General"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					trade = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.trade or "Trade"),
						width = 1,
						order = 3,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.trade or "Trade"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					localDefense = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.localDefense or "LocalDefense"),
						width = 1,
						order = 4,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.localDefense or "LocalDefense"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					lookingForGroup = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.lookingForGroup or "LookingForGroup"),
						width = 1,
						order = 5,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.lookingForGroup or "LookingForGroup"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					services = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.services or "Services"),
						width = 1,
						order = 6,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.services or "Services"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					guildRecruitment = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.guildRecruitment or "GuildRecruitment"),
						width = 1,
						order = 7,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.guildRecruitment or "GuildRecruitment"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					worldDefense = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.worldDefense or "WorldDefense"),
						width = 1,
						order = 8,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.worldDefense or "WorldDefense"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
					hardcoreDeaths = {
						type = "select",
						name = string.format(L["ACCWUI_BLOCKBLIZZ_CHANNEL"], self.chatChannelNames.hardcoreDeaths or "HardcoreDeaths"),
						width = 1,
						order = 9,
						desc = string.format(L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"], self.chatChannelNames.hardcoreDeaths or "HardcoreDeaths"),
						style = "radio",
						values = {
							join = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"],
							block = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"],
							default = L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"]
						},
						sorting = {"join", "block", "default"}
					},
				}
			},
			advanced = {
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
						name = L["ACCWUI_ADVANCED_DESC"],
					},
					advanced = {
						type = "group",
						name = ADVANCED_OPTIONS,
						inline = true,
						order = 2,
						args = {
							useScreenSizeSpecificSettings = {
								type = "toggle",
								name = L["ACCWUI_OPT_CHK_SCREENSIZE"],
								width = thisCheckboxWidth2,
								order = 1,
								desc = string.format(L["ACCWUI_OPT_CHK_SCREENSIZE_DESC"], AccWideUIAceAddon.TempData.ScreenRes),
							},
							allowCustomCVars = {
								type = "toggle",
								name = L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR"],
								width = thisCheckboxWidth2,
								order = 2,
								desc = L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR_DESC"],
							},
							allowExperimentalSyncs = {
								type = "toggle",
								name = L["ACCWUI_ADVANCED_ALLOW_EXP"],
								width = thisCheckboxWidth2,
								order = 3,
								desc = L["ACCWUI_ADVANCED_ALLOW_EXP_DESC"],
							},
							hideMinimapButton = {
								type = "toggle",
								name = L["ACCWUI_ADVANCED_DISABLE_MINIMAPBTN"],
								desc = L["ACCWUI_ADVANCED_DISABLE_MINIMAPBTN_DESC"],
								width = thisCheckboxWidth2,
								order = 4,
								get = function(info)
									return self.db.global.minimapButton.hide
								end,
								set = function(info, value)
									self.db.global.minimapButton.hide = value
									if (value == true) then
										AccWideUIAceAddon.LDBIcon:Hide("AWI")
									else
										AccWideUIAceAddon.LDBIcon:Show("AWI")
									end
									
								end,
							},
							headerDiv1 = {
								type = "header",
								name = "",
								order = 5,
								width = "full",
							},
							disableAutoSaveLoad = {
								type = "toggle",
								name = L["ACCWUI_ADVANCED_DISABLE_AUTO"],
								width = thisCheckboxWidth2,
								order = 6,
								desc = L["ACCWUI_ADVANCED_DISABLE_AUTO_DESC"],
								set = function(info, value)
									self.db.global[info[#info]] = value
									if (value == true) then
										self.db.global.disableAutoSave = false
									end
								end,
							},
							disableAutoSave = {
								type = "toggle",
								name = L["ACCWUI_ADVANCED_DISABLE_AUTOSAVE"],
								width = thisCheckboxWidth2,
								order = 7,
								desc = L["ACCWUI_ADVANCED_DISABLE_AUTOSAVE_DESC"],
								set = function(info, value)
									self.db.global[info[#info]] = value
									if (value == true) then
										self.db.global.disableAutoSaveLoad = false
									end
								end,
							},
							btnForceLoad = {
								type = "execute",
								name = L["ACCWUI_DEBUG_BTN_FORCELOAD"],
								desc = L["ACCWUI_DEBUG_BTN_FORCELOAD_DESC"],
								width = thisCheckboxWidth2,
								order = 8,
								func = function()
									self:ForceLoadSettings()
								end,
							},
							btnForceSave = {
								type = "execute",
								name = L["ACCWUI_DEBUG_BTN_FORCESAVE"],
								desc = L["ACCWUI_DEBUG_BTN_FORCESAVE_DESC"],
								width = thisCheckboxWidth2,
								order = 9,
								func = function()
									self:ForceSaveSettings()
								end,
							},
						}
					},
					profileImportExport = {
						type = "group",
						name = L["ACCWUI_IE_IMPORTEXPORT"],
						inline = true,
						order = 3,
						args = {
							btnImportProfile = {
								type = "execute",
								name = L["ACCWUI_IE_IMPORTSTRING"],
								desc = L["ACCWUI_IE_IMPORTSTRING_DESC"],
								width = thisCheckboxWidth2,
								order = 1,
								func = function()
									self:ImportProfile()
								end,
							},
							btnExportProfile = {
								type = "execute",
								name = L["ACCWUI_IE_EXPORTSTRING"],
								desc = L["ACCWUI_IE_EXPORTSTRING_DESC"],
								width = thisCheckboxWidth2,
								order = 2,
								func = function()
									self:ExportProfile()
								end,
							},
						}
					},
					debug = {
						type = "group",
						name = L["ACCWUI_DEBUG_TITLE"],
						inline = true,
						order = 20,
						args = {
							printWelcomeMessage = {
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
							printBlizzChatChanges = {
								type = "toggle",
								name = L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS"],
								width = "full",
								order = 5,
								desc = L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS_DESC"],
							},
							printDebugTextToChat = {
								type = "toggle",
								name = L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT"],
								width = "full",
								order = 6,
								desc = L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT_DESC"],
							},

						}
					},
					utility = {
						type = "group",
						name = L["ACCWUI_UTILITY_TITLE"],
						inline = true,
						order = 5,
						args = {
							btnResetZoneMapPos = {
								type = "execute",
								name = L["ACCWUI_UTILITY_BTN_ZONEMAPPOS"],
								desc = L["ACCWUI_UTILITY_TXT_ZONEMAPPOS"],
								width = thisCheckboxWidth2,
								order = 1,
								func = function()
									BattlefieldMapTab:ClearAllPoints()
									BattlefieldMapTab:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
									--BattlefieldMapTab:Show()
									BattlefieldMapFrame:RefreshAlpha()
									BattlefieldMapFrame:UpdateUnitsVisibility()
								end,
							},
							btnResetDamageMeter = {
								type = "execute",
								name = L["ACCWUI_UTILITY_BTN_RESETDMGMETER"],
								desc = L["ACCWUI_UTILITY_TXT_RESETDMGMETER"],
								width = thisCheckboxWidth2,
								order = 2,
								func = function()
									C_CVar.SetCVar("damageMeterEnabled", 0)
									self:ForceSaveSettings()
									DamageMeterPerCharacterSettings = nil
									self.db.profile.syncData.damageMeter.special = {}
									C_UI.Reload()
								end,
							},
						}
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
	if (AccWideUIAceAddon:IsMainline() == true) then

		local NumOfSpecs = GetNumSpecializations(false, false)

		for ThisSpecX = 1, NumOfSpecs, 1 do

			local thisSpecName = PlayerUtil.GetSpecNameBySpecID(select(1, C_SpecializationInfo.GetSpecializationInfo(ThisSpecX)))

			self.optionsData.args.settings.args.editModeSettings.args["specialization" .. ThisSpecX] = {
				type = "toggle",
				name = thisSpecName,
				order = (5 + ThisSpecX),
				--width = "full",
				get = "GetEditModeSpec",
				set = "SetEditModeSpec",
				desc = string.format(L["ACCWUI_CHARSPECIFIC_CHECK_DESC"], UnitNameUnmodified("player"), thisSpecName),
			}
		end

	else
		self.optionsData.args.settings.args.editModeSettings = nil
	end





	-- Remove Sync options that are not applicable to various versions	
	if (AccWideUIAceAddon:IsMainline() == false) then
		self.optionsData.args.settings.args.syncToggles.args.groupInterface.args.damageMeter = nil
		self.optionsData.args.settings.args.syncToggles.args.groupInterface.args.externalDefensives = nil
		self.optionsData.args.settings.args.editModeSettings = nil
		self.optionsData.args.settings.args.headerDiv2 = nil
		self.optionsData.args.settings.args.syncToggles.args.groupInterface.args.cooldownViewer = nil
		self.optionsData.args.settings.args.syncToggles.args.groupCombat.args.mouseoverCast = nil
		self.optionsData.args.settings.args.syncToggles.args.groupCombat.args.empowerTap = nil
		self.optionsData.args.settings.args.syncToggles.args.groupCombat.args.assistedCombat = nil
		self.optionsData.args.settings.args.syncToggles.args.groupSocial.args.locationVisibility = nil
		self.optionsData.args.settings.args.syncToggles.args.groupSocial.args.blockNeighborhoodInvites = nil
		self.optionsData.args.advanced.args.utility.args.btnResetDamageMeter = nil

		self.optionsData.args.settings.args.syncToggles.args.experimentalSyncToggles.args.bagOrganisation = nil
		self.optionsData.args.advanced.args.advanced.args.allowExperimentalSyncs = nil
	end

	if (AccWideUIAceAddon:IsMainline() == false and AccWideUIAceAddon:IsClassicTBC() == false) then
		self.optionsData.args.settings.args.syncToggles.args.groupCombat.args.lossOfControl = nil
		self.optionsData.args.settings.args.syncToggles.args.groupInterface.args.editModeLayout = nil
	end
	
	if (AccWideUIAceAddon:IsClassicEra() == true) then
		self.optionsData.args.settings.args.syncToggles.args.groupUnits.args.arenaFrames = nil
		self.optionsData.args.settings.args.syncToggles.args.groupInterface.args.spellOverlay = nil
	end


	-- Remove Chat options that are not applicable to various versions
	if (AccWideUIAceAddon:IsMainline()) then
		self.optionsData.args.channels.args.worldDefense = nil
		self.optionsData.args.channels.args.HardcoreDeaths = nil
	end

	if (AccWideUIAceAddon:IsClassicWrath() == false and AccWideUIAceAddon:IsClassicTBC() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		self.optionsData.args.channels.args.guildRecruitment = nil
	end

	if (AccWideUIAceAddon:IsClassicEra() == false) then
		self.optionsData.args.channels.args.hardcoreDeaths = nil
	end

	if (AccWideUIAceAddon:IsMainline() == false and AccWideUIAceAddon:IsClassicTBC() == false and AccWideUIAceAddon:IsClassicEra() == false) then
		self.optionsData.args.channels.args.services = nil
	end


	-- Hide Block Chat Channels if BlockBlizzChatChannels is installed
	if (C_AddOns.IsAddOnLoaded("BlockBlizzChatChannels") == true) then
		self.optionsData.args.channels = nil
		self.optionsData.args.advanced.args.debug.args.printBlizzChatChanges = nil
	end




end




-- for documentation on the info table
-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables#title-4-1
function AccWideUIAceAddon:GetSyncToggle(info)
	return self.db.profile.syncToggles[info[#info]]
end

function AccWideUIAceAddon:SetSyncToggle(info, value)
	self.db.profile.syncToggles[info[#info]] = value
end

function AccWideUIAceAddon:GetBlizzChannelToggle(info)
	return self.db.profile.blizzChannels[info[#info]]
end

function AccWideUIAceAddon:SetBlizzChannelToggle(info, value)
	self.db.profile.blizzChannels[info[#info]] = value
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

function AccWideUIAceAddon:GetCustomCVarList(info)
	return self.db.profile.syncData.customCVars[info[#info]]
end

function AccWideUIAceAddon:SetCustomCVarList(info, value)
	value = value:gsub("%s+", "\n")
	value = value:gsub(",", "\n")
	value = value:gsub("\n\n\n", "\n")
	value = value:gsub("\n\n", "\n")
	value = value:gsub("[^%w\n]+", "");
	self.db.profile.syncData.customCVars[info[#info]] = value
end

function AccWideUIAceAddon:ShouldChatOptsDisable()
	if (self.db.profile.syncToggles.chatWindow == true) then
		return false
	else
		return true
	end
end

function AccWideUIAceAddon:ShouldCustomCVarListBeHidden()
	return not self.db.global.allowCustomCVars
end

function AccWideUIAceAddon:ShouldExperimentalSyncsListBeHidden()
	return not self.db.global.allowExperimentalSyncs
end
