-- Configuración de Snacks.nvim
local snacks = require("snacks")

-- Configurar snacks
snacks.setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false }, -- Desactivado porque depende de lazy.nvim
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = {
		enabled = true,
		layout = "ivy", -- Estilo ivy para el picker
	},
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			-- wo = { wrap = true } -- Wrap notifications
		},
	},
})

-- Keymaps para snacks
local opts = { noremap = true, silent = true }

-- Top Pickers & Explorer
vim.keymap.set("n", "<leader>ff", function()
	snacks.picker.smart()
end, vim.tbl_extend("force", opts, { desc = "Smart Find Files" }))
vim.keymap.set("n", "<leader>/", function()
	snacks.picker.grep()
end, vim.tbl_extend("force", opts, { desc = "Grep" }))
-- vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, vim.tbl_extend("force", opts, { desc = "File Explorer" }))

-- Find
vim.keymap.set("n", "<leader><space>", function()
	snacks.picker.files()
end, vim.tbl_extend("force", opts, { desc = "Find Files" }))
vim.keymap.set("n", "<leader>fp", function()
	snacks.picker.projects()
end, vim.tbl_extend("force", opts, { desc = "Projects" }))

-- LSP
vim.keymap.set("n", "gd", function()
	snacks.picker.lsp_definitions()
end, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
vim.keymap.set("n", "gD", function()
	snacks.picker.lsp_declarations()
end, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
vim.keymap.set("n", "gr", function()
	snacks.picker.lsp_references()
end, vim.tbl_extend("force", opts, { desc = "References", nowait = true }))
vim.keymap.set("n", "gI", function()
	snacks.picker.lsp_implementations()
end, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
vim.keymap.set("n", "gy", function()
	snacks.picker.lsp_type_definitions()
end, vim.tbl_extend("force", opts, { desc = "Goto T[y]pe Definition" }))
vim.keymap.set("n", "gai", function()
	snacks.picker.lsp_incoming_calls()
end, vim.tbl_extend("force", opts, { desc = "C[a]lls Incoming" }))
vim.keymap.set("n", "gao", function()
	snacks.picker.lsp_outgoing_calls()
end, vim.tbl_extend("force", opts, { desc = "C[a]lls Outgoing" }))
vim.keymap.set("n", "<leader>ss", function()
	snacks.picker.lsp_symbols()
end, vim.tbl_extend("force", opts, { desc = "LSP Symbols" }))
vim.keymap.set("n", "<leader>sS", function()
	snacks.picker.lsp_workspace_symbols()
end, vim.tbl_extend("force", opts, { desc = "LSP Workspace Symbols" }))

-- Other
vim.keymap.set("n", "<leader>z", function()
	snacks.zen()
end, vim.tbl_extend("force", opts, { desc = "Toggle Zen Mode" }))
vim.keymap.set("n", "<leader>lg", function()
	snacks.lazygit()
end, vim.tbl_extend("force", opts, { desc = "Lazygit" }))

-- Setup globals and autocmds
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Setup some globals for debugging
		_G.dd = function(...)
			snacks.debug.inspect(...)
		end
		_G.bt = function()
			snacks.debug.backtrace()
		end

		-- Override print to use snacks for `:=` command
		if vim.fn.has("nvim-0.11") == 1 then
			vim._print = function(_, ...)
				dd(...)
			end
		else
			vim.print = _G.dd
		end

		-- Create some toggle mappings
		snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
		snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
		snacks.toggle.diagnostics():map("<leader>ud")
		snacks.toggle.line_number():map("<leader>ul")
		snacks.toggle
			.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
			:map("<leader>uc")
		snacks.toggle.treesitter():map("<leader>uT")
		snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
		snacks.toggle.inlay_hints():map("<leader>uh")
		snacks.toggle.indent():map("<leader>ug")
		snacks.toggle.dim():map("<leader>uD")
	end,
})

-- Code actions replacement (since tiny-code-action was removed)
vim.keymap.set(
	{ "n", "x" },
	"<leader>ca",
	vim.lsp.buf.code_action,
	vim.tbl_extend("force", opts, { desc = "Code Actions" })
)
