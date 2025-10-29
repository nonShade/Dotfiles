require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
	keymap = {
		preset = "default",
		["<M-j>"] = { "select_next", "fallback" },
		["<M-k>"] = { "select_prev", "fallback" },
		["<M-l>"] = { "accept", "fallback" },
	},
})
