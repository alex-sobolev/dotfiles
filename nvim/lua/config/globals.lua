-- ================================================================================================
-- TITLE : globals
-- ABOUT : you may have different global & local leaders
-- ================================================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Neovim bundles a copy of rust.vim, whose :RustFmt defaults to the long-removed
-- `--write-mode` flag unless version detection is enabled. Force the modern
-- `--emit=files` path so :RustFmt works with current rustfmt (rust-analyzer still
-- handles format-on-save independently).
vim.g.rustfmt_emit_files = 1

