#!/usr/bin/env sh
# Symlink config folders in this repo into ~/.config/
# Safe to re-run. Existing non-symlink configs are backed up to <name>.bak.
#
# Usage:
#   ./install.sh                # link everything (nvim, helix, ghostty)
#   ./install.sh nvim           # link only nvim
#   ./install.sh helix ghostty  # link a subset
#
# Pair each app with its Brewfile for the system deps, e.g.:
#   brew bundle --file Brewfile.nvim && ./install.sh nvim
set -e

REPO="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.config"

APPS="${*:-nvim helix ghostty}"

for app in $APPS; do
  if [ ! -d "$REPO/$app" ]; then
    echo "unknown app '$app' (no $REPO/$app folder), skipping" >&2
    continue
  fi
  target="$HOME/.config/$app"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "backing up existing $target -> $target.bak"
    mv "$target" "$target.bak"
  fi
  ln -sfn "$REPO/$app" "$target"
  echo "linked $target -> $REPO/$app"
done
