local L = LibStub("AceLocale-3.0"):GetLocale("AccWideUIAceAddonLocale")

AccWideUIAceAddon.chatChannelNames = {
	general = "General",
	trade = "Trade",
	services = "Services",
	localDefense = "LocalDefense",
	worldDefense = "WorldDefense",
	lookingForGroup = "LookingForGroup",
	HardcoreDeaths = "HardcoreDeaths",
	guildRecruitment = "GuildRecruitment"
}

if (AccWideUIAceAddon:IsMainline()) then

	AccWideUIAceAddon.chatChannelNames.general = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUIAceAddon.chatChannelNames.trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUIAceAddon.chatChannelNames.services = C_ChatInfo.GetChannelShortcutForChannelID(42)
	AccWideUIAceAddon.chatChannelNames.localDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUIAceAddon.chatChannelNames.lookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (AccWideUIAceAddon:IsClassicProgression()) then

	AccWideUIAceAddon.chatChannelNames.general = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUIAceAddon.chatChannelNames.trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUIAceAddon.chatChannelNames.localDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUIAceAddon.chatChannelNames.worldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUIAceAddon.chatChannelNames.lookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (AccWideUIAceAddon:IsClassicWrath()) then --China Wrath

	AccWideUIAceAddon.chatChannelNames.general = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUIAceAddon.chatChannelNames.trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUIAceAddon.chatChannelNames.localDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUIAceAddon.chatChannelNames.worldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUIAceAddon.chatChannelNames.guildRecruitment = C_ChatInfo.GetChannelShortcutForChannelID(25)
	AccWideUIAceAddon.chatChannelNames.lookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(26)

elseif (AccWideUIAceAddon:IsClassicEra()) then

	AccWideUIAceAddon.chatChannelNames.general = C_ChatInfo.GetChannelShortcutForChannelID(1)
	AccWideUIAceAddon.chatChannelNames.trade = C_ChatInfo.GetChannelShortcutForChannelID(2)
	AccWideUIAceAddon.chatChannelNames.services = C_ChatInfo.GetChannelShortcutForChannelID(45)
	AccWideUIAceAddon.chatChannelNames.localDefense = C_ChatInfo.GetChannelShortcutForChannelID(22)
	AccWideUIAceAddon.chatChannelNames.worldDefense = C_ChatInfo.GetChannelShortcutForChannelID(23)
	AccWideUIAceAddon.chatChannelNames.lookingForGroup = C_ChatInfo.GetChannelShortcutForChannelID(24)
	AccWideUIAceAddon.chatChannelNames.hardcoreDeaths = C_ChatInfo.GetChannelShortcutForChannelID(44)
	AccWideUIAceAddon.chatChannelNames.guildRecruitment = C_ChatInfo.GetChannelShortcutForChannelID(25)

end