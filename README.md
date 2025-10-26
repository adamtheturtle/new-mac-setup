# New Mac setup

## About This Mac

## System Preferences

In System Preferences, set the following settings:

* Apple ID
    * iCloud
        * Turn off Optimise Mac Storage
* Keyboard
    * Modifier Keys
        * Caps Lock: Escape (also do this for a connected external keyboard)
    * Text
        * Expand `eemail` to my email (maybe done automatically by iCloud)
    * Shortcuts
        * Select "Use keyboard navigation to move focus between controls"
        * Spotlight > Untick "Show Spotlight search"
        * Turn off Mission Control shortcuts
* Dock & Menubar
    * Tick "Automatically hide and show the dock"
    * Untick "Magnification"
    * Position on screen: Left
    * Untick "Show recent applications in Dock"
* Clock > Show date
* Sound > Show in menubar always
* Bluetooth > Show in menubar
* Trackpad
    * Tap to click
* Mouse (needs mouse connected)
    * Secondary click
    * More Gestures > Swipe between pages
* Internet Accounts
    * Sign in and enable accounts
* Wallet and Apple Pay
    * Set up cards

## Install and configure software

Start automated setup:

```bash
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/setup.sh
sudo echo 1 # this will cache the password
bash setup.sh # this will stop when Xcode needs to be installed. Run it again after that:
bash setup.sh
```

* Install iGlasses (private download link in email)
* Set up printer

### Notification Center

* Pin Reminders

### Craft

* Pin at least one space
* Install [Power Tools](https://www.craft.do/s/OhmDYXrBwI2wZS/b/1761ADC6-8860-4476-B73C-92A87C9CF364/Craft_Power_Tools)

### Terminal

* Preferences > Profiles > Set iTerm2 as Default theme
* View > Hide Marks
* Open `vim` and type `:Copilot setup`, and follow instructions.
* `gh auth login` to log in to the GitHub CLI

### Finder

* Ctrl + click on the Desktop > Show View Options > Sort by "Name".
* View > Show Path Bar.
* View > Show Status Bar.
* Move "cd to" from Applications to the toolbar.
* Add `/Users/<user>` to the Finder sidebar.
* Preferences > General > New Finder windows show: `<user>`

### Mail

View > Show sidebar.

### Messages

Preferences > iMessage > Enable Messages in iCloud.

### Calendar

* Choose to Sync with iCloud.
* Preferences > General > Untick "Show Birthdays calendar".
* Preferences > Accounts > Enable accounts.
* Preferences > Advanced > Turn on timezone support.
* Subscribe to Inview calendar.

### 1Password

* Choose to Sync with iCloud.
* Preferences > General > Format secure notes using Markdown
* Preferences > Developer > Use the SSH agent
* Preferences > Developer > Connect with 1Password CLI

### Safari

Install Safari extensions:

* 1Password
* 1Blocker

Preferences > Advanced > Tick "Show full website address".
Preferences > Advanced > Tick "Show Develop in menubar".

### 1Blocker

* Preferences > Untick "Show Heart Icon in 1Blocker Button".

### TextMate

* Preferences > Bundles > reStructuredText, YAML, Vagrant.
* View > Wrap Column > 80.
* View > Show Wrap Column.

### Reeder

* Preferences > Accounts > Add Feedbin.
* Preferences > General > App Icon > Don't display Unread Count.
* Preferences > General > Open links in default browser.
* Preferences > General > Open links in background.
* Preferences > General > Group items by feed.

### SSH Keys

* Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.
* `ssh-add ~/.ssh/id_rsa` (use password from 1Password).

### iPhone

* Set up text message forwarding.

### CodeRunner

For Python, change "Run Settings..." > "Run command" to "uv run $filename"

### VSCode

* Turn on Settings sync
* Install extensions:
    * `ruff`
    * `python`
    * `vim`
    * Copilot

### Zed

* Install Claude Code
* Set Accept Edits as the default mode for Claude Code (cmd + select it)

### Logins

* Open every app in 'Applications', and log in / link devices
    * Start with WhatsApp, Slack

## After iCloud Drive download complete

### Alfred

* Add the Powerpack license.
* Advanced > Set Preferences folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`
* General > Request Permissions (grant permissions)
* Features > Clipboard > Keep history
* Features > 1Password > Enable 1Password bookmarks.
* Features > Web Bookmarks > Enable Safari Bookmarks.
* [Set up the Google Drive workflow](https://github.com/azai91/alfred-drive-workflow/issues/69#issuecomment-599150203)
