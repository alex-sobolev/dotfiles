-- ================================================================================================
-- TITLE : eslint (vscode-eslint Language Server) LSP Setup
-- ABOUT : ESLint diagnostics + `eslint --fix` on save (:LspEslintFixAll). This is the same engine
--         VSCode/JetBrains use: it resolves each package's LOCAL eslint + flat config automatically
--         (pnpm-monorepo friendly), unlike the global `eslint_d` daemon which mis-resolves plugins
--         in monorepos. Formatting stays with Prettier/fixjson via efm — eslint only lints & fixes.
-- LINKS :
--   > github: https://github.com/Microsoft/vscode-eslint (server: vscode-eslint-language-server)
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp)
--- @return nil
return function(capabilities)
	vim.lsp.config("eslint", {
		capabilities = capabilities,
		-- Default JS/TS filetypes (from lspconfig) PLUS json/jsonc, so eslint rules that target
		-- JSON (e.g. eslint-plugin-i18n-json's sorted-keys) lint and `--fix` *.json as well.
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
			"astro",
			"htmlangular",
			"json",
			"jsonc",
		},
	})
end
