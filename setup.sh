#!/bin/bash

set -e

echo "[Start] Setting macOS preferences"

# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable right-click on touchpad
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable window drag on ctrl + cmd
defaults write -g NSWindowShouldDragOnGesture -bool true

# Disable mouse acceleration
defaults write NSGlobalDomain com.apple.mouse.linear -bool YES

# Disable shake mouse pointer to locate
defaults write -g CGDisableCursorLocationMagnification -bool true

# Disable input source switching with fn key
defaults write com.apple.HIToolbox AppleFnUsageType -int 0
killall SystemUIServer

# Clear dock
defaults write com.apple.dock persistent-apps -array ""
# Auto hide dock
defaults write com.apple.dock autohide -bool true
killall Dock

echo "[Done] Setting macOS preferences"

echo "[Start] Installing Homebrew"

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if ! grep -qxF 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed, skipping..."
fi

echo "[Done] Installing Homebrew"

echo "[Start] Installing apps with Homebrew Cask"

brew install --cask 1password
brew install --cask zed
brew install --cask chatgpt
brew install --cask nikitabobko/tap/aerospace
brew install --cask spotify
brew install --cask figma
brew install --cask discord
brew install --cask zen
brew install --cask ghostty
brew install --cask raycast

echo "[Done] Installing apps with Homebrew Cask"

echo "[Start] Installing apps with Homebrew"

brew install fish
brew install defaultbrowser
brew install yadm

# brew install ripgrep
# brew install defaultbrowser
# brew install chezmoi
# brew install uv
# brew install node
# brew install cloudflared
# brew install git-filter-repo
# brew install stripe/stripe-cli/stripe
# brew install treethis
# brew install pip
# brew install go
# brew install git-lfs
# brew install git
# brew install tmux
# brew install starship
# brew install flyctl
# brew install peco
# brew install eza
# brew install gh
# brew install fd
# brew tap FelixKratz/formulae
# brew install borders

echo "[Done] Installing apps with Homebrew"

echo "[Start] Setup fish"

# Add fish to list of known shells
sudo bash -c 'echo $(which fish) >> /etc/shells'
# Set fish as default shell
chsh -s $(which fish)

# Install fisher
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# # Install fisher plugins
# fisher install jethrokuan/z

echo "[Done] Setup fish"

echo "[Start] Setup dotfiles"

# Initialize and apply dotfiles with chezmoi
# chezmoi init --apply aaronjbaptiste

# Update chezmoi git remote URL
# cd /Users/aaron/.local/share/chezmoi
# git remote set-url origin aarongit:aaronjbaptiste/dotfiles.git
# cd ~

echo "[Done] Setup dotfiles"

echo "[Start] Setting Zen as the default browser"

defaultbrowser zen

echo "[Done] Setting Zen as the default browser"

# npm install -g @openai/codex

# echo "Installing bun..."
# curl -fsSL https://bun.sh/install | bash
# # Add bun to PATH for future sessions in .zprofile
# if ! grep -qxF 'export PATH="$HOME/.bun/bin:$PATH"' "$HOME/.zprofile"; then
#   echo '# Add bun to PATH' >>"$HOME/.zprofile"
#   echo 'export PATH="$HOME/.bun/bin:$PATH"' >>"$HOME/.zprofile"
# fi
# echo "bun installation complete."

# echo "Installing rust"

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# echo "rust install complete."

# echo "Installing rust-analyzer"
# rustup component add rust-analyzer
# echo "rust-analyzer install complete."

# echo "Installing iStat Menus settings..."

# TODO: Add this to the dotfiles
# open -a "iStat Menus" ~/Library/Mobile\ Documents/com~apple~CloudDocs/Config/iStat\ Menus\ Settings.ismp7

# echo "Installing iStat Menus settings complete."

echo "Sourcing fish to apply environment changes..."
source "$HOME/.config/fish/config.fish"

echo "🎉 Setup complete!"
