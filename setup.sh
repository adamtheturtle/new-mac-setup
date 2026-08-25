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

# Install [fisher](https://github.com/jorgebucaran/fisher) and the Docker
# completions for `fish`, and set `fish` to be the default shell.
# Python environments are managed with `uv` (from the Brewfile), so virtualfish
# is deliberately not installed.

fish_path="$(which fish)"
# Only append once: re-running setup.sh must not grow /etc/shells.
grep -qxF "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells
chsh -s "$fish_path"
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

# Install [vim-plug](https://github.com/junegunn/vim-plug#installation)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install vim plugins with `:PlugInstall`.
nvim +PlugInstall +qall --headless

# Allow XCode agents to use any tools
defaults write com.apple.dt.Xcode IDEChatAgenticChatSkipPermissions -bool YES
