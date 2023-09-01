vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", "<CMD>Ex<CR>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-a>", "<nop>") -- avoid comflict with tmux
vim.keymap.set("n", "<Space>", "<nop>")
vim.keymap.set("v", "<Space>", "<nop>")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("v", "x", "\"_x")

vim.keymap.set("n", "p", "\"+p")
vim.keymap.set("v", "p", "\"_d\"+P")
vim.keymap.set("n", "P", "\"+P")
vim.keymap.set("v", "P", "\"+P")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

--https://gist.github.com/seanh/a866462a27cb3ad7b084c8e6000a06b9
--vim.keymap.set("n", "<leader>n", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>N", "<cmd>lprev<CR>zz")

--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") --tmux-sessionizer
--vim.keymap.set("n", "<C-q>", "<cmd>tabnew<CR>")
--Ngt
--:tabm[N]

--V%= format
--cd % show current dir
--cd %:p set current dir

---- https://www.reddit.com/r/neovim/comments/1293o2y/vimoptclipboard_unnamedplus_is_very_slow/
--vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
--  once = true,
--  callback = function()
--    if vim.fn.has("win32") == 1 then
--      vim.g.clipboard = {
--        copy = {
--          ["+"] = "win32yank.exe -i --crlf",
--          ["*"] = "win32yank.exe -i --crlf",
--        },
--        paste = {
--          ["+"] = "win32yank.exe -o --lf",
--          ["*"] = "win32yank.exe -o --lf",
--        },
--      }
--    elseif vim.fn.has("unix") == 1 then
--      if vim.fn.executable("xclip") == 1 then
--        vim.g.clipboard = {
--          copy = {
--            ["+"] = "xclip -selection clipboard",
--            ["*"] = "xclip -selection clipboard",
--          },
--          paste = {
--            ["+"] = "xclip -selection clipboard -o",
--            ["*"] = "xclip -selection clipboard -o",
--          },
--        }
--      elseif vim.fn.executable("xsel") == 1 then
--        vim.g.clipboard = {
--          copy = {
--            ["+"] = "xsel --clipboard --input",
--            ["*"] = "xsel --clipboard --input",
--          },
--          paste = {
--            ["+"] = "xsel --clipboard --output",
--            ["*"] = "xsel --clipboard --output",
--          },
--        }
--      end
--    end
--
--    vim.opt.clipboard = "unnamedplus"
--  end,
--  desc = "Lazy load clipboard",
--})
--
