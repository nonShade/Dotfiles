return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 300,
      icons = {
        mappings = true,
        keys = {
          Up = "󰁝 ",
          Down = "󰁅 ",
          Left = "󰁍 ",
          Right = "󰁔 ",
          C = "󰘴 ",
          M = "󰘵 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
        },
      },
    })

    -- Register group names
    wk.add({
      { "<leader>f", group = "󰍉 Find/Search" },
      { "<leader>c", group = "󰠭 Code" },
      { "<leader>b", group = "󰓩 Buffer" },
      { "<leader>g", group = "󰊢 Git" },
      { "<leader>o", group = "󱂈 Opencode" },
      { "<leader>t", group = "󰙅 Terminal/Toggle" },
      { "<leader>w", group = "󰖲 Window" },
      { "<leader>s", group = "󰒺 Split/Search" },
      { "<leader>r", group = "󰑕 Replace/Refactor" },
      { "<leader>d", group = "󰃤 Debug/Diagnostics" },
      { "<leader>h", group = "󰛵 Help" },
      { "<leader>x", group = "󰅚 Trouble" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
