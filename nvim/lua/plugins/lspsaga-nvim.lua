return {
	"glepnir/lspsaga.nvim",
	lazy = false,
	config = function()
		require("lspsaga").setup({
			-- code-action lightbulb: keep the sign-column indicator, drop the
			-- redundant end-of-line virtual-text copy
			lightbulb = { virtual_text = false },
			-- keybinds for navigation in lspsaga window
			move_in_saga = { prev = "<C-k>", next = "<C-j>" },
			-- use enter to open file with finder
			finder_action_keys = {
				open = "<CR>",
			},
			-- use enter to open file with definition preview
			definition_action_keys = {
				edit = "<CR>",
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
