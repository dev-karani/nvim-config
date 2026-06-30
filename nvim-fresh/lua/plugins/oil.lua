-- ============================================================
--  Oil — directory-as-buffer navigation. Press `-` from any file.
-- ============================================================
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = { "icon", "permissions", "size" },
      view_options = { show_hidden = true, natural_order = true },
      float = { padding = 2, max_width = 80, max_height = 30, border = "rounded" },
      keymaps = {
        ["g?"]    = "actions.show_help",
        ["<CR>"]  = "actions.select",
        ["l"]     = "actions.select",
        ["-"]     = "actions.parent",
        ["_"]     = "actions.open_cwd",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
        ["q"]     = "actions.close",
        ["gs"]    = "actions.change_sort",
        ["H"]     = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
    })
  end,
}
