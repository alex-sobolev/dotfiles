# dotfiles

My personal dotfiles — configs for Neovim, Helix, and Ghostty.

This is a normal git repo: the config files live **right here** in the repo,
and are symlinked into `~/.config/` so each app finds them.

```
~/dev/dotfiles/
├── nvim/        ->  ~/.config/nvim
├── helix/       ->  ~/.config/helix
├── ghostty/     ->  ~/.config/ghostty
├── install.sh   (creates those symlinks)
├── .gitignore
└── README.md
```

## What's in here

| Tool        | Folder     | Notes                                              |
| ----------- | ---------- | -------------------------------------------------- |
| **Neovim**  | `nvim/`    | `lazy.nvim`; plugin versions pinned in `lazy-lock.json` |
| **Helix**   | `helix/`   | `config.toml`, `languages.toml`, custom `themes/`  |
| **Ghostty** | `ghostty/` | terminal config (`config`)                         |

## Setup on a new machine

```sh
git clone git@github.com:alex-sobolev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
brew bundle         # installs system deps (see "System dependencies" below)
./install.sh        # symlinks each folder into ~/.config (backs up anything already there)
```

## System dependencies (the easy-to-miss part)

These are binaries the configs shell out to at runtime/build time. They are **not**
installed by cloning the repo and **not** managed by Mason/lazy, so a fresh machine
needs them or nvim breaks at startup (parsers won't compile, grep/file pickers fail,
`:checkhealth` complains).

### Via brew (leaf CLI tools — no version manager of their own)

```sh
brew bundle --file ~/dev/dotfiles/Brewfile
```

| Dependency      | Needed by                                                          |
| --------------- | ------------------------------------------------------------------ |
| `tree-sitter-cli` | **nvim-treesitter `main` branch** — parser install/`:TSUpdate` shells out to this CLI (hard requirement; the `tree-sitter` formula is the library only) |
| `luarocks`      | `lazy.nvim` luarocks support (flagged by `:checkhealth lazy`)       |
| `fzf`           | `fzf-lua` fuzzy-finder backend — the `fzf` binary it shells out to (pickers won't open without it) |
| `ripgrep`       | `fzf-lua` live grep                                                 |
| `fd`            | `fzf-lua` file finder                                               |
| `shellcheck`    | efm-langserver — shell (`sh`/`bash`) linter                         |
| `shfmt`         | efm-langserver — shell (`sh`/`bash`) formatter                      |
| `hadolint`      | efm-langserver — Dockerfile linter                                  |
| `clang-format`  | efm-langserver — C/C++ formatter                                    |

### Via your own version manager (deliberately NOT in the Brewfile)

`node` and `rust` are intentionally left out of `brew bundle` — installing them
through brew would shadow/conflict with the version managers most people (and this
machine) already use. Set them up however you prefer:

```sh
# Node — needed on PATH for JS-based LSP servers (ts_ls, bashls, jsonls, yamlls,
# tailwindcss, emmet, dockerls). Install via nvm (https://github.com/nvm-sh/nvm):
nvm install --lts && nvm use --lts

# Rust — for rustaceanvim + the codelldb DAP. Install via the official rustup
# installer (https://rustup.rs), NOT brew, then add the LSP component:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer        # the rust-analyzer rustaceanvim uses

# C compiler — for treesitter parser compilation (macOS):
xcode-select --install
```

> If you add a plugin that pulls in a new **leaf** system binary, add it to the
> `Brewfile` and the table above. If it needs a runtime that has its own version
> manager (node/rust/python/…), document it in *this* section instead — never
> pin those in the Brewfile.

### Terminal: Ghostty (install it yourself)

Ghostty is the terminal app these configs target, but it's deliberately left out
of `brew bundle` so you can install it however you prefer:

```sh
brew install --cask ghostty        # via Homebrew
```

Or grab a build directly from <https://ghostty.org/download> and install it like
any other macOS app. Either way, the `ghostty/` config in this repo applies once
`./install.sh` has symlinked it into `~/.config/ghostty`.

The font it uses (`JetBrainsMono Nerd Font`) **is** in the Brewfile
(`cask "font-jetbrains-mono-nerd-font"`), so `brew bundle` installs it for you.

## LSPs / tools (install once per machine)

Mason packages aren't part of the repo (they live in nvim's data dir), so install
them in nvim after cloning. Open nvim and run:

```vim
:MasonInstall lua-language-server pyright gopls json-lsp typescript-language-server bash-language-server clangd docker-language-server emmet-language-server yaml-language-server tailwindcss-language-server taplo efm luacheck stylua codelldb
```

This is the Mason package set for the servers enabled in `nvim/lua/servers/init.lua`,
plus `codelldb` (Rust DAP) and the Mason-managed efm tools (`luacheck`, `stylua`).
The remaining efm linters/formatters are **not** Mason-managed — see the next section.

> Keep this list in sync whenever you add or remove a server in `servers/init.lua`.

### Linters & formatters (efm-langserver)

`efm-langserver` (configured in `nvim/lua/servers/efm-langserver.lua`) shells out to
external linter/formatter binaries per filetype. They aren't bundled — each comes
from the source below. Format/lint for a language silently does nothing until its
tool is on `PATH`. Install only the ones for languages you actually use.

| Tool           | Filetype(s)            | Source | Install                                      |
| -------------- | ---------------------- | ------ | -------------------------------------------- |
| `luacheck`     | lua                    | Mason  | in the `:MasonInstall` line above            |
| `stylua`       | lua                    | Mason  | in the `:MasonInstall` line above            |
| `shellcheck`   | sh                     | brew   | `brew bundle` (in Brewfile)                  |
| `shfmt`        | sh                     | brew   | `brew bundle` (in Brewfile)                  |
| `hadolint`     | docker                 | brew   | `brew bundle` (in Brewfile)                  |
| `clang-format` | c, cpp                 | brew   | `brew bundle` (in Brewfile)                  |
| `cpplint`      | c, cpp                 | pip    | `pipx install cpplint`                       |
| `flake8`       | python                 | pip    | `pipx install flake8`                        |
| `black`        | python                 | pip    | `pipx install black`                         |
| `prettier_d`   | css/html/json/md/js/ts/svelte/vue | npm | `npm i -g @fsouza/prettierd`           |
| `eslint_d`     | js/ts/json/svelte/vue  | npm    | `npm i -g eslint_d`                          |
| `fixjson`      | json                   | npm    | `npm i -g fixjson`                           |
| `gofumpt`      | go                     | go     | `go install mvdan.cc/gofumpt@latest`         |
| `go_revive`    | go                     | go     | `go install github.com/mgechev/revive@latest` |

> The brew tools are in the Brewfile; the npm/pip/go ones stay in their own
> ecosystems on purpose (same reasoning as node/rust above — don't let brew shadow a
> version-managed toolchain). The go tools also need a Go toolchain on `PATH`
> (`brew install go` or the official installer), which `gopls` requires anyway.

## Daily use

It's just git — edit files in `~/dev/dotfiles` (or via `~/.config/…`, same files
through the symlinks), then:

```sh
cd ~/dev/dotfiles
git add -A
git commit -m "…"
git push
```

Pull changes on another machine with `git pull` — the symlinks mean the live
configs update automatically.

## Per-machine overrides

For settings that should differ between machines, keep the shared value here and
load an **untracked** local file each app reads if present:

- **Ghostty** — append `config-file = ?local` to `ghostty/config`, then create an
  untracked `~/.config/ghostty/local` (the `?` makes it optional; loaded last, so
  it wins).
- **Neovim** — `pcall(require, "local")` at the end of init, with an untracked
  `nvim/lua/local.lua`.
