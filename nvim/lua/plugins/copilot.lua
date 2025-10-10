-- Lazy load copilot on InsertEnter event
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				debounce = 100,
				keymap = {
					accept = "<Tab>",
					accept_word = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		})

		-- Ensure Tab is mapped to Copilot accept after setup
		vim.keymap.set("i", "<Tab>", function()
			if require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept()
			else
				return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
			end
		end, { expr = true, noremap = true, silent = true })

		-- Remove the autocmd after first execution
		return true
	end,
	once = true,
})
