-- ============================================================
--  LSP — native nvim 0.11+ API (vim.lsp.config / vim.lsp.enable)
--  Mason installs the servers; we configure and enable them directly.
--
--  Servers:
--    gopls    — Go
--    pyright  — Python type checking + completion
--    ruff     — Python linting (fast, via Rust) — complements pyright
--    lua_ls   — for editing this config
-- ============================================================
return {
  {
    "williamboman/mason.nvim",
    cmd    = "Mason",
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "pyright",
          "ruff",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps when any LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
          end
          map("gd",         vim.lsp.buf.definition,      "Go to definition")
          map("gD",         vim.lsp.buf.declaration,     "Go to declaration")
          map("gr",         "<cmd>Telescope lsp_references<CR>", "References")
          map("gi",         vim.lsp.buf.implementation,  "Go to implementation")
          map("K",          vim.lsp.buf.hover,           "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename,          "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,     "Code action")
          map("<leader>D",  vim.lsp.buf.type_definition, "Type definition")
        end,
      })

      -- ── gopls ───────────────────────────────────────────────
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck         = true,
            gofumpt              = true,
            usePlaceholders      = true,
            completeUnimported   = true,
          },
        },
      })
      vim.lsp.enable("gopls")

      -- ── pyright — respects .venv automatically via root detection ──
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths       = true,
              useLibraryCodeForTypes = true,
              diagnosticMode         = "openFilesOnly",
            },
          },
        },
        -- Tell pyright where to look for the venv: project root containing .venv
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root = vim.fs.root(fname, { ".venv", "pyproject.toml", "setup.py", ".git" })
          on_dir(root)
        end,
      })
      vim.lsp.enable("pyright")

      -- ── ruff — fast linter, runs alongside pyright ──────────
      vim.lsp.config("ruff", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ruff")

      -- ── lua_ls ──────────────────────────────────────────────
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- ── Python venv detection ────────────────────────────────
      -- pyright needs the venv's python path explicitly to resolve
      -- installed packages (pip-installed libs won't type-check otherwise)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          local root = vim.fs.root(0, { ".venv", "pyproject.toml", ".git" })
          if not root then return end

          local venv_python = root .. "/.venv/bin/python"
          if vim.fn.filereadable(venv_python) == 1 then
            vim.g.python3_host_prog = venv_python
            -- Push the interpreter path into pyright for this buffer
            for _, client in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
              client.config.settings.python.pythonPath = venv_python
              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
          end
        end,
      })
    end,
  },
}
