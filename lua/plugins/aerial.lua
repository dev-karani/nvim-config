-- ============================================================
--  Aerial — symbols outline sidebar
--  <leader>o → toggle
--
--  NOTE: per-symbol error-count badges were tested and found
--  unreliable across aerial versions — left off intentionally.
--  Use <leader>d / gutter signs / virtual text for diagnostics instead.
-- ============================================================
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter" },
      layout = {
        max_width = { 40, 0.2 },
        width     = 30,
        default_direction = "right",
      },
      attach_mode = "window",
      show_guides = true,
      icons = {
        Function = "ƒ",
        Method   = "m",
        Struct   = "s",
        Constant = "c",
        Variable = "v",
        Class    = "c",
      },
      filter_kind = false,
    })

    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Prev symbol" })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Next symbol" })
  end,
}
