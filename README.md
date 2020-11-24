# New Mac setup

## About This Mac

## System Preferences

In System Preferences, set the following settings:

* Apple ID
    * iCloud
    * Turn off Optimise Mac Storage
* Keyboard
    * Customize Control Strip (if there is a touchbar)
        * Remove Siri
        * Add Screenshot
    * Modifier Keys
        * Caps Lock: Escape (also do this for a connected external keyboard)
    * Text
        * Expand `eemail` to my email
    * Shortcuts
        * Select "Use keyboard navigation to move focus between controls"
        * Spotlight > Untick "Show Spotlight search"
* Dock
    * Tick "Automatically hide and show the dock"
    * Untick "Magnification"
    * Position on screen: Left
    * Untick "Show recent applications in Dock"
* Trackpad
    * Tap to click
* Mouse (needs mouse connected)
    * Secondary click
    * More Gestures > Swipe between pages
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
* Set up printer

### Popclip

Enable and launch at startup.

### Google Backup and Sync

Set this up.

### Terminal

* Preferences > Profiles > Set iTerm2 as Default theme
* View > Hide Marks
* Open `vim` and type `TabNine::config`.
* Open `vim` again, open any Python file and type `TabNine::sem`.

### Finder

* Ctrl + click on the Desktop > Show View Options > Sort by "Name".
* View > Show Path Bar.
* View > Show Status Bar.
* Move "cd to" from Applications to the toolbar.
* Add `/Users/<user>` to the Finder sidebar.
* Preferences > General > New Finder windows show: `<user>`

### Mail

View > Show Mailbox List.

### Messages

Preferences > iMessage > Enable Messages in iCloud.

### Calendar

* Choose to Sync with iCloud.
* Preferences > General > Untick "Show Birthdays calendar".
* Preferences > Accounts > Enable accounts.
* Preferences > Advanced > Turn on timezone support.

### 1Password

Choose to Sync with iCloud.

### Safari

Install Safari extensions:

* Grammarly
    * Set the language to American English
* 1Password
* 1Blocker

Preferences > Advanced > Tick "Show full website address".

### 1Blocker

* Preferences > Untick "Show Heart Icon in 1Blocker Button".

### TextMate

* Preferences > Bundles > reStructuredText, YAML, Vagrant.
* View > Wrap Column > 80.
* View > Show Wrap Column.

### Reeder

* Preferences > General > App Icon > Don't display Unread Count.
* Preferences > Accounts > Add Feedbin
* Preferences > Reading > Article Viewer > Open links in default browser.
* Preferences > Reading > Web Browser > Open links in background.
* View > Group items by feed.

### Slack

* Log in to all workspaces.

### Things

* Enable Things Cloud.

### Clear

* Enable iCloud.

### SSH Keys

* Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.
* `ssh-add ~/.ssh/id_rsa` (use password from 1Password).

## After iCloud Drive download complete

### Alfred

* Add the Powerpack license.
* Advanced > Set Preferences folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`
* General > Request Permissions (grant permissions)
* Features > Clipboard > Keep history
* Features > 1Password > Enable 1Password bookmarks.
* Features > Web Bookmarks > Enable Safari Bookmarks.

### Shimo

* Preferences > Advanced > Storage > Choose Shimo directory in iCloud Drive.
* Preferences > General > Show Shimo in "Menubar only".

### Quiver

Preferences > Sync > Quiver directory in iCloud Drive.
