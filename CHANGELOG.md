- Removed 'spellActivationOverlayOpacity' CVar from sync, as it is now Account-Wide by default, which should prevent it resetting to 0.
  - Added a one-time script to check if 'spellActivationOverlayOpacity' is 0 upon loading after updating. If so, it'll reset to Default.
- Addon will now force-refresh tabs in the Chat Dock upon loading Settings.

## ⚠️ Known Issues
- The following functions are disabled in Midnight due to them triggering secret-related errors:
  - Damage Meter Settings, other than toggling visibility.
  - Syncing Showing/Hiding Chat Channels per Chat Window.