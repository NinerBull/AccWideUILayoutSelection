# Account Wide Interface Settings

An addon for World of Warcraft!

![Info Img](https://cdn.wago.io/gallery/qwgAzgKbGKKBYgipPOBzJrsKv5d2mJKUqxLYZKx7.jpg)

## About
This QOL addon synchronizes various Blizzard Interface Settings that are **normally character specific** and applies them to **all** of your characters on your account automatically, including brand new characters.

The addon can synchronise the following, and you can disable any that you'd rather keep character specific:

* Combat
	* Action Targeting Settings
	* Assisted Highlight Setting
	* Auto Loot Settings
	* Empowered Spell Input Setting
	* Loss of Control Settings
	* Mouseover Cast Setting
	* Self Cast Setting
	* Misc. Combat Settings
* Unit Frames & Nameplates
	* Arena Frame Settings
	* Nameplate Settings
	* Party/Raid Frame Settings
* HUD & Interface
	* Calendar Filter Settings
	* Camera Settings
	* Cooldown Manager Visibility Setting
	* Chosen Edit Mode Layout
	* Damage Meter Settings
	* External Defensives Visibility Setting
	* Minimap Settings
	* Spell Overlay Settings
	* Viewed Tutorial Tooltips
	* Visible Action Bars
    * World Map Settings
	* Zone Map (Shift-M) Settings
	* Misc. UI Settings
* Social
	* Block Channel Invite Setting
	* Block Guild Invite Setting
	* Block Neighborhood Invite Setting
	* Block Trade Request Setting
	* Chat Window Settings
	* Chat Position/Size Settings
	* Custom Chat Channels
	* Location Visibility Setting
* Experimental (Togglable in Advanced Options)
	* Bag Organisation Settings


### Additional Functionality
* Profile Support - Save and switch between multiple Interface configurations
* Profile Import/Export - Share your profile as a text string with others online, or import a profile string that has been shared with you
* Force Leave/Join Blizzard Chat Channels - Never see Services spam on any character again, or perhaps always make them join Trade Chat?
* Screen Resolution Specific Settings - Useful for users who sync addon settings across multiple PCs, enable in Advanced Settings
* Custom CVar Support - Enter your own additional list of CVars to synchronise across characters, enable in Advanced Settings

## Compatibility
* **Midnight** - 12.0.1
* **MoP Classic** - 5.5.3
* **TBC Classic** - 2.5.5
* **Classic Era** - 1.15.8

## Installation
Download the latest version from one of the places below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.
* [CurseForge](https://www.curseforge.com/wow/addons/account-wide-ui)
* [WoWInterface](https://www.wowinterface.com/downloads/info26459-AccountWideUILayoutSelection.html)
* [Wago](https://addons.wago.io/addons/account-wide-ui)
* [GitHub](https://github.com/NinerBull/AccWideUILayoutSelection/releases/latest)
* Or put `https://github.com/NinerBull/AccWideUILayoutSelection` into your favourite Addon Manager

## Configuration
You can access the config by any of the following methods:
- Game Menu > Options > Addons > Account Wide Interface
- Typing `/awi` into chat
- Clicking the 'Account Wide Interface' option in the Addon Compartment

## Commands
- `/awi` - Opens the settings window for this addon
- `/awi profiles load` - Loads settings from the current profile
- `/awi profiles save` - Saves settings to the current profile
- `/awi profiles new PROFILENAME` - Create a new profile called PROFILENAME
- `/awi profiles choose PROFILENAME` - Switch to the profile called PROFILENAME
- `/awi profiles copyfrom PROFILENAME` - Copies data from PROFILENAME to the currently enabled profile
- `/awi profiles delete PROFILENAME` - Deletes the profile called PROFILENAME

## Translations
* **Russian** by [ZamestoTV](https://github.com/Hubbotu)

## ⚠️ Known Issues
- The following functions are disabled in Midnight due to them triggering secret-related errors:
  - Damage Meter Settings, other than toggling visibility.
  - Syncing Showing/Hiding Chat Channels per Chat Window.