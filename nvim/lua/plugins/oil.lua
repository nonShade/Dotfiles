require("mini.icons").setup()
require("oil").setup({
	default_file_explorer = true,
	columns = { "icon" },
	keymaps = {
		["<C-h>"] = false,
		["<C-c>"] = false,
		["<M-h>"] = "actions.select_split",
		["q"] = "actions.close",
	},
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
	},
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
