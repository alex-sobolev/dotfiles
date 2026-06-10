-- ================================================================================================
-- TITLE : emmet_language_server (Emmet Language Server) LSP Setup
-- ABOUT : Configures Emmet Language Server for web-related (e.g. TS/JS, CSS, Sass, Svelte, Vue).
--         Binary: emmet-language-server (olrtg) — Mason package `emmet-language-server`.
--         Replaces the older emmet_ls (emmet-ls).
-- LINKS :
--   > github: https://github.com/olrtg/emmet-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('emmet_language_server', {
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"css",
			"sass",
			"scss",
			"svelte",
			"vue",
		},
	})
end
