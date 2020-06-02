# New Mac setup

## About This Mac

## System Preferences

In System Preferences, set the following settings:

* Apple ID
    * iCloud
    * Turn off Optimise Mac Storage
* Keyboard
    * Customize Control Strip
        * Remove Siri
        * Add Screenshot
    * Modifier Keys
        * Caps Lock: Escape
    * Text
        * Expand `eemail` to my email
    * Shortcuts
        * Set Full Keyboard Access to "All controls"
        * Spotlight > Untick "Show Spotlight search"
* Dock
    * Tick "Automatically hide and show the dock"
    * Untick "Magnification"
    * Position on screen: Left
* Trackpad
    * Tap to click
* Internet Accounts
    * Sign in and enable accounts
* Sound
    * Show volume in menubar
* Date and Time
    * Clock > Show date
* Wallet and Apple Pay
    * Set up cards
* Bluetooth
    * Show bluetooth in menubar


## Install and configure software

Start automated setup:

```bash
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/setup.sh
bash setup.sh # this will stop when Xcode needs to be installed. Run it again after that:
bash setup.sh
```

* Install iGlasses (private download link in email)
* cd to
* Terminal > Preferences > Profiles > Set iTerm2 as Default theme
* Set up printer

### Finder

* Ctrl + click on the Desktop > Show View Options > Sort by "Name".
* View > Show Path Bar.
* View > Show Status Bar.

### Mail

View > Show Mailbox List.

### Messages

Preferences > iMessage > Enable Messages in iCloud.

### Calendar

* Choose to Sync with iCloud.
* Preferences > General > Untick "Show Birthdays calendar".
* Preferences > Accounts > Enable accounts.

### 1Password

Choose to Sync with iCloud.

### Safari

Install Safari extensions:

* Grammarly
    * Set the language to American English
* 1Password
* 1Blocker

Preferences > Advanced > Tick "Show full website address".

### SSH Keys

Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.

## After iCloud Drive download complete

### Alfred

* Add the Powerpack license.
* Advanced > Set sync folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`
* Features > Clipboard
* Features > 1Password > Enable 1Password bookmarks.

### Shimo

* Preferences > Advanced > Storage > Choose Shimo directory in iCloud Drive.
* Preferences > General > Show Shimo in "Menubar only".

### Quiver

Preferences > Sync > Quiver directory in iCloud Drive.
