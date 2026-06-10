#!/usr/bin/env sh
# Symlink each config folder in this repo into ~/.config/
# Safe to re-run. Existing non-symlink configs are backed up to <name>.bak.
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.config"

for app in nvim helix ghostty; do
  target="$HOME/.config/$app"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "backing up existing $target -> $target.bak"
    mv "$target" "$target.bak"
  fi
  ln -sfn "$REPO/$app" "$target"
  echo "linked $target -> $REPO/$app"
done
