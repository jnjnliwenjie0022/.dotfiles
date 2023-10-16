vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>e', '<CMD>Ex<CR>')
vim.keymap.set('n', '<leader>yy','<CMD>let @" = expand("%:p")<CR><CMD>let @* = expand("%:p")<CR><CMD>let @+ = expand("%:p")<CR><CMD>echo "Copy to clipboard:"expand("%:p")<CR>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-a>', '<nop>')
vim.keymap.set('n', '<C-x>', '<nop>')
vim.keymap.set('n', '<Space>', '<nop>')
vim.keymap.set('v', '<Space>', '<nop>')

vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'x', '\"_x')
vim.keymap.set('v', 'x', '\"_x')
--vim.keymap.set('n', 'p', '\"+p')
--vim.keymap.set('v', 'p', '\"_d\"+P')
--vim.keymap.set('n', 'P', '\"+P')
--vim.keymap.set('v', 'P', '\"+P')
--vim.keymap.set("n", "y", '\"+y')
--vim.keymap.set("v", "y", '\"+y')
--vim.keymap.set("n", "Y", '\"+Y')
--vim.keymap.set("v", "Y", '\"+Y')
--vim.keymap.set("n", "d", '\"+d')
--vim.keymap.set("v", "d", '\"+d')
--vim.keymap.set("n", "D", '\"+D')
--vim.keymap.set("v", "D", '\"+D')

vim.keymap.set('v', 'p', '\"_dP')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'G', 'Gzz')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')

vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')

--dp             diffput: puts changes under the cursor into the other file
--                        making them identical (thus removing the diff).
--do             diffget: (o => obtain). The change under the cursor is replaced
--                        by the content of the other file making them identical.
--]c             Jump to the next diff
--[c             Jump to the previous diff

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
