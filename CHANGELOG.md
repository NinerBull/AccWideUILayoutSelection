# WoW: Forever
This version adds initial support for WoW: Forever!
- Added Gamepad Settings Sync.
- Added syncing Gamepad Specific Edit Mode Layout.
- Added multiple new CVars.
- Added Trade (Local) to Chat Channel Manager for WoW: Forever.

## Additional Changes
- Updated Simplified Chinese translations by nanjuekaien1, thank you!
- Switched Profile and Graphics Import/Export settings to use Blizz's own Encoding/Decoding functions.
- Most Chat Window Settings will now only be changed if needed, instead upon every addon settings load. This is a test to try and prevent taint in Mythic+/Boss Encounters.
- Numerous fixes and improvements submitted by [Erdmann5150](https://github.com/NinerBull/AccWideUILayoutSelection/pull/54), thank you!
- Updated TOC for 12.1.5 and 1.60.1.

### Known Issues
- (Forever) Any time Action Bar visibility is changed by this addon, a UI Reload will be required, as modifying Action Bar visibility taints the interface.
    - Due to this, Action Bar visibility syncing is disabled by default in WoW: Forever, but can be enabled if you wish. A notice will appear asking you to Reload the interface whenever required.