local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.gopls")(capabilities)
require("servers.jsonls")(capabilities)
require("servers.ts_ls")(capabilities)
require("servers.eslint")(capabilities)
require("servers.bashls")(capabilities)
require("servers.clangd")(capabilities)
require("servers.docker_language_server")(capabilities)
require("servers.emmet_language_server")(capabilities)
require("servers.yamlls")(capabilities)
require("servers.tailwindcss")(capabilities)
require("servers.taplo")(capabilities)

-- Linters & Formatters
require("servers.efm-langserver")(capabilities)

vim.lsp.enable({
  'lua_ls',
  'pyright',
  'gopls',
  'jsonls',
  'ts_ls',
  'eslint',
  'bashls',
  'clangd',
  'docker_language_server',
  'emmet_language_server',
  'yamlls',
  'tailwindcss',
  'taplo',
  'efm',
})

