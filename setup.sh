set -euxo pipefail

# System Settings
# ---------------

# Settings that used to be a manual checklist in the README. Anything still
# listed there could not be done this way: keyboard shortcuts live in
# com.apple.symbolichotkeys, which is fiddly to write and only applies after a
# logout, and account-level settings (iCloud, Internet Accounts, Wallet) have no
# defaults key at all.
#
# Every key below was read back from a machine already configured by hand, so
# these are the values macOS itself writes rather than remembered ones.

defaults write com.apple.screencapture location "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"

# Dock: hide it, put it on the left, no magnification, no recent applications.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-recents -bool false

# "Use keyboard navigation to move focus between controls".
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Trackpad tap to click. Three keys: the built-in trackpad, a Bluetooth one, and
# the global setting the Settings pane also writes.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Mouse secondary click, and "Swipe between pages". Written for both the
# built-in domain and the Bluetooth one so a Magic Mouse is covered whichever
# way it is paired.
for mouse_domain in com.apple.AppleMultitouchMouse com.apple.driver.AppleBluetoothMultitouch.mouse; do
    defaults write "$mouse_domain" MouseButtonMode -string TwoButton
    defaults write "$mouse_domain" MouseTwoFingerHorizSwipeGesture -int 2
done

# Menu bar: always show Sound and Bluetooth. 18 is "Always Show in Menu Bar";
# these live in the per-host domain, not the plain one.
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18

# Show the date in the menu bar clock. 1 is always, 0 is only when there is room.
defaults write com.apple.menuextra.clock ShowDate -int 1

# Finder: path bar, status bar, and new windows open at home (PfHm).
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm

# Sort the Desktop by name. Nested inside the plist, so defaults cannot set it.
# Not fatal: on a machine that has never opened a Finder window the key path
# does not exist yet and PlistBuddy exits 1, which would end the script here.
/usr/libexec/PlistBuddy \
    -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy name" \
    ~/Library/Preferences/com.apple.finder.plist ||
    echo "Could not sort the Desktop by name; do it from Show View Options."

# Restart the things that only read their preferences at startup. Not fatal:
# these are cosmetic, and on a fresh machine one of them may not be running yet.
killall Dock || true
killall Finder || true
killall ControlCenter || true
killall SystemUIServer || true

# Homebrew
# --------

# Pass in /dev/null so we do not have a prompt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
curl -fsSL https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/main/Brewfile | brew bundle --file=-

# Install [fisher](https://github.com/jorgebucaran/fisher) and the Docker
# completions for `fish`, and set `fish` to be the default shell.
# Python environments are managed with `uv` (from the Brewfile), so virtualfish
# is deliberately not installed.

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c 'fisher install barnybug/docker-fish-completion'

xcode-select --install
sudo xcodebuild -license

gh auth login
# Set up git

git config --global push.default current
git config --global user.name "Adam Dangoor"
git config --global user.email adamdangoor@gmail.com

# Set up configuration for multiple applications

cd ~/Documents
if [ ! -d dotfiles/.git ]; then
    git clone https://github.com/adamtheturtle/dotfiles.git
fi
cd dotfiles
git remote set-url origin git@github.com:adamtheturtle/dotfiles.git
# Never fatal: an existing checkout with local work should survive a re-run.
git pull --ff-only || echo "dotfiles: could not fast-forward, leaving the checkout alone"
./makesymlinks.sh

# Run after makesymlinks.sh: the fzf installer writes its key bindings and
# completions into the shell config directories, so running it first means
# those edits are replaced by the dotfiles symlinks.
/opt/homebrew/opt/fzf/install --all

# Only now that fish's configuration is symlinked into place, and fzf has added
# its key bindings, is it safe to make fish the login shell: doing it earlier
# leaves you logging in to a fish with no config, on a machine where the rest of
# setup has not finished.
fish_path="$(which fish)"
# Only append once: re-running setup.sh must not grow /etc/shells.
grep -qxF "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells
chsh -s "$fish_path"

# Install [vim-plug](https://github.com/junegunn/vim-plug#installation)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install vim plugins with `:PlugInstall`.
nvim +PlugInstall +qall --headless

# Allow XCode agents to use any tools
defaults write com.apple.dt.Xcode IDEChatAgenticChatSkipPermissions -bool YES
