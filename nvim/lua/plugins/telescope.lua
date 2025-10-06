local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
  },
})

-- Find/Search group keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

-- Quick access (legacy support)
vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" })
