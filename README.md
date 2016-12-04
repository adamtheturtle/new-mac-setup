# New Mac setup

* Download apps from [Get Mac Apps](getmacapps.com)
	* Chrome
	* Firefox
	* Dropbox
	* Alfred
	* Steam
	* VLC
	* Spotify
	* Transmission
	* iTerm2
* Sign in to Dropbox and sync desired directories
* Download apps from the App Store

## While waiting for iCloud and Dropbox sync

We then wait to set up applications because iCloud and Dropbox are donwloading much of their data.
1Password requires Dropbox and having that available helps a lot.

### Finder

Right click on the Desktop > Show View Options > Sort by "Name".

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

### Install software

* MacTex
* Homebrew

Install the following packages.

	# Install Pythons
	brew install python
	brew install python3
	brew install pypy
	brew install pypy3
	# Install the fish shell
	brew install fish
	# Install this which will allow us to copy from within tmux / tmate
	# Without this, tmate will crash given our settings
	brew install reattach-to-user-namespace
	# Allow the terminal to be shared
	brew install tmate
	# Install text editor
	brew install neovim
	# Required for CtrlSF for Neovim
	brew install ack
	# Required for Tagbar in Neovim
	brew install ctags
	# A nice way to download things
	brew install wget

* Python client for Neovim

	pip2 install neovim
	pip3 install neovim

* [pipsi](https://github.com/mitsuhiko/pipsi)
* Docker for Mac
* WhatsApp
* Messenger for Facebook
* TextMate
* BetterTouchTool
* Jitouch
* TouchSwitcher
* cd to
* [Minix ethernet driver](http://minix.com.hk/downfile/NEO_C_Ethernet_driver.zip)

### Configure Fish shell

Install [fisherman](https://github.com/fisherman/fisherman)

And extensions for `fish`:

	fisher install barnybug/docker-fish-completion
	fisher instaltl adamtheturtle/virtualfish-prompt

Add `/usr/local/bin/fish` to `/etc/shells`.

	chsh -s $(which fish)

	/usr/local/opt/python/bin/pip install virtualfish

### Set up printer

# After iCloud and Dropbox sync

## 1Password

Choose the 1Password keychain in Dropbox > 1Password

## Safari

Install Safari extensions:
	* Grammarly
	* 1Password
	* RES
	* 1Blocker

Preferences > Advanced > Tick "Show full website address"

## Alfred

Add the Powerpack license.
Advanced > Set sync folder... `~/Dropbox/Alfred 2`

Features > Clipboard
Features > 1Password > Enable 1Password bookmarks.

## iTerm2

Use settings from Dropbox.

## Authy

Sign in.

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

Install Flake8 to be used in Neovim:

	pipsi install flake8

## Shimo

Preferenes > Advanced > Storage > Choose Shimo directory in Dropbox.
Preferences > General > Show Shimo in "Menubar only".

### Quiver

Preferences > Sync > Quiver directory in Dropbox.

## Gestures

Install Jitouch or BetterTouchTool.
