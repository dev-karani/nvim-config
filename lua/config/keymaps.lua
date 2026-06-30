-- ============================================================
--  Keymaps — Leader = Space
-- ============================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- ── General ─────────────────────────────────────────────────
map("n", "<Esc>",  "<cmd>nohlsearch<CR>")
map("n", "<C-s>",  "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>Q", "<cmd>qa!<CR>")

-- ── Window navigation ───────────────────────────────────────
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- ── Buffer navigation ───────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<S-h>", "<cmd>bprev<CR>")
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ── File navigation ─────────────────────────────────────────
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent dir (oil)" })
-- <leader>e is set in neo-tree.lua (toggle sidebar)

-- ── Telescope ───────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Symbols" })

-- ── Go ───────────────────────────────────────────────────────
map("n", "<leader>gt", "<cmd>!go test ./...<CR>",  { desc = "Go test all" })
map("n", "<leader>gb", "<cmd>!go build ./...<CR>", { desc = "Go build" })
map("n", "<leader>gr", "<cmd>!go run .<CR>",       { desc = "Go run" })
map("n", "<leader>gi", "<cmd>!go mod tidy<CR>",    { desc = "Go mod tidy" })

-- ── Python ───────────────────────────────────────────────────
map("n", "<leader>pr", "<cmd>!python3 %<CR>",            { desc = "Run current file" })
map("n", "<leader>pv", "<cmd>!python3 -m venv .venv<CR>", { desc = "Create venv" })

-- ── Diagnostics ─────────────────────────────────────────────
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostics float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Project-wide error list (every open buffer's diagnostics, in one list)
map("n", "<leader>dd", function()
  vim.diagnostic.setqflist()  -- populate quickfix with all diagnostics
  vim.cmd("copen")            -- open the quickfix window
end, { desc = "All diagnostics (quickfix)" })

-- Navigate the quickfix list once it's open
map("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Prev quickfix item" })

-- ── Outline ──────────────────────────────────────────────────
map("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle outline" })

-- ── Terminal ─────────────────────────────────────────────────
map("n", "<leader>tt", "<cmd>vsplit | terminal<CR>", { desc = "New vertical terminal" })
map("n", "<leader>th", "<cmd>split | terminal<CR>",  { desc = "New horizontal terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ── Move lines in visual mode ────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- ── Paste without losing register ───────────────────────────
map("x", "<leader>p", [["_dP]])
