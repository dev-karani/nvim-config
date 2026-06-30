-- ============================================================
--  Colorscheme — gruvbox (dark)
--  Warm browns/oranges/yellows — no blue/purple cast.
--  Switched from catppuccin mocha per request: dark, not blueish.
-- ============================================================
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",  -- "soft" | "medium" | "hard" — hard = darkest background
      transparent_mode = false,
      italic = {
        strings  = false,  -- italics on strings can be hard to read in terminals
        comments = true,
        operators = false,
        folds = true,
      },
    })
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
