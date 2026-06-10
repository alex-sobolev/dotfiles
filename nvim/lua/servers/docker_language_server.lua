-- ================================================================================================
-- TITLE : docker_language_server (Docker Language Server) LSP Setup
-- ABOUT : Docker's official LSP (binary: docker-language-server) — Mason package
--         `docker-language-server`. Replaces the older dockerls (docker-langserver).
-- LINKS :
--   > github: https://github.com/docker/docker-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('docker_language_server',{
		capabilities = capabilities,
		filetypes = { "dockerfile" },
	})
end
