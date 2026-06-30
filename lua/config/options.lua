-- ============================================================
--  Options
-- ============================================================
local opt = vim.opt

opt.number         = true
opt.relativenumber = true
opt.signcolumn     = "yes"
opt.cursorline     = true
opt.scrolloff      = 8
opt.termguicolors  = true

-- Indentation defaults — Go overrides to real tabs via autocmd below,
-- Python stays at 4-space soft indent (PEP8) which is the default here.
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.smartindent    = true

opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = false
opt.incsearch      = true

opt.splitright     = true
opt.splitbelow     = true

opt.wrap           = false
opt.swapfile       = false
opt.backup         = false
opt.undofile       = true
opt.updatetime     = 250
opt.timeoutlen     = 300
opt.clipboard      = "unnamedplus"
opt.mouse          = "a"

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Go uses real tabs — gofmt enforces this regardless, but keep nvim consistent
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop   = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- ── Diagnostics — squiggles, gutter signs, inline messages ──
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN]  = "▲",
      [vim.diagnostic.severity.INFO]  = "●",
      [vim.diagnostic.severity.HINT]  = "○",
    },
  },
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float = {
    border = "rounded",
    source = true,
  },
})
