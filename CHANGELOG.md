This new version of the addon has been rewritten to use the [Ace3 Library](https://www.wowace.com/projects/ace3), and has many new features!

## Major Changes
- **Updated Interface** - Addon Interface now uses the Ace3 Library, so the UI's look and feel is consistent with other addons.
- **Profile Support** - You can now save and switch between multiple profiles, each with their own sync settings and saved variables.
  - For example, you could have a profile configured specifically for your healers, another for your hunters, and a third default profile for all others.
  - For existing users: Your settings will automatically be migrated to the "Default" profile after updating the addon.
    If required, you can re-import your old settings again by typing `/run AccWideUIAceAddon:MigrateFromV1(true)` into chat.
- **Updated Blizz Chat Channels** - You can now force all characters to _join_ official channels such as Trade or LocalDefense as well as force leave them.
- **Screen Resolution Specific Settings** - Certain settings can now be synchronised based on the resolution of your monitor. Useful if you sync your addon settings across multiple devices. This can be enabled in the Advanced Settings tab of the addon settings.
- **Custom CVar Support** - As well as the default list of sync settings, you can enter your own list of additional CVars to synchronise across characters. This can be enabled in the Advanced Settings tab of the addon settings.

## Other Changes
- Reorganised the various settings into groups and tabs, so that the interface is less claustrophobic.
- Added a button that will move the Zone Map to the centre of the screen, in case it ever moves off-screen.
- Added ability to disable the auto saving and loading of profiles. You'll be able to manually save/load settings via the settings interface, or a chat command.
- The "Bag Organisation" setting is now behind a "Allow Experimental Sync Settings" Flag. Tick this in the advanced settings to reveal it!
- Made the addon name slightly shorter.

## New Commands
These profile commands could be useful for macros.
- `/awi profiles load` - Loads settings from the current profile
- `/awi profiles save` - Saves settings to the current profile
- `/awi profiles new PROFILENAME` - Create a new profile called PROFILENAME
- `/awi profiles choose PROFILENAME` - Switch to the profile called PROFILENAME
- `/awi profiles copyfrom PROFILENAME` - Copies data from PROFILENAME to the currently equipped profile
- `/awi profiles delete PROFILENAME` - Deletes the profile called PROFILENAME

## Fixes
- (Hopefully) Fixed Zone Map settings not saving and loading correctly.
- Bag Organisation flags are sent more slowly, to try and avoid any issues with slow networks.

Thank you for using the addon, I hope you find it useful.

Want to help with any translations? Please send a Pull Request on Github!