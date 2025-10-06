vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- 🔑 evita advertencias molestas
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
