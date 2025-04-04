#!/bin/bash

set -e

echo "Setting macOS preferences..."

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
echo "Disabling shake mouse pointer to locate feature..."
defaults write -g CGDisableCursorLocationMagnification -bool true

# Always show Sound in menu bar
defaults -currentHost write com.apple.controlcenter "Sound" -int 18
killall ControlCenter 2>/dev/null
killall SystemUIServer 2>/dev/null

echo "Shake mouse pointer to locate feature disabled."

echo "Preferences set."
echo "Clearing the Dock..."
defaults write com.apple.dock persistent-apps -array ""
defaults write com.apple.dock autohide -bool true
killall Dock
echo "Dock cleared."

echo "Installing Homebrew..."

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if ! grep -qxF 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed, skipping..."
fi

echo "Installing apps with Homebrew Cask..."

brew install --cask firefox
brew install --cask 1password
brew install --cask slack
brew install --cask visual-studio-code
brew install --cask chatgpt
brew install --cask nikitabobko/tap/aerospace

echo "Installing apps with Homebrew..."

brew install defaultbrowser
brew install chezmoi

echo "Setup dotfiles"

# Initialize and apply dotfiles with chezmoi
chezmoi init --apply aaronjbaptiste

# Update chezmoi git remote URL
cd /Users/aaron/.local/share/chezmoi
git remote set-url origin aarongit:aaronjbaptiste/dotfiles.git
cd ~

# Add VS Code to PATH for CLI use
if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  if ! grep -qxF 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' "$HOME/.zprofile"; then
    echo 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> "$HOME/.zprofile"
  fi
fi

echo "Installing VS Code extensions..."

# Install RooCode extension
code --install-extension RooVeterinaryInc.roo-cline

echo "Setting Firefox as the default browser..."
defaultbrowser firefox
echo "Default browser set to Firefox."

echo "All apps installed."

echo "Installing Node.js with Homebrew..."
if ! command -v node &> /dev/null; then
  brew install node
else
  echo "Node.js already installed, skipping..."
fi
echo "Node.js installation complete."

echo "🎉 Setup complete!"
