local L = LibStub("AceLocale-3.0"):NewLocale("AccWideUIAceAddonLocale", "enUS", true, true)

L["ACCWUI_ADDONNAME"] = "Account Wide Interface Option Settings"
L["ACCWUI_ADDONNAME_SHORT"] = "Account Wide Interface"

L["ACCWUI_LOAD_REGULAR"] = "Account Wide Interface Option Settings Addon Loaded! Type %s to configure."
L["ACCWUI_LOAD_LASTUPDATED"] = "Settings were last saved by %s on %s. (%s)"

L["ACCWUI_OPT_TITLE_DESC"] = "Makes various Interface Options synchronise across all of your characters and specs."
L["ACCWUI_OPT_EDITMODE_TITLE"] = "Edit Mode Specific Settings"
L["ACCWUI_OPT_CHK_EDITMODE"] = "Enable Chosen Edit Mode by default for all New Characters"
L["ACCWUI_OPT_CHK_EDITMODE_DESC"] = "When checked, any new characters you create will automatically use your synchronised Edit Mode Layout. Otherwise, you will need to manually enable it for each spec below."
L["ACCWUI_OPT_BTN_EDITMODE"] = "Open Edit Mode"
L["ACCWUI_OPT_CHK_TOCHAT"] = "Output to chat when addon is loaded"
L["ACCWUI_OPT_CHK_TOCHAT_DESC"] = "Prints a short welcome message into chat when the addon has loaded after logging in."
L["ACCWUI_OPT_CHK_SCREENSIZE"] = "Save Screen Resolution Specific Settings"
L["ACCWUI_OPT_CHK_SCREENSIZE_DESC"] = "When checked, certain settings will only be saved and loaded for your Monitor's Full Screen Resolution (%s).\n\nThis can be useful if you often play with different monitors, or you sync your addon settings across multiple computers.\n\nSupports: Chosen Edit Mode Layout, Chat Window Size & Position, Zone Map Position"

L["ACCWUI_OPT_CHK_SHOWLASTSAVED"] = "Output to chat when settings were last saved"
L["ACCWUI_OPT_CHK_SHOWLASTSAVED_DESC"] = "Prints the last date, time and character that the current sync profile was saved when it is loaded."

L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS"] = "Output to chat when Auto Joining/Leaving Blizzard Chat Channels"
L["ACCWUI_OPT_CHK_SHOWBLIZZCHANNELS_DESC"] = "Prints into chat whenever the addon automatically makes your character join or leave a chat channel, based on the settings in the Blizzard Chat Channels section."

L["ACCWUI_OPT_SYNCSETTINGS_TITLE"] = "Sync Settings"
L["ACCWUI_OPT_SYNCSETTINGS_DESC"] = "Select which settings to sync across your account"
L["ACCWUI_OPT_MODULES_TITLE"] = "Sync Toggles"
L["ACCWUI_OPT_MODULES_DESC"] = "Which UI settings would you like to synchronise Account Wide?"
L["ACCWUI_OPT_MODULES_EXP_TITLE"] = "Experimental Sync Toggles"
L["ACCWUI_OPT_MODULES_EXP_DESC"] = "These sync settings are experimental, in that they may not always work, and can be dependent on your game settings and network status."

L["ACCWUI_OPT_MODULES_CHK_TARGETING"] = "Action Targeting Settings"
L["ACCWUI_OPT_MODULES_CHK_TARGETING_DESC"] = "When checked, your Action Targeting settings are synchronised."
L["ACCWUI_OPT_MODULES_CHK_ARENA"] = "Arena Frame Settings"
L["ACCWUI_OPT_MODULES_CHK_ARENA_DESC"] = "When checked, your Arena Frame settings are synchronised."
L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT"] = "Auto Loot Settings"
L["ACCWUI_OPT_MODULES_CHK_AUTOLOOT_DESC"] = "When checked, your Auto Loot settings are synchronised."
L["ACCWUI_OPT_MODULES_CHK_BAGS"] = "Bag Organisation Settings"
L["ACCWUI_OPT_MODULES_CHK_BAGS_DESC"] = "When checked, your bag assigments as well as the Ignore and Sell Junk settings are synchronised.\n\nThis can be unreliable if network conditions are not optimal, as each bag setting must be sent one at a time."
L["ACCWUI_OPT_MODULES_CHK_TRADEGUILD"] = "Block Guild/Trade/Channel Invite Settings"
L["ACCWUI_OPT_MODULES_CHK_TRADEGUILD_DESC"] = "When checked, the options to block or allow Guild, Trade or Chat Channel Invites are synchronised."
L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW"] = "Chat Window Settings"
L["ACCWUI_OPT_MODULES_CHK_CHATWINDOW_DESC"] = "When checked, many aspects of your chat windows including tabs, colors, and types of visible messages are synchronised."
L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION"] = "Chat Position/Size Settings"
L["ACCWUI_OPT_MODULES_CHK_CHATPOSITION_DESC"] = "When checked, the location and size of your chat windows are synchronised."
L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS"] = "Custom Chat Channels"
L["ACCWUI_OPT_MODULES_CHK_CHATCHANNELS_DESC"] = "When checked, any custom chat channels you have joined will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_COOLDOWN"] = "Cooldown Manager Settings"
L["ACCWUI_OPT_MODULES_CHK_COOLDOWN_DESC"] = "When checked, your cooldown manager settings will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_EDITMODE"] = "Chosen Edit Mode Layout"
L["ACCWUI_OPT_MODULES_CHK_EDITMODE_DESC"] = "When checked, your currently active Edit Mode Layout will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_EMPOWERED"] = "Empowered Spell Input Setting"
L["ACCWUI_OPT_MODULES_CHK_EMPOWERED_DESC"] = "When checked, the Empowered Spell Input Setting will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_LOC"] = "Loss of Control Settings"
L["ACCWUI_OPT_MODULES_CHK_LOC_DESC"] = "When checked, the settings for the Loss of Control Alerts will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER"] = "Mouseover/Self Cast Settings"
L["ACCWUI_OPT_MODULES_CHK_MOUSEOVER_DESC"] = "When checked, the Mouseover Cast and Self Cast settings will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES"] = "Nameplate Settings"
L["ACCWUI_OPT_MODULES_CHK_NAMEPLATES_DESC"] = "When checked, your Nameplate settings will be synchronised. \n\nIf using Plater, having this enabled may interfere with your Plater Profiles."
L["ACCWUI_OPT_MODULES_CHK_PARTYRAID"] = "Party/Raid Frame Settings"
L["ACCWUI_OPT_MODULES_CHK_PARTYRAID_DESC"] = "When checked, your Party and Raid Frame settings will be synchronised. \n\nOn Classic Clients, this will also synchronise your Raid Frame Profiles."
L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY"] = "Spell Overlay Settings"
L["ACCWUI_OPT_MODULES_CHK_SPELLOVERLAY_DESC"] = "When checked, the Spell Alert Overlay toggle and opacity will be synchronised."
L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP"] = "Viewed Tutorial Tooltips"
L["ACCWUI_OPT_MODULES_CHK_TUTTOOLTIP_DESC"] = "When checked, synchronises which tutorials and info frames you have already seen."
L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS"] = "Visible Action Bars"
L["ACCWUI_OPT_MODULES_CHK_ACTIONBARS_DESC"] = "When checked, synchronises which Action Bars are currently visible.\n\nIt does not synchronise what spells and abilities you have added to the bars."
L["ACCWUI_OPT_MODULES_CHK_BTLMAP"] = "Zone Map Settings"
L["ACCWUI_OPT_MODULES_CHK_BTLMAP_DESC"] = "When checked, the visibility, location and other options for the Zone Map (Default: SHIFT+M) are synchronised."

L["ACCWUI_OPT_MODULES_CVARS"] = "Custom CVar List"
L["ACCWUI_OPT_MODULES_CVARS_DESC"] = "Enter a custom list of CVars you'd like to synchonise with this profile.\n\nEnter an exact CVar Name, one per line."

L["ACCWUI_BLOCKBLIZZ_TITLE"] = "Blizzard Chat Channels"
L["ACCWUI_BLOCKBLIZZ_DESC"] = "Allow or prevent all characters using this profile from joining various default chat channels"
L["ACCWUI_BLOCKBLIZZ_TEXT_DESC"] = "Select which Blizzard Chat Channels below your characters should always join, or block from ever seeing again.\n\nJoin: Your characters will always try to join this channel.\nBlock: Your characters will always leave this channel.\nDo Nothing: Your characters will not be forced to join or leave this channel."
L["ACCWUI_BLOCKBLIZZ_CHANNEL"] = "%s " .. CHANNEL
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DESC"] = "Select what you'd like to do with the %s channel."
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW"] = "Join"
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK"] = "Block"
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT"] = "Do Nothing"
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_ALLOW_DESC"] = "Checking this box will force all of your characters to join the %s Channel."
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_BLOCK_DESC"] = "Checking this box will force all of your characters to leave the %s Channel."
L["ACCWUI_BLOCKBLIZZ_CHECKBOX_DEFAULT_DESC"] = "Checking this box will make the addon do nothing in regards to the %s Channel."

L["ACCWUI_CHARSPECIFIC_TITLE"] = "%s Specific Options"
L["ACCWUI_CHARSPECIFIC_DESC"] = "Select whether to use the chosen Edit Mode layout for this character's Specializations."

L["ACCWUI_CHARSPECIFIC_CHECK_DESC"] = "Enable the synchronised Edit Mode Layout for %s when switching to your %s Specialization."

L["ACCWUI_ADCOM_CURRENT"] = "Current Profile"
L["ACCWUI_ADCOM_CHANGE"] = "Click to change settings."

L["ACCWUI_FIRSTTIME_LINE1"] = "Welcome! This appears to be the first time you have used this addon."
L["ACCWUI_FIRSTTIME_LINE2"] = "Would you like to synchronise the current character's Interface settings as the base settings for this addon?"

L["ACCWUI_FIRSTTIME_BTN1"] = "Use %s's Current Settings"
L["ACCWUI_FIRSTTIME_BTN2"] = "Ask Again Later"

L["ACCWUI_FIRSTTIME_ACCEPTED_LINE1"] = "Your settings have now been saved. They will synchronise across all of your characters, including any changes you may make."
L["ACCWUI_FIRSTTIME_ACCEPTED_LINE2"] = "Type %s at any time to change your settings."

L["ACCWUI_FIRSTTIME_DECLINED_LINE1"] = "You will be asked again the next time you switch character, or perform a UI /reload."

L["ACCWUI_ADVANCED_DESC"] = "Settings on this page will apply to all profiles on your account."

L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR"] = "Allow Synchronising Custom CVars"
L["ACCWUI_ADVANCED_ALLOW_CUSTOMCVAR_DESC"] = "When checked, a new textbox will be available in the Sync Settings, where you can enter a custom list of additional CVars to synchronise."
L["ACCWUI_ADVANCED_ALLOW_EXP"] = "Allow Experimental Sync Settings"
L["ACCWUI_ADVANCED_ALLOW_EXP_DESC"] = "When checked, a list of experimental sync settings will be available to use. \n\nThese sync settings may not always work depending on client and network conditions."
L["ACCWUI_ADVANCED_DISABLE_AUTO"] = "Disable Auto Saving / Loading Settings"
L["ACCWUI_ADVANCED_DISABLE_AUTO_DESC"] = "Normally, the addon will automatically save and load your settings when logging in, changing profile, and logging out.\n\nWhen checked, you will need to manually save and load your settings using the buttons below."

L["ACCWUI_DEBUG_TITLE"] = BINDING_HEADER_DEBUG

L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT"] = "Output Save/Load Debug Text"
L["ACCWUI_DEBUG_CHK_SHOWDEBUGPRINT_DESC"] = "Prints a LOT of debug text into chat when the addon loads or saves settings."

L["ACCWUI_DEBUG_BTN_FORCELOAD"] = "Force Load"
L["ACCWUI_DEBUG_BTN_FORCELOAD_DESC"] = "Immediately loads the settings of the currently selected profile, overwriting any settings that you may have changed since last time the profile was saved.\n\nNormally, settings are loaded immediately after logging in, or after switching profile."
L["ACCWUI_DEBUG_TXT_FORCELOAD"] = "Force-Loading Settings."
L["ACCWUI_DEBUG_BTN_FORCESAVE"] = "Force Save"
L["ACCWUI_DEBUG_BTN_FORCESAVE_DESC"] = "Immediately saves all settings to the currently selected profile.\n\nNormally, settings are saved just before logging out, or switching profile."
L["ACCWUI_DEBUG_TXT_FORCESAVE"] = "Force-Saving Settings."

L["ACCWUI_UTILITY_TITLE"] = "Utilities"
L["ACCWUI_UTILITY_BTN_ZONEMAPPOS"] = "Reset Zone Map Position"
L["ACCWUI_UTILITY_TXT_ZONEMAPPOS"] = "Moves the Zone Map to the middle of the screen. Useful if it has moved off-screen and you cannot find it."

L["ACCWUI_JOINING_CHANNEL"] = "Automatically joining the %s Channel. Type %s to configure."
L["ACCWUI_LEAVING_CHANNEL"] = "Automatically leaving the %s Channel. Type %s to configure."

L["ACCWUI_ABOUT"] = "%s by %s - Dedicated to Petrel <3"
L["ACCWUI_ISSUES"] = "Issues? Please visit https://github.com/NinerBull/AccWideUILayoutSelection/issues"