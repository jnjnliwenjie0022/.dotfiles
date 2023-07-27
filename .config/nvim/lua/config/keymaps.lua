vim.g.mapleader = " "

vim.keymap.set("n", "<C-a>", "<nop>") -- avoid comflict with tmux

vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("x", "x", "\"_x")

vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>")
--vim.keymap.set("n", "<leader>so", "<cmd>so<CR>") 

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
--https://gist.github.com/seanh/a866462a27cb3ad7b084c8e6000a06b9
vim.keymap.set("n", "<C-n>",     "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-N>",     "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>n", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>N", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") --tmux-sessionizer

--vim.keymap.set("n", "<C-q>", "<cmd>tabnew<CR>")
--Ngt
--:tabm[N]

--<C-w>| resize to max
--<C-w>= resize to equal
--V%= format
--cd % show current dir 
--cd %:p set current dir
--:CheckHealth check nvim health
