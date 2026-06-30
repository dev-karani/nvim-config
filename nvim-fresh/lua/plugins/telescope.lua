-- ============================================================
--  Telescope — fuzzy finder
--  Requires: ripgrep
-- ============================================================
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond  = function() return vim.fn.executable("make") == 1 end,
    },
  },
  cmd  = "Telescope",
  keys = {
    { "<leader>ff" }, { "<leader>fg" }, { "<leader>fb" }, { "<leader>fh" }, { "<leader>fs" },
  },
  config = function()
    local telescope = require("telescope")
    local actions    = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
        file_ignore_patterns = { "%.git/", "vendor/", "node_modules/", "%.venv/", "__pycache__/" },
        layout_config = { horizontal = { preview_width = 0.55 } },
      },
      pickers = {
        find_files = { hidden = true, follow = true },
        live_grep  = { additional_args = function() return { "--hidden" } end },
      },
    })

    pcall(telescope.load_extension, "fzf")
  end,
}
