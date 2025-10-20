#!/bin/bash

set -e

bash macos/config.sh

bash homebrew/install.sh

echo "[Start] Setup fish"

FISH_PATH="$(command -v fish)"

if ! grep -qxF "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

# Set fish as default shell
chsh -s $(which fish)

# Install fisher
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher'
fish -c 'fisher install jethrokuan/z'

echo "[Done] Setup fish"

echo "[Start] Setup dotfiles"

if [[ ! -d "$HOME/.local/share/yadm/repo.git" ]]; then
  echo "Cloning dotfiles repo..."
  yadm clone --bootstrap git@github.com:aaronjbaptiste/dotfiles.git
else
  echo "Dotfiles repo already exists. Pulling latest changes..."
  yadm pull --rebase
fi

echo "[Done] Setup dotfiles"

echo "[Start] Installing apps with proto"

proto install node 24
proto install bun
proto install moon

echo "[Done] Installing apps with proto"

echo "[Start] Installing apps with npm"

npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex

echo "[Done] Installing apps with npm"

echo "[Start] Setting Zen as the default browser"

defaultbrowser zen

echo "[Done] Setting Zen as the default browser"

echo "🎉 Setup complete!"
