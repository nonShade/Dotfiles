require("tiny-code-action").setup({
	picker = {
		"telescope",
		opts = {},
	},
	backend = "vim", -- o "delta" si lo tienes instalado
	backend_opts = {
		vim = {},
	},
	resolve_timeout = 150,
	signs = {
		quickfix = { "🔧", { link = "DiagnosticWarning" } },
		others = { "⚡", { link = "DiagnosticHint" } },
		refactor = { "🔄", { link = "DiagnosticInfo" } },
		["refactor.move"] = { "📦", { link = "DiagnosticInfo" } },
		["refactor.extract"] = { "✂️", { link = "DiagnosticError" } },
		["source.organizeImports"] = { "📚", { link = "DiagnosticWarning" } },
		["source.fixAll"] = { "🧹", { link = "DiagnosticError" } },
		["source"] = { "⚙️", { link = "DiagnosticError" } },
		["rename"] = { "📝", { link = "DiagnosticWarning" } },
		["codeAction"] = { "💡", { link = "DiagnosticWarning" } },
	},
})
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
