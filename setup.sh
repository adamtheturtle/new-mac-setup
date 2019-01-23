set -euxo pipefail

# Change screenshot location

defaults write com.apple.screencapture location "/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"


# Set up git

git config --global user.name "Adam Dangoor"
git config --global user.email adamdangoor@gmail.com

# Homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/Brewfile
brew tap homebrew/bundle
brew bundle

# Python client for Neovim
pip2 install neovim
pip3 install neovim

# virtualenv
pip3 install virtualenv

# pipsi
curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python3

# Install [fisher](https://github.com/fisherman/fisher),
# [virtualfish](https://github.com/adambrenecki/virtualfish) and extensions for `fish`,
# and set `fish` to be the default shell:

echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c 'fisher add barnybug/docker-fish-completion'
pip3 install virtualfish
eval $(python3 -m virtualfish)

# Set Terminal theme

curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/iTerm2.terminal
open iTerm2.terminal
rm -rf iTerm2.terminal

# Set up configuration for multiple applications

cd ~/Documents
git clone https://github.com/adamtheturtle/dotfiles.git
cd dotfiles
./makesymlinks.sh
