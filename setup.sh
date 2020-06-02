set -euxo pipefail

# Change screenshot location

defaults write com.apple.screencapture location "/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Screenshots"

# Homebrew
# --------

# Pass in /dev/null so we do not have a prompt
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/Brewfile
brew tap homebrew/bundle
brew bundle
rm -rf Brewfile

# Python client for Neovim
pip3 install neovim

# virtualenv
pip3 install virtualenv
# Without this, you get asked the first time you make a virtualenv
mkdir -p ~/.virtualenvs

# Install pipx
pip3 install pipx

# Install [fisher](https://github.com/fisherman/fisher),
# [virtualfish](https://github.com/adambrenecki/virtualfish) and extensions for `fish`,
# and set `fish` to be the default shell:

echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c 'fisher add barnybug/docker-fish-completion'
pip3 install virtualfish

# Set Terminal theme

curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/iTerm2.terminal
open iTerm2.terminal
rm -rf iTerm2.terminal

mas install 904280696 # Things3 (3.8)
mas install 430255202 # Mactracker (7.7.7)
mas install 1153157709 # Speedtest (1.5)
mas install 931657367 # Calcbot (1.0.7)
mas install 587512244 # Kaleidoscope (2.2.2)
mas install 880001334 # Reeder (3.2.1)
mas install 682658836 # GarageBand (10.3.2)
mas install 497799835 # Xcode (10.1)
mas install 1147396723 # WhatsApp (0.3.1850)
mas install 440641508 # Piezo (1.2.6)
mas install 1384080005 # Tweetbot (3.2)
mas install 924726344 # Deliveries (3.1.1)
mas install 504544917 # Clear (1.1.7)
mas install 403012667 # Textual (4.1.8)
mas install 445770608 # Go2Shell (1.2.2)
mas install 946399090 # Telegram Desktop (1.5.8)
mas install 1303222628 # Paprika Recipe Manager 3 (3.3.4)
mas install 445189367 # PopClip (1.5.8)
mas install 413965349 # Soulver (2.6.8)
mas install 603637384 # Name Mangler 3 (3.4.1)
mas install 409201541 # Pages (7.3)
mas install 803453959 # Slack (3.3.7)
mas install 566429668 # SofaPlay (2.1.5)
mas install 668429425 # Downcast (2.9.38)
mas install 1376402589 # StopTheMadness (5.0)
mas install 1031280567 # Postico (1.5.3)
mas install 411643860 # DaisyDisk (4.6.5)
mas install 1090488118 # Gemini 2 (2.5.4)
mas install 406056744 # Evernote (7.8)
mas install 408981434 # iMovie (10.1.10)
mas install 409203825 # Numbers (5.3)
mas install 866773894 # Quiver (3.2.3)
mas install 425955336 # Skitch (2.8.2)
mas install 775737590 # iA Writer (5.2.1)
mas install 409183694 # Keynote (8.3)
mas install 897118787 # Shazam (2.1)
mas install 1107421413 # 1Blocker (1.4.5)
mas install 1480068668 # Facebook Messenger (53.5.117)

/usr/local/opt/fzf/install --all

# Install [vim-plug](https://github.com/junegunn/vim-plug#installation)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install vim plugins with `:PlugInstall`.
nvim +PlugInstall +qall --headless

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
./makesymlinks.sh
