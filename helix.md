# Helix setup

Everything Helix-specific lives here: the language servers `languages.toml` expects
on `PATH`, how to install them, and how the eslint auto-fix-on-save setup works.
For the general repo layout and install steps, see the main [README](README.md).

## Dependencies

Unlike nvim (where Mason installs servers into its own data dir), Helix has **no
package manager** — it just looks for the server binaries on `PATH`. So the
JS/TS-related servers must be installed globally with npm.

### Via brew

Helix itself is in `Brewfile.helix` (the root `Brewfile` aggregates all the
per-tool Brewfiles if you want everything):

```sh
brew bundle --file ~/dev/dotfiles/Brewfile.helix
```

### Language servers (global npm installs)

You need Node on `PATH` first (installed via `nvm`, see the README). Then:

```sh
npm i -g typescript typescript-language-server vscode-langservers-extracted
```

| Package                       | Provides                                                | Used for                |
| ----------------------------- | ------------------------------------------------------- | ----------------------- |
| `typescript-language-server`  | `typescript-language-server`                            | js / ts / jsx / tsx     |
| `typescript`                  | `tsserver` (required by typescript-language-server)     | js / ts / jsx / tsx     |
| `vscode-langservers-extracted`| `vscode-eslint-language-server`, `vscode-json-language-server` (+ html/css servers) | eslint (lint + fix), json |

| Server (other languages)      | Source                                                  | Used for                |
| ----------------------------- | ------------------------------------------------------- | ----------------------- |
| `rust-analyzer`               | `rustup component add rust-analyzer` (see README)       | rust                    |

> **nvm gotcha:** a global `npm i -g` lives under the *active* Node version
> (`~/.nvm/versions/node/vX.Y.Z/bin`). If you switch the default Node version with
> nvm, the binaries vanish from `PATH` — re-run the `npm i -g …` line above under
> the new version.

Verify everything is found:

```sh
hx --health javascript
hx --health typescript
hx --health json
```

Each should show ✓ for its server binaries.

## ESLint: per-project resolution + auto-fix on save

Configured in [`helix/languages.toml`](helix/languages.toml). Same engine as
VSCode and our nvim setup (`vscode-eslint-language-server`):

- **Per-project eslint** — the server resolves each project's *local* `eslint` and
  flat config from `node_modules` automatically, so it's monorepo/pnpm friendly.
  Nothing eslint-related needs to be installed globally beyond the server itself.
- **Auto-fix on save** — Helix has no "code actions on save", so we use a trick:
  the eslint server is configured with `format = true`, which makes LSP *formatting*
  run `eslint --fix`. The other servers (`typescript-language-server`,
  `vscode-json-language-server`) have the `format` feature excluded, and
  `auto-format = true` on each language then runs eslint's fix on every `:w`.

## Theme

A custom `kanagawa-noitalic` theme lives in `helix/themes/` and is picked up
automatically once `./install.sh` symlinks `helix/` into `~/.config/helix`.
