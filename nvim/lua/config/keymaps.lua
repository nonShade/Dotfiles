local keymap = vim.keymap

keymap.set("n", "x", '"_x')

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", [["+Y]], { desc = "Yank to system clipboard" })

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

vim.keymap.set("n", "<M-i>", "gg", { noremap = true, silent = true })
vim.keymap.set("n", "<M-o>", "VG", { noremap = true, silent = true })

keymap.set("n", "<C-a>", ":%yank<CR>", { noremap = true, silent = true })

-- File operations
keymap.set("n", "<Leader>w", ":update<Return>", { desc = "Save file" })
keymap.set("n", "<Leader>q", ":quit<Return>", { desc = "Quit" })
keymap.set("n", "<Leader>Q", ":qa<Return>", { desc = "Quit all" })

-- Split operations (organized under 's' group)
keymap.set("n", "ss", ":split<Return>", { desc = "Split horizontal" })
keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split vertical" })

vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight" })

-- Window navigation
keymap.set("n", "sh", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "sk", "<C-w>k", { desc = "Move to upper window" })
keymap.set("n", "sj", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- Window resize
keymap.set("n", "<C-S-h>", "<C-w><", { desc = "Decrease width" })
keymap.set("n", "<C-S-l>", "<C-w>>", { desc = "Increase width" })
keymap.set("n", "<C-S-k>", "<C-w>+", { desc = "Increase height" })
keymap.set("n", "<C-S-j>", "<C-w>-", { desc = "Decrease height" })

-- Buffer operations
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", '<Esc>:%bdelete|edit #|normal`"<Return>', { desc = "Delete other buffers" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Store.nvim (Plugin Manager)
keymap.set("n", "<leader>ps", ":Store<CR>", { desc = "Open Plugin Store" })
