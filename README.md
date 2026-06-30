# nvim config — Go + Python

Personal Neovim configuration for backend development.
Go primary, Python secondary. Fedora Linux.

Clone and recover in under 5 minutes on any fresh machine.

---

## Quick recovery (after a drive wipe or new machine)

```bash
# 1. Install system dependencies (Fedora)
sudo dnf install -y gcc make git ripgrep golang

# 2. Install goimports (Go formatter)
go install golang.org/x/tools/cmd/goimports@latest
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
source ~/.bashrc

# 3. Clone this config into place
git clone git@github.com:YOUR_USERNAME/nvim-config.git ~/.config/nvim

# 4. Open nvim — lazy.nvim bootstraps itself and installs all plugins
nvim
# Wait for the install UI to finish, then press q → :qa

# 5. Reopen and install LSP servers
nvim
# Run: :Mason
# Wait for gopls, pyright, ruff, lua_ls to install → press q
```

That's the full recovery. No other steps.

---

## System dependencies explained

These must be installed on the OS before nvim works correctly.
All installed via `sudo dnf install` on Fedora.

| Package | Why it's needed |
|---|---|
| `gcc` | Treesitter compiles parsers from C — needs a compiler |
| `make` | Telescope's fzf extension builds a native binary |
| `git` | lazy.nvim bootstraps itself and all plugins via git clone |
| `ripgrep` | Telescope live grep (`<leader>fg`) won't work without it |
| `golang` | Go itself — gopls and goimports depend on it |
| `goimports` | Auto-imports on save — installed via `go install`, not dnf |

Python is assumed already installed (`python3`, `pip3`).
`pyright` and `ruff` install automatically through Mason inside nvim.

---

## Fonts

This config uses nerd font glyphs for icons in neo-tree, lualine,
and aerial. Without a patched nerd font your terminal will show
blank boxes instead of icons.

Recommended: **SF Mono Nerd Font Ligaturized** (pre-patched, free)

```bash
mkdir -p ~/.local/share/fonts
cd /tmp
git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git
cp SFMono-Nerd-Font-Ligaturized/*.otf ~/.local/share/fonts/
fc-cache -fv
```

Then set your terminal emulator's font to:
**SF Mono Nerd Font Ligaturized**

Alternatively any other [Nerd Font](https://www.nerdfonts.com/) works —
JetBrainsMono Nerd Font is a good fallback.

> **Note on SF Pro:** Apple's `SF Pro.dmg` does NOT work here.
> SF Pro is a proportional UI font, not a monospace coding font,
> and it is not patched with nerd font glyphs. Use SF Mono (above) instead.

---

## Plugin list

| Plugin | Purpose |
|---|---|
| `lazy.nvim` | Plugin manager — bootstraps itself |
| `gruvbox.nvim` | Colorscheme — dark, warm browns/oranges, no blue |
| `nvim-treesitter` | Syntax highlighting for Go, Python, SQL, YAML, etc |
| `mason.nvim` | Installs LSP servers and formatters |
| `nvim-lspconfig` | LSP client — connects gopls, pyright, ruff, lua_ls |
| `nvim-cmp` + LuaSnip | Autocomplete + snippets |
| `conform.nvim` | Format on save (gofmt/goimports for Go, ruff for Python) |
| `oil.nvim` | Directory-as-buffer file navigation (`-` key) |
| `neo-tree.nvim` | Persistent left sidebar file explorer (`<leader>e`) |
| `telescope.nvim` | Fuzzy file search, live grep, symbol search |
| `aerial.nvim` | Symbols outline sidebar — functions/structs per file |
| `lualine.nvim` | Statusline with branch, diagnostics count, filetype |
| `nvim-autopairs` | Auto-close brackets and braces |
| `Comment.nvim` | `gcc` to comment a line |
| `gitsigns.nvim` | Git diff signs in gutter, hunk staging |
| `which-key.nvim` | Shows available keymaps when you pause on `<leader>` |
| `indent-blankline` | Indent guides |

---

## LSP servers (installed via :Mason)

| Server | Language | Notes |
|---|---|---|
| `gopls` | Go | Full LSP — types, completion, diagnostics, imports |
| `pyright` | Python | Type checking, auto-detects `.venv` in project root |
| `ruff` | Python | Fast linter — runs alongside pyright |
| `lua_ls` | Lua | For editing this config itself |

### Python venv resolution

pyright automatically detects `.venv` in the project root and
uses its Python interpreter to resolve installed packages.

Workflow for any Python project:

```bash
cd ~/my-project
python3 -m venv .venv
source .venv/bin/activate
pip install <whatever>
nvim main.py  # pyright will see your installed packages
```

If pyright shows "module not found" for something you've pip-installed,
run `:LspRestart` — pyright may have started before the venv was detected.

---

## Key bindings

### File navigation
| Key | Action |
|---|---|
| `<leader>e` | Toggle neo-tree sidebar |
| `-` | Oil — open current file's directory as a buffer |
| `<leader>ff` | Fuzzy find files |
| `<leader>fg` | Live grep across project |
| `<leader>fb` | Switch between open buffers |
| `<leader>o` | Toggle symbols outline (aerial) |
| `<C-h/j/k/l>` | Move between splits |
| `<S-h>` / `<S-l>` | Previous / next buffer |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |

### Diagnostics (errors/warnings)
| Key | Action |
|---|---|
| `<leader>d` | Show diagnostic detail for line under cursor |
| `[d` | Jump to previous diagnostic in current file |
| `]d` | Jump to next diagnostic in current file |
| `<leader>dd` | Open project-wide diagnostic list (quickfix) |
| `<C-n>` | Next item in quickfix list |
| `<C-p>` | Previous item in quickfix list |

### Go
| Key | Action |
|---|---|
| `<leader>gt` | `go test ./...` |
| `<leader>gb` | `go build ./...` |
| `<leader>gr` | `go run .` |
| `<leader>gi` | `go mod tidy` |

### Python
| Key | Action |
|---|---|
| `<leader>pr` | Run current file (`python3 %`) |
| `<leader>pv` | Create `.venv` in current directory |

### Terminal
| Key | Action |
|---|---|
| `<leader>tt` | New terminal in vertical split |
| `<leader>th` | New terminal in horizontal split |
| `<Esc>` (in terminal) | Exit terminal mode |
| `i` (in terminal buffer) | Enter terminal input mode |

Repeat `<leader>tt` as many times as needed for multiple terminals.
Navigate between them with `<C-h/j/k/l>` like any other split.

### Git
| Key | Action |
|---|---|
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Git blame current line |
| `]h` / `[h` | Next / prev git hunk |

### General
| Key | Action |
|---|---|
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `<leader>bd` | Delete buffer |
| `gcc` | Comment/uncomment line |
| `gc` (visual) | Comment/uncomment selection |

---

## Colorscheme

**gruvbox** — dark variant, hard contrast.
Warm brown/orange/yellow palette. No blue or purple tones.

To change contrast in `lua/plugins/colorscheme.lua`:
```lua
contrast = "soft"    -- lightest dark background
contrast = "medium"  -- middle ground
contrast = "hard"    -- darkest (current)
```

---

## What's not included (future additions)

These are intentionally left out for now but slot in as single plugin files:

- **Debugger** — `nvim-dap` + `nvim-dap-go` + `nvim-dap-python` for step-through breakpoints
- **Test runner UI** — `neotest` for inline pass/fail per test
- **Database client** — `vim-dadbod` + `vim-dadbod-ui` for Postgres/Redis from inside nvim
- **REST client** — `rest.nvim` for testing API endpoints without leaving the editor
