# System dependencies for this dotfiles setup.
# Install everything with:  brew bundle --file ~/dev/dotfiles/Brewfile
#
# These are the binaries nvim/helix/ghostty shell out to at runtime or build
# time. They are NOT managed by Mason/lazy and won't be installed by cloning
# the repo — a fresh machine needs them or things fail at startup.

# --- editors ---
brew "neovim"
brew "helix"

# Ghostty (the terminal app itself) is intentionally NOT installed here — install
# it yourself, via brew or a direct download. See README "Terminal: Ghostty".

# --- nvim runtime deps ---
brew "tree-sitter"   # REQUIRED by nvim-treesitter `main` branch: parser install
                     # (treesitter.install / :TSUpdate) shells out to this CLI.
brew "luarocks"      # lazy.nvim luarocks support (flagged by :checkhealth lazy).
brew "ripgrep"       # fzf-lua live grep (rg).
brew "fd"            # fzf-lua file finder.

# --- fonts ---
cask "font-jetbrains-mono-nerd-font"   # ghostty `font-family = JetBrainsMono Nerd Font`

# NOT managed by brew on purpose — use your own version manager (see README):
#   node   -> nvm (JS-based LSP servers need `node` on PATH)
#   rust   -> rustup.rs installer (rustaceanvim + codelldb; provides rust-analyzer)
#   C compiler -> Xcode Command Line Tools on macOS:  xcode-select --install
