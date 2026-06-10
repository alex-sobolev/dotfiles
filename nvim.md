# Neovim setup

Everything nvim-specific lives here: the system binaries the config shells out to,
the Mason package set, and the efm linter/formatter tools. For the general repo
layout and install steps, see the main [README](README.md).

## System dependencies (the easy-to-miss part)

These are binaries the config shells out to at runtime/build time. They are **not**
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
# Node — needed on PATH for JS-based LSP servers (ts_ls, eslint, bashls, jsonls,
# yamlls, tailwindcss, emmet, dockerls). Install via nvm (https://github.com/nvm-sh/nvm):
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

## LSPs / tools (install once per machine)

Mason packages aren't part of the repo (they live in nvim's data dir), so install
them in nvim after cloning. Open nvim and run:

```vim
:MasonInstall lua-language-server pyright gopls json-lsp typescript-language-server eslint-lsp bash-language-server clangd docker-language-server emmet-language-server yaml-language-server tailwindcss-language-server taplo efm luacheck stylua prettierd fixjson codelldb
```

This is the Mason package set for the servers enabled in `nvim/lua/servers/init.lua`
(`eslint-lsp` provides the `eslint` server — see the note below), plus `codelldb`
(Rust DAP) and the Mason-managed efm tools (`luacheck`, `stylua`, `prettierd`,
`fixjson`). The remaining efm linters/formatters are **not** Mason-managed — see the
next section.

> Keep this list in sync whenever you add or remove a server in `servers/init.lua`.

### Linters & formatters (efm-langserver)

`efm-langserver` (configured in `nvim/lua/servers/efm-langserver.lua`) shells out to
external linter/formatter binaries per filetype. They aren't bundled — each comes
from the source below. Format/lint for a language silently does nothing until its
tool is on `PATH`. Install only the ones for languages you actually use.

> **ESLint is no longer an efm tool.** Linting + `eslint --fix` now run through the
> dedicated **eslint LSP** (`vscode-eslint-language-server`, Mason package `eslint-lsp`,
> configured in `nvim/lua/servers/eslint.lua`) — the same engine VSCode/JetBrains use.
> It resolves each package's _local_ eslint + flat config automatically (pnpm-monorepo
> friendly), unlike the global `eslint_d` daemon which mis-resolved plugins in monorepos.
> On save, `:LspEslintFixAll` runs first (synchronous), then efm runs Prettier/fixjson —
> so fixes land before formatting. The server only attaches when an eslint config file
> **and** a lockfile exist up the tree, so it stays dormant in non-eslint projects.
> Filetypes are the lspconfig defaults (js/ts/`*react`/vue/svelte/astro/htmlangular) plus
> `json`/`jsonc`, so JSON-targeting eslint rules lint and `--fix` too.

| Tool           | Filetype(s)            | Source | Install                                      |
| -------------- | ---------------------- | ------ | -------------------------------------------- |
| `luacheck`     | lua                    | Mason  | in the `:MasonInstall` line above            |
| `stylua`       | lua                    | Mason  | in the `:MasonInstall` line above            |
| `shellcheck`   | sh                     | brew   | `brew bundle` (in Brewfile)                  |
| `shfmt`        | sh                     | brew   | `brew bundle` (in Brewfile)                  |
| `hadolint`     | docker                 | brew   | `brew bundle` (in Brewfile)                  |
| `clang-format` | c, cpp                 | brew   | `brew bundle` (in Brewfile)                  |
| `cpplint`      | c, cpp                 | uv     | `uv tool install cpplint`                    |
| `ruff`         | python (lint + format) | uv     | `uv tool install ruff` — one binary, replaces flake8 + black |
| `prettier_d`   | css/html/json/md/js/ts/svelte/vue | Mason | in the `:MasonInstall` line above        |
| `fixjson`      | json                   | Mason  | in the `:MasonInstall` line above            |
| `gofumpt`      | go                     | go     | `go install mvdan.cc/gofumpt@latest`         |
| `go_revive`    | go                     | go     | `go install github.com/mgechev/revive@latest` |

> The brew tools are in the Brewfile. The web tools (`prettierd`/`fixjson`, plus the
> `eslint-lsp` server) go through **Mason** so they survive `nvm` Node-version switches — a global
> `npm i -g` lives under the active Node version and vanishes the moment you install a
> newer one (they still need *some* Node on `PATH` at runtime). The Python tools use
> **`uv tool install`** (`uv` is in the Brewfile) — isolated per-tool, on `PATH`, fast.
> `ruff` (Astral, Rust) is a single binary that replaces both flake8 (lint) and black
> (format); `ruff_sort` is also available if you want import sorting. The go tools need
> a Go toolchain on `PATH` (`brew install go` or the official installer), which `gopls`
> requires anyway.
>
> `uv tool` shims land in `~/.local/bin` — make sure it's on your `PATH` (run
> `uv tool update-shell` once) or efm won't find `ruff`/`cpplint`.

## Per-machine overrides

For settings that should differ between machines, keep the shared value in the repo
and `pcall(require, "local")` at the end of init, with an untracked
`nvim/lua/local.lua`.
