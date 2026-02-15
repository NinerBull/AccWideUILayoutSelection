- Removed 'spellActivationOverlayOpacity' CVar from sync, as it is now Account-Wide by default, which should prevent it resetting to 0.
  - Fixed so if 'spellActivationOverlayOpacity' is 0 upon loading after updaying the addon, it will reset it to default.

## ⚠️ Known Issues
- The following functions are disabled in Midnight due to them triggering secret-related errors:
  - Damage Meter Settings, other than toggling visibility.
  - Syncing Showing/Hiding Chat Channels per Chat Window.