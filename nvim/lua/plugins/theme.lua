-- ================================================================================================
-- TITLE : Colorschemes
-- ABOUT :
--   To switch the active theme, enable the config() block on the desired spec and disable the
--   other(s). Only ONE spec may call vim.cmd.colorscheme() at a time, otherwise load order
--   decides the winner and the result is non-deterministic.
-- ================================================================================================

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 999,
		opts = {},
		-- config = function(_, opts)
		-- 	require("tokyonight").setup(opts)
		-- 	vim.cmd.colorscheme("tokyonight-storm")
		-- end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 999,
		opts = {
			theme = "wave",
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			background = {
				dark = "wave",
				light = "lotus",
			},
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin", -- repo is catppuccin/nvim; rename so it doesn't collide as "nvim"
		lazy = false,
		priority = 999,
		opts = {
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			term_colors = true,
			no_italic = true, -- force-disable all italics
		},
		-- config = function(_, opts)
		-- 	require("catppuccin").setup(opts)
		-- 	vim.cmd.colorscheme("catppuccin")
		-- end,
	},
	{
		"nickkadutskyi/jb.nvim", -- JetBrains-like theme
		lazy = false,
		priority = 999,
		opts = {
			-- jb inverts the flag: true = DISABLE that attribute everywhere
			disable_hl_args = {
				italic = true, -- disable all italics
			},
		},
		-- config = function(_, opts)
		-- 	require("jb").setup(opts)
		-- 	vim.cmd.colorscheme("jb")
		-- end,
	},
}
