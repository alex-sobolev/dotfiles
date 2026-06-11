-- ================================================================================================
-- TITLE : yamlls (YAML Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/redhat-developer/yaml-language-server
-- SCHEMAS:
--   > SchemaStore (composer, docker-compose, …): https://www.schemastore.org/json/
--   > OpenAPI 3.1: https://spec.openapis.org/oas/3.1/schema
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('yamlls', {
		capabilities = capabilities,
		settings = {
			yaml = {
				schemas = {
					["https://json.schemastore.org/composer.json"] = "composer.json",
					["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
					-- OpenAPI 3.1 — matches common spec file naming conventions
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = {
						"openapi.yaml",
						"openapi.yml",
						"**/openapi/*.yaml",
						"**/openapi/*.yml",
						"**/api-spec*.yaml",
						"**/api-spec*.yml",
					},
				},
				validate = true,
				format = {
					enable = true,
				},
			},
		},
		filetypes = { "yaml" },
	})
end
