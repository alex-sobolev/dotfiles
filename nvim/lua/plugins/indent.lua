-- ================================================================================================
-- TITLE : indent-blankline (ibl)
-- LINKS :
--   > github : https://github.com/lukas-reineke/indent-blankline.nvim
-- ABOUT : Static indentation guides on every level. `scope` is disabled so guides do NOT follow
--         or highlight the block under the cursor.
-- ================================================================================================

return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			scope = { enabled = false },
			indent = { char = "▏" }, -- thinnest vertical bar (U+258F)
		},
	},
}
