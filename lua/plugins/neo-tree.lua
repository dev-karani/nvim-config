-- ============================================================
--  Neo-tree — persistent left sidebar (VSCode-style)
--  <leader>e  → toggle
-- ============================================================
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd  = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        position = "left",
        width    = 30,
        mappings = { ["<space>"] = "none" },
      },
      filesystem = {
        filtered_items = {
          visible        = false,
          hide_dotfiles  = true,
          hide_gitignored = true,
          never_show     = { ".git", "__pycache__", ".venv" },
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚", modified = "", deleted = "✖", renamed = "",
            untracked = "★", ignored = "", unstaged = "", staged = "", conflict = "",
          },
        },
      },
    })
  end,
}
