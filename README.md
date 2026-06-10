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
├── README.md
└── nvim.md      (Neovim-specific docs: system deps, Mason packages, efm tools)
```

## What's in here

| Tool        | Folder     | Notes                                              |
| ----------- | ---------- | -------------------------------------------------- |
| **Neovim**  | `nvim/`    | `lazy.nvim`; plugin versions pinned in `lazy-lock.json` — details in [nvim.md](nvim.md) |
| **Helix**   | `helix/`   | `config.toml`, `languages.toml`, custom `themes/`  |
| **Ghostty** | `ghostty/` | terminal config (`config`)                         |

## Setup on a new machine

```sh
git clone git@github.com:alex-sobolev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
brew bundle         # installs system deps (see "System dependencies" below)
./install.sh        # symlinks each folder into ~/.config (backs up anything already there)
```

## System dependencies

- **brew tools** — leaf CLI binaries the configs shell out to (`tree-sitter-cli`,
  `fzf`, `ripgrep`, `fd`, linters/formatters, …): `brew bundle` installs everything
  in the `Brewfile`.
- **node / rust** — deliberately **not** in the Brewfile; install via your own
  version manager (`nvm`, `rustup`).

The full per-tool breakdown (what needs which binary and why) is nvim-specific —
see **[nvim.md](nvim.md)**.

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

## Neovim

All nvim-specific docs live in **[nvim.md](nvim.md)**:

- system dependencies (brew tools, node/rust via version managers),
- the `:MasonInstall` package set for the configured LSP servers,
- the efm linter/formatter tools and where each comes from,
- the eslint LSP setup (local eslint resolution + `--fix` on save).

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
- **Neovim** — see [nvim.md](nvim.md#per-machine-overrides).
