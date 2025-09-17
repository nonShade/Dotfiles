return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
			},
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
		})

    -- Code formatting keymaps
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 500 })
    end, { desc = "Format code" })
	end,
}
