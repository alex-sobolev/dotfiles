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
./install.sh        # symlinks each folder into ~/.config (backs up anything already there)
```

## LSPs / tools (install once per machine)

Mason packages aren't part of the repo (they live in nvim's data dir), so install
them in nvim after cloning. Open nvim and run:

```vim
:MasonInstall lua-language-server pyright gopls json-lsp typescript-language-server bash-language-server clangd docker-language-server emmet-language-server yaml-language-server tailwindcss-language-server taplo efm luacheck stylua codelldb
```

This is the Mason package set for the servers enabled in `nvim/lua/servers/init.lua`,
plus `codelldb` (Rust DAP) and the Mason-managed efm tools (`luacheck`, `stylua`).
Other efm linters/formatters (black, prettier_d, eslint_d, …) come from your system
package manager (brew/npm/pip).

> Keep this list in sync whenever you add or remove a server in `servers/init.lua`.

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
