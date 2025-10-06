-- Lazy load copilot on InsertEnter event
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				debounce = 100,
				keymap = {
					accept = "<Tab>",
				},
			},
		})
		
		-- Remove the autocmd after first execution
		return true
	end,
	once = true,
})
