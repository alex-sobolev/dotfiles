# dotfiles

My personal dotfiles — configs for Neovim, Helix, and Ghostty.

This is a normal git repo: the config files live **right here** in the repo,
and are symlinked into `~/.config/` so each app finds them.

```
~/dev/dotfiles/
├── nvim/        ->  ~/.config/nvim
├── helix/       ->  ~/.config/helix
├── ghostty/     ->  ~/.config/ghostty
├── install.sh        (creates those symlinks; takes app names as args)
├── Brewfile          (aggregator: installs all of the below)
├── Brewfile.nvim     (nvim-only brew deps)
├── Brewfile.helix    (helix-only brew deps)
├── Brewfile.ghostty  (ghostty-only brew deps: the font)
├── .gitignore
├── README.md
├── nvim.md      (Neovim-specific docs: system deps, Mason packages, efm tools)
└── helix.md     (Helix-specific docs: language servers, eslint auto-fix setup)
```

## What's in here

| Tool        | Folder     | Notes                                              |
| ----------- | ---------- | -------------------------------------------------- |
| **Neovim**  | `nvim/`    | `lazy.nvim`; plugin versions pinned in `lazy-lock.json` — details in [nvim.md](nvim.md) |
| **Helix**   | `helix/`   | `config.toml`, `languages.toml`, custom `themes/` — details in [helix.md](helix.md) |
| **Ghostty** | `ghostty/` | terminal config (`config`)                         |

## Setup on a new machine

```sh
git clone git@github.com:alex-sobolev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
brew bundle         # installs ALL system deps (see "System dependencies" below)
./install.sh        # symlinks each folder into ~/.config (backs up anything already there)
```

Only want one tool? Each app has its own Brewfile, and `install.sh` takes app
names as arguments:

```sh
brew bundle --file Brewfile.nvim  && ./install.sh nvim      # just Neovim
brew bundle --file Brewfile.helix && ./install.sh helix     # just Helix
brew bundle --file Brewfile.ghostty && ./install.sh ghostty # just Ghostty (font)
```

## System dependencies

- **brew tools** — leaf CLI binaries the configs shell out to (`tree-sitter-cli`,
  `fzf`, `ripgrep`, `fd`, linters/formatters, …). They're split per tool:
  `Brewfile.nvim` (most of them), `Brewfile.helix`, `Brewfile.ghostty` — the root
  `Brewfile` just includes all three, so plain `brew bundle` still installs everything.
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

The font it uses (`JetBrainsMono Nerd Font`) **is** in `Brewfile.ghostty`
(`cask "font-jetbrains-mono-nerd-font"`), so `brew bundle` installs it for you.

## Neovim

All nvim-specific docs live in **[nvim.md](nvim.md)**:

- system dependencies (brew tools, node/rust via version managers),
- the `:MasonInstall` package set for the configured LSP servers,
- the efm linter/formatter tools and where each comes from,
- the eslint LSP setup (local eslint resolution + `--fix` on save).

## Helix

All Helix-specific docs live in **[helix.md](helix.md)**:

- the language servers it expects on `PATH` and how to install them (`npm i -g …`),
- the eslint setup (per-project eslint resolution + auto-fix on save).

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

## License

[MIT](LICENSE) — free to use, copy, and adapt.
