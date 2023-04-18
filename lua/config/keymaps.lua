-- better up/down, Add jumps 5 and greater to the jump list
vim.keymap.set("n", "j", 'v:count1 > 4 ? "m\'" .. v:count .. "gjm\'" : "gj"', { expr = true, silent = true })
vim.keymap.set("n", "k", 'v:count1 > 4 ? "m\'" .. v:count .. "gkm\'" : "gk"', { expr = true, silent = true })

-- don't add '{' or '}' to jumplist.
-- https://superuser.com/questions/836784/in-vim-dont-store-motions-in-jumplist
vim.api.nvim_set_keymap(
  "n",
  "}",
  "':<C-u> execute \"keepjumps norm! ' .. v:count1 .. '}\"<CR>'",
  { expr = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "{",
  "':<C-u> execute \"keepjumps norm! ' .. v:count1 .. '{\"<CR>'",
  { expr = true, silent = true }
)

-- Lazy access without triggering cmp lazy-load
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- disable troublesome keys
vim.keymap.set("n", "<C-z>", "<nop>")
vim.keymap.set("i", "<C-z>", "<nop>")
vim.keymap.set("n", "<C-l>", "<nop>")
vim.keymap.set("i", "<C-l>", "<nop>")

-- nice replace macro, works with counts now
-- "https://github.com/community/community/discussions/29817"
vim.api.nvim_set_keymap(
  "n",
  "<leader>s",
  "':' .. (v:count ? '' : '%') .. 's/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>'",
  { noremap = true, expr = true }
)

-- movement mappings
vim.keymap.set({ "n", "x" }, "<C-e>", "repeat('<C-e>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-y>", "repeat('<C-y>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set({ "n", "x" }, "n", "nzz", { noremap = true })
vim.keymap.set({ "n", "x" }, "N", "Nzz", { noremap = true })

-- command line help
vim.keymap.set("c", "<c-j>", "<nop>")
vim.keymap.set("c", "<c-k>", "<nop>")
vim.keymap.set("c", "<c-l>", "<down>")
vim.keymap.set("c", "<c-h>", "<up>")

-- save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr><esc>")

-- fast quit
vim.keymap.set("n", "<c-w><c-t>", "<cmd>tabclose!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-d>", "<cmd>wq!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-q>", "<cmd>q!<CR>", { silent = true })

-- terminal commands
vim.keymap.set("t", "<c-z>", "<c-\\><c-n>", { noremap = true })
vim.keymap.set("t", "<C-w><c-q>", "<c-\\><c-n><c-w><c-q>", {})
vim.keymap.set("t", "<C-w><c-w>", "<c-\\><c-n><c-w><c-w>", {})
vim.keymap.set("n", "<c-w><c-m>", "<CMD>vs term://zsh<CR>i", {})

-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Switch buffers with <ctrl>
vim.keymap.set("n", "H", "<cmd>bprevious<cr>")
vim.keymap.set("n", "L", "<cmd>bnext<cr>")

-- Easier pasting(with auto-indent)
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "[p", ":pu!<cr>`[v`]=")
vim.keymap.set("n", "]p", ":pu<cr>`[v`]=")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set(
  "n",
  "<leader>cg",
  '<CMD>call myfunc#ExecuteStuff("right")<CR>',
  { desc = "execute bufffer(right)", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>ch",
  '<CMD>call myfunc#ExecuteStuff("bot")<CR>',
  { desc = "execute buffer(bot)", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>cd",
  "<CMD>call myfunc#CloseTerm()<CR>",
  { desc = "close term", noremap = true, silent = true }
)

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>vnew<cr>", { desc = "New File" })