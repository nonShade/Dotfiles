return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-c>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
      },
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    })

    -- File explorer keymaps
    vim.keymap.set("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "File explorer (Oil)" })
    -- vim.keymap.set("n", "<leader>fE", require("oil").toggle_float, { desc = "File explorer (float)" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
