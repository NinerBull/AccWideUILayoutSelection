This new beta version of the addon has been rewritten to use the [Ace3 Library](https://www.wowace.com/projects/ace3) library, please give it a try and let me know what you think!

I'm aiming to make sure the addon is ready to go before Legion Remix begins, so you are prepared for the upcoming wave of new alts!

## Major Changes
- **Updated Interface** - Addon Interface now uses the Ace3 Library, so the UI is more consistent with other addons.
- **Profile Support** - You can now save multiple sets of settings, and switch between them any time. 
  - For example, you could have a profile configured specifically for your healers, another for your hunters, and a third default profile for all others.
  - For existing users: Your settings will automatically be migrated to the "Default" profile after updating the addon.
- **Updated Blizz Chat Channels** - You can now force all characters to _join_ official channels such as Trade or LocalDefense as well as force leave them.
- **Screen Resolution Specific Settings** - Certain settings can now be saved and loaded depending on the resolution of your monitor. Useful if you sync your addon settings across multiple devices.
  - This can be enabled in the Advanced Settings tab of the addon settings.

## Other Changes
- Reorganised the various settings into groups and tabs, so that the interface is less claustrophobic.
- Added a button that will move the Zone Map to the centre of the screen, in case it ever moves off-screen.

## New Commands
These profile commands could be useful for macros.
- `/awi profiles new PROFILENAME` - Create a new profile called PROFILENAME
- `/awi profiles choose PROFILENAME` - Switch to the profile called PROFILENAME
- `/awi profiles copyfrom PROFILENAME` - Copies data from PROFILENAME to the currently equipped profile
- `/awi profiles delete PROFILENAME` - Deletes the profile called PROFILENAME

## Fixes
- Fixed Zone Map settings not saving and loading correctly.
- Creating a new profile should no longer remove visible chat channels from all chat windows.

---



Want to help with any translations? Please send a Pull Request!