# Edwin's nvim config — Go + Python, Fedora

Rebuilt clean after the drive wipe. Same plugin stack as before,
now using the correct modern APIs from the start (no deprecated
lspconfig/treesitter calls), Python support added, terminal
keymaps added.

---

## 1. System dependencies (install before opening nvim)

```bash
# Core build tools — needed for treesitter parser compilation
sudo dnf install -y gcc make git ripgrep

# Go itself, if not already installed
sudo dnf install -y golang

# goimports — used by conform.nvim to auto-import on save
go install golang.org/x/tools/cmd/goimports@latest

# Make sure $GOPATH/bin is on your PATH so goimports is found
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
source ~/.bashrc
```

You said you already have Python installed — confirm pip is available:

```bash
python3 --version
pip3 --version
```

`pyright` and `ruff` are installed automatically through Mason inside nvim — no manual pip install needed for the LSP itself. Per-project packages still go in your venvs as normal.

---

## 2. Install the config

```bash
# Back up old config if somehow still present
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

tar -xzf ~/Downloads/nvim-fresh.tar.gz -C ~/Downloads/
mv ~/Downloads/nvim-fresh ~/.config/nvim
```

---

## 3. First launch

```bash
nvim
```

lazy.nvim bootstraps itself, then installs all plugins. **Wait for the UI to finish** (no spinners left), press `q`, then `:qa`.

Reopen:

```bash
nvim
```

Open Mason to confirm tool installation:

```
:Mason
```

You should see `gopls`, `pyright`, `ruff`, `lua_ls` either installed or actively installing. Wait for all four, press `q`.

---

## 4. Nerd Font (for icons — neo-tree, statusline, aerial)

```bash
mkdir -p ~/.local/share/fonts
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -fv
```

Set your terminal emulator's font to **JetBrainsMono Nerd Font Mono**.

---

## 5. Verify Go works

```bash
mkdir -p ~/test-go && cd ~/test-go
go mod init test
nvim main.go
```

Type some Go code with a deliberate unused variable. You should see: syntax highlighting (treesitter), red squiggle + gutter sign + inline message (gopls diagnostics), autocomplete on `fmt.` (nvim-cmp), and `<leader>o` should list `main` in the outline sidebar.

---

## 6. Verify Python works

```bash
mkdir -p ~/test-py && cd ~/test-py
python3 -m venv .venv
source .venv/bin/activate
pip install requests   # anything, just to test import resolution
nvim main.py
```

Write `import requests` and a function. Confirm: autocomplete works, hover (`K`) shows type info, and crucially — pyright should **not** show a "module not found" error for `requests`, since it's correctly detecting `.venv`. If it does show that error, run `:LspRestart` after confirming `.venv` exists in the project root.

Run the file directly with `<leader>pr`.

---

## Key bindings

### Navigation
| Key | Action |
|---|---|
| `<leader>e` | Toggle file tree sidebar (neo-tree) |
| `-` | Oil — directory as buffer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>o` | Toggle symbols outline (aerial) |
| `<C-h/j/k/l>` | Move between splits |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>d` | Show diagnostic detail |
| `[d` / `]d` | Prev / next diagnostic |

### Go
| Key | Action |
|---|---|
| `<leader>gt` | go test ./... |
| `<leader>gb` | go build ./... |
| `<leader>gr` | go run . |
| `<leader>gi` | go mod tidy |

### Python
| Key | Action |
|---|---|
| `<leader>pr` | Run current file (python3 %) |
| `<leader>pv` | Create .venv in current dir |

### Terminal (new — multiple terminals like VSCode)
| Key | Action |
|---|---|
| `<leader>tt` | New vertical-split terminal |
| `<leader>th` | New horizontal-split terminal |
| `<Esc>` (in terminal) | Exit terminal mode back to normal |
| `i` (in terminal buffer) | Re-enter terminal input mode |

Each `<leader>tt`/`<leader>th` opens an independent shell. Repeat as many times as needed — exactly like VSCode terminal tabs, just arranged as splits. Navigate between them with `<C-h/j/k/l>` like any other split.

### Git
| Key | Action |
|---|---|
| `<leader>hs` | Stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `]h` / `[h` | Next / prev hunk |

---

## What we deliberately left out (and why)

**Aerial diagnostic badges** — per-symbol error counts in the outline sidebar. Tested extensively, unreliable across versions independent of correct LSP/treesitter setup. Diagnostics are fully visible three other reliable ways (inline virtual text, gutter signs, `<leader>d` float), so this isn't a functional gap, just a missing decoration.

**Debugger (DAP)** — not yet added. When you want step-through breakpoints for either language: `nvim-dap` + `nvim-dap-go` for Go, `nvim-dap-python` for Python. Each is one new plugin file.

**Test runner UI** — `<leader>gt` shell-runs `go test ./...` with raw output. A proper inline pass/fail UI (`neotest`) can be added later if the raw output starts feeling limiting.
