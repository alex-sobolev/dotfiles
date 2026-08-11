# dotfiles

My personal dotfiles — configs for Neovim, Helix, Zed, and Ghostty.

This is a normal git repo: the config files live **right here** in the repo,
and are symlinked into `~/.config/` so each app finds them.

```
~/dev/dotfiles/
├── nvim/        ->  ~/.config/nvim
├── helix/       ->  ~/.config/helix
├── ghostty/     ->  ~/.config/ghostty
├── zed/         ->  ~/.config/zed
├── install.sh        (creates those symlinks; takes app names as args)
├── Brewfile          (aggregator: installs all of the below)
├── Brewfile.nvim     (nvim-only brew deps)
├── Brewfile.helix    (helix-only brew deps)
├── Brewfile.ghostty  (ghostty-only brew deps: the font)
├── Brewfile.zed      (zed-only brew deps: the font)
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
| **Zed**     | `zed/`     | `settings.json`, `keymap.json`; editor extensions auto-install via `auto_install_extensions` |
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
brew bundle --file Brewfile.zed   && ./install.sh zed       # just Zed (font)
```

## System dependencies

- **brew tools** — leaf CLI binaries the configs shell out to (`tree-sitter-cli`,
  `fzf`, `ripgrep`, `fd`, linters/formatters, …). They're split per tool:
  `Brewfile.nvim` (most of them), `Brewfile.helix`, `Brewfile.ghostty`,
  `Brewfile.zed` — the root `Brewfile` just includes all four, so plain
  `brew bundle` still installs everything.
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

### Editor: Zed (install it yourself)

Same deal as Ghostty — the app itself is left out of `brew bundle`:

```sh
brew install --cask zed            # via Homebrew
```

Or download it from <https://zed.dev/download>. The `zed/` config applies once
`./install.sh` has symlinked it into `~/.config/zed`.

Its font (`JetBrains Mono` — the plain one, *not* the Nerd Font variant Ghostty
uses) is in `Brewfile.zed`.

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

## Zed

Two tracked files, both JSONC (comments and trailing commas are fine):

- **`zed/settings.json`** — editor settings. JS/TS format-on-save runs Prettier
  then applies ESLint fixes, driven by each project's own `eslint.config.js` /
  `.prettierrc.json` (same arrangement as the nvim and Helix configs).
- **`zed/keymap.json`** — keybindings (`shift-enter` in the terminal, `ctrl-w`
  pane navigation in docks).

### Extensions

Zed extensions aren't brew packages — they're declared **in `settings.json`**
under `auto_install_extensions`, and Zed installs anything missing on launch. So
a fresh machine needs no extra step: clone, symlink, open Zed.

To add one, install it from the extensions UI (`cmd-shift-x`), then add its id to
that block so the next machine gets it too. Removing an entry does *not*
uninstall the extension — do that in the UI.

The active theme (`Kanagawa Wave - No Italics`) and icon theme
(`Material Icon Theme`) both come from extensions listed there, so don't drop
`kanagawa-themes` / `material-icon-theme` without changing `theme` / `icon_theme`
to match.

### What's not tracked

`~/.config/zed/prompts/` (the prompt-library database) is gitignored — it's a
per-machine binary store, not config. Everything else Zed writes at runtime
(extensions, language servers, session db) lives outside the config dir in
`~/Library/Application Support/Zed/`, so it never touches this repo.

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
let the machine layer its own changes on top.

The usual trick is an **untracked** local file the app loads if present — but
that only works where the config format can express "load this, and carry on if
it's missing". Two of these four can:

- **Ghostty** — `config-file = ?local` (already in `ghostty/config`); just create
  an untracked `~/.config/ghostty/local`. The `?` makes it optional, and it's
  loaded last, so it wins.
- **Neovim** — `pcall(require, "local")` at the end of `init.lua` loads an
  untracked `nvim/lua/local.lua`; `pcall` swallows the error when it's absent.
  See [nvim.md](nvim.md#per-machine-overrides).

The other two have no include directive, so a gitignored `local` file would
simply never be read:

- **Helix** — nothing available; `config.toml` is plain TOML with no include.
- **Zed** — `settings.json` can't include a file either, but it does have
  **settings profiles**: named override bundles that live in the shared config
  and are switched on per machine via `settings profile selector: toggle`.

  ```json
  "settings_profiles": {
    "big-display": { "buffer_font_size": 18, "ui_font_size": 17 }
  }
  ```

  Both machines keep identical tracked config and `git status` stays clean.
  Zed describes profiles as *temporarily* applied, so confirm the toggle
  survives a restart before relying on it for something permanent.

For Helix, or for Zed if profiles don't stick, the fallback is an uncommitted
local edit — change the value and skip that hunk with `git add -p`. It works,
but the file stays permanently dirty on that machine and `git pull` will refuse
to merge upstream changes to it until you stash, so prefer a profile where one
will do.

## License

[MIT](LICENSE) — free to use, copy, and adapt.
