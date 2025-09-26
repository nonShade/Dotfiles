return {
  {
    "echasnovski/mini.nvim",
    version = false,

    config = function()
      require("mini.align").setup()
      require("mini.comment").setup()
      require("mini.trailspace").setup()
      require("mini.hipatterns").setup()
      require("mini.icons").setup()
      require("mini.misc").setup()
      MiniIcons.tweak_lsp_kind()
    end,
  },
}
