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
brew "tree-sitter-cli"  # REQUIRED by nvim-treesitter `main` branch: parser install
                        # (treesitter.install / :TSUpdate) shells out to this CLI.
                        # NOTE: the `tree-sitter` formula is the library only (no
                        # bin/) — `tree-sitter-cli` provides the actual CLI binary.
brew "luarocks"         # lazy.nvim luarocks support (flagged by :checkhealth lazy).
brew "fzf"              # fzf-lua's fuzzy-finder backend — the `fzf` binary it shells
                        # out to. Without it fzf-lua pickers fail to open.
brew "ripgrep"          # fzf-lua live grep (rg).
brew "fd"               # fzf-lua file finder.

# --- linters / formatters (efm-langserver shells out to these) ---
# Brew-native tools live here (no language version manager of their own). The Python
# efm tools are installed with `uv tool install` (uv is below); the npm/go ones live
# in Mason / their own ecosystems — see README "Linters & formatters".
brew "uv"              # fast Rust installer for Python CLIs (`uv tool install black …`)
brew "shellcheck"      # sh / bash linter      (efm: sh)
brew "shfmt"           # sh / bash formatter   (efm: sh)
brew "hadolint"        # Dockerfile linter     (efm: docker)
brew "clang-format"    # c / c++ formatter     (efm: c, cpp)

# --- fonts ---
cask "font-jetbrains-mono-nerd-font"   # ghostty `font-family = JetBrainsMono Nerd Font`

# NOT managed by brew on purpose — use your own version manager (see README):
#   node   -> nvm (JS-based LSP servers need `node` on PATH)
#   rust   -> rustup.rs installer (rustaceanvim + codelldb; provides rust-analyzer)
#   C compiler -> Xcode Command Line Tools on macOS:  xcode-select --install
