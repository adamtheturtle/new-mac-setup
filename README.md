# New Mac setup

* Download apps from [Get Mac Apps](getmacapps.com)
	* Chrome
	* Firefox
	* Alfred
	* Steam
	* VLC
	* Spotify
	* Transmission

* Download apps from the App Store

## While waiting for iCloud sync

We then wait to set up applications because iCloud is downloading much of their data.

### Finder

Ctrl + click on the Desktop > Show View Options > Sort by "Name".

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

### Change Screenshot location

```
defaults write com.apple.screencapture location "/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"
```

### Install software

* MacTex
* Homebrew

Install Homebrew and its packages.

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/Brewfile
	brew tap homebrew/bundle
	brew bundle

* Python client for Neovim

	```
	pip2 install neovim
	pip3 install neovim
	```

* `virtualenv`:

	```
	pip3 install virtualenv
	```

* [pipsi](https://github.com/mitsuhiko/pipsi)
* Docker for Mac
* Messenger for Facebook
* TextMate
* Jitouch
* iGlasses
* cd to

### Configure Fish shell

Install [fisherman](https://github.com/fisherman/fisherman)

Install [virtualfish](https://github.com/adambrenecki/virtualfish):

	pipsi install --python=(which python3) virtualfish

And extensions for `fish`:

	fisher install barnybug/docker-fish-completion
	fisher install adamtheturtle/virtualfish-prompt

Add `/usr/local/bin/fish` to `/etc/shells`.

	chsh -s $(which fish)

	/usr/local/opt/python/bin/pip install virtualfish

### Set up printer

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

Preferences > Advanced > Tick "Show full website address"

## Alfred

Add the Powerpack license.
Advanced > Set sync folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`

Features > Clipboard
Features > 1Password > Enable 1Password bookmarks.

## Chrome

Sign in.

## Chroma

Connect to Hue.

## Latexian

Run the following in the terminal:

	which pdftex

This will show a path.

In Latexian > Preferences > Preview set the folder for TeX installation to the parent directory of that path.

## SSH Keys

Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.

## Dotfiles

Clone dotfiles and move them into place.

	cd ~/Documents
	git clone git@github.com:adamtheturtle/dotfiles.git
	cd dotfiles
	./makesymlinks.sh
	
## Neovim

Install [vim-plug](https://github.com/junegunn/vim-plug#installation).
Install plugins with `:PlugInstall`.

[Compile YouCompleteMe](https://github.com/Valloric/YouCompleteMe#mac-os-x) with support for C-family languages.

Install linting tools to be used in Neovim:

	pipsi install --python=(which python3) flake8 mypy pylint yapf
	pip3 install isort

## Shimo

Preferenes > Advanced > Storage > Choose Shimo directory in iCloud Drive.
Preferences > General > Show Shimo in "Menubar only".

### Quiver

Preferences > Sync > Quiver directory in iCloud Drive.

## Gestures

Install Jitouch.

## Messages

Preferences > iMessage > Enable Messages in iCloud.
