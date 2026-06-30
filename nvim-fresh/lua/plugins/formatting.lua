-- ============================================================
--  Formatting — conform.nvim
--  Go: goimports + gofmt
--  Python: ruff_format (fast, replaces black+isort in one pass)
-- ============================================================
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd   = { "ConformInfo" },
  opts  = {
    formatters_by_ft = {
      go     = { "goimports", "gofmt" },
      python = { "ruff_format" },
      lua    = { "stylua" },
    },
    format_on_save = {
      timeout_ms   = 3000,
      lsp_fallback = true,
    },
  },
  -- Dependencies to install manually (see README):
  --   go:     go install golang.org/x/tools/cmd/goimports@latest
  --   python: pip install ruff  (or installed via Mason automatically — ruff LSP also formats)
}
