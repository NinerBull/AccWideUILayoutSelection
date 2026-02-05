- Changed how Damage Meter Settings are applied:
  - Addon will no longer destory and recreate the windows, it will now always create the max number of windows, and hide the ones that do not need to be show.
  - Disabled syncing whether Damage Meters are locked and what meter type to show, due to it causing secret-related errors, somehow.
- Chat windows now have a unique set of variables for the NewcomerChat channel, so settings should now carry over to chars in this Channel correctly.

### ⚠️ Known Issues
- The following functions are disabled in Midnight due to them triggering secret-related errors:
  - Damage Meter's locked status, and what data to show.
  - Reordering Chat Channels (Syncing what number slot each channel uses, e.g. /2 for trade)
- Any Damage Meter windows created by this addon that did not already exist on the character you logged into (e.g. a fresh character) will cause Taint errors when clicking a character to view more info.
  - This should not occur again after relogging into the same character, or typing `/reload` into the chat box, as long as you do not manually close and re-open the extra Damage Meter window(s).
