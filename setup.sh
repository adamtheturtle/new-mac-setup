set -euxo pipefail

# Change screenshot location

defaults write com.apple.screencapture location "/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"

# Homebrew
# --------

# Pass in /dev/null so we do not have a prompt
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
curl -fsSL https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/Brewfile | brew bundle --file=-

# Install [fisher](https://github.com/fisherman/fisher),
# [virtualfish](https://github.com/adambrenecki/virtualfish) and extensions for `fish`,
# and set `fish` to be the default shell:

echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c 'fisher install barnybug/docker-fish-completion'
fish -c 'fisher install adamtheturtle/virtualfish-prompt'
uv pip install --system virtualfish
vf install

# Set Terminal theme

curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/iTerm2.terminal
open iTerm2.terminal
rm -rf iTerm2.terminal

/opt/homebrew/opt/fzf/install --all

xcode-select --install
sudo xcodebuild -license

# Set up git

git config --global push.default current
git config --global user.name "Adam Dangoor"
git config --global user.email adamdangoor@gmail.com

# Set up configuration for multiple applications

cd ~/Documents
rm -rf dotfiles
git clone https://github.com/adamtheturtle/dotfiles.git
cd dotfiles
git remote set-url origin git@github.com:adamtheturtle/dotfiles.git
./makesymlinks.sh

# Install [vim-plug](https://github.com/junegunn/vim-plug#installation)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install vim plugins with `:PlugInstall`.
nvim +PlugInstall +qall --headless
