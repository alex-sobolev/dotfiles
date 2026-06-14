-- ================================================================================================
-- TITLE : tombi (TOML Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/tombi-toml/tombi
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('tombi', {
		capabilities = capabilities,
		filetypes = { "toml" },
	})
end
