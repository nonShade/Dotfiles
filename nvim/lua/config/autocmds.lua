local M = {}

function M.setup()
  -- Highlight yanking
  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Auto root directory
  local root_names = { ".git", "Makefile" }
  local root_cache = {}

  local set_root = function()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
      return
    end
    path = vim.fs.dirname(path)

    local root = root_cache[path]
    if root == nil then
      local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
      if root_file == nil then
        return
      end
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
    end

    vim.fn.chdir(root)
  end

  local root_augroup = vim.api.nvim_create_augroup("MyAutoRoot", {})
  vim.api.nvim_create_autocmd("BufEnter", { group = root_augroup, callback = set_root })

  -- LSP keymaps (organized)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local opts = { buffer = ev.buf }
      
      -- Navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
      
      -- Code actions
      vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type definition" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
      
      -- Diagnostics
      vim.keymap.set("n", "<leader>dd", function()
        vim.diagnostic.open_float({ border = "rounded" })
      end, { buffer = ev.buf, desc = "Show diagnostics" })
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Previous diagnostic" })
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = ev.buf, desc = "Diagnostics to loclist" })
    end,
  })
end

return M