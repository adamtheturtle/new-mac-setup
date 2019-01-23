# New Mac setup

## Download apps from the App Store

## While waiting for iCloud sync

We then wait to set up applications because iCloud is downloading much of their data.

### Finder

Ctrl + click on the Desktop > Show View Options > Sort by "Name".

## Messages

Preferences > iMessage > Enable Messages in iCloud.

### System Preferences

In System Preferences, set the following settings:

* Keyboard
    * Customize Control Strip
        * Remove Siri
        * Add Screenshot
    * Modifier Keys
        * Caps Lock: Escape
                * Do this for both internal and external keyboards
    * Text
        * Expand `eemail` to my email
    * Shortcuts
        * Set Full Keyboard Access to "All controls"
        * Spotlight
                * Untick "Show Spotlight search"
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

### Install and configure software

Start automated setup:

```bash
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/setup.sh
bash setup.sh
```

* Install iGlasses (private download link in email)
* cd to
* Backblaze (`open "/usr/local/Caskroom/backblaze/latest/Backblaze Installer.app"`)
* Terminal > Preferences > Profiles > Set iTerm2 as Default theme
* Set up printer

# After iCloud sync

## 1Password

Choose to Sync with iCloud

## Safari

Install Safari extensions:

* Grammarly
    * Set the language to American English
* 1Password
* RES
* 1Blocker

Preferences > Advanced > Tick "Show full website address".

## Alfred

Add the Powerpack license.
Advanced > Set sync folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`

Features > Clipboard
Features > 1Password > Enable 1Password bookmarks.

## Chroma

Connect to Hue.

## Latexian

Run the following in the terminal:

```bash
which pdftex
```

This will show a path.

In Latexian > Preferences > Preview set the folder for TeX installation to the parent directory of that path.

## SSH Keys

Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.

## Shimo

Preferenes > Advanced > Storage > Choose Shimo directory in iCloud Drive.
Preferences > General > Show Shimo in "Menubar only".

### Quiver

Preferences > Sync > Quiver directory in iCloud Drive.

## Gestures

Install Jitouch.
