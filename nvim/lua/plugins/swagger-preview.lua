-- ================================================================================================
-- TITLE : swagger-preview
-- ABOUT : Live-reloading Swagger UI preview for OpenAPI/Swagger specs in the browser
-- LINKS :
--   > github : https://github.com/vinnymeller/swagger-preview.nvim
-- DEPENDENCIES/INTEGRATIONS:
--   > swagger-ui-watcher (installed by the build step via npm)
-- ================================================================================================

return {
	"vinnymeller/swagger-preview.nvim",
	cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
	build = "npm i",

	opts = {
		port = 8000,
		host = "localhost",
	},
}
