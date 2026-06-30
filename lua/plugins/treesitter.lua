-- ============================================================
--  Treesitter — current API (no deprecated .configs.setup())
-- ============================================================
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup()

    local parsers = {
      "go", "gomod", "gosum", "gowork",
      "python",
      "lua",
      "json", "yaml", "toml",
      "sql", "dockerfile", "bash",
      "markdown", "markdown_inline",
    }
    for _, lang in ipairs(parsers) do
      pcall(vim.cmd, "TSInstall " .. lang)
    end

    -- Attach highlighting to every readable buffer with a parser available
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
