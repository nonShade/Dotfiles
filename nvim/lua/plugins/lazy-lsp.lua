return {
  "dundalek/lazy-lsp.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
      })

      local opts = { buffer = bufnr }
      -- Aquí defines tu keymap de formateo:
      vim.keymap.set({ 'n', 'x' }, 'cf', function()
        vim.lsp.buf.format({ async = true, timeout_ms = 10000 })
      end, opts)
    end)

    require("lazy-lsp").setup {
      preferred_servers = {
        lua = { "lua_ls" },
      },
      configs = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
            },
          },
        },
      },
      prefer_local = true, -- Prefer locally installed servers over nix-shell (default: true)
    }
  end,
}
