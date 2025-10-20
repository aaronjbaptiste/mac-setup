#!/bin/bash

echo "[Start] Installing Homebrew"

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[Start] Homebrew already installed, updating"
    brew update
    echo "[Done] Homebrew already installed, updating"
fi

echo "[Done] Installing Homebrew"

echo "[Start] Homebrew upgrade packages"

brew upgrade
brew bundle

echo "[Done] Homebrew upgrade packages"
