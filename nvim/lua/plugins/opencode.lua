---@type opencode.Opts
vim.g.opencode_opts = {
	-- Tu configuración aquí - ver `lua/opencode/config.lua` para opciones
}

-- Requerido para `opts.auto_reload`
vim.o.autoread = true

-- Keymaps recomendados
vim.keymap.set({ "n", "x" }, "<leader>aa", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "ga", function()
	require("opencode").prompt("@this")
end, { desc = "Add to opencode" })

vim.keymap.set("n", "<leader>.", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })
