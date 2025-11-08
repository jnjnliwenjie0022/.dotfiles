vim.g.mapleader = ' '
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-a>', '<nop>')
vim.keymap.set('n', '<C-x>', '<nop>')
vim.keymap.set('n', '<Space>', '<nop>')
vim.keymap.set('v', '<Space>', '<nop>')
vim.keymap.set('i', '<C-c>', '<Esc>')
-- % refers to the current buffer
-- %:p refers to the path to the file
--vim.keymap.set('n', '<leader>e', '<CMD>Ex<CR><CMD>echo "Path:"expand("%:p")<CR>')
vim.keymap.set('n', '<leader>b', '<CMD>exe "w %:p.bak.".strftime("%Y%m%d_%H%M%S")<CR><CMD>echo "Backup:"expand("%:p").".bak.".strftime("%Y%m%d_%H%M%S")<CR>')
vim.keymap.set('n', '<leader>y', '<CMD>let @" = expand("%:p")<CR><CMD>let @* = expand("%:p")<CR><CMD>let @+ = expand("%:p")<CR><CMD>echo "pp"expand("%:p")<CR>')
--vim.keymap.set('v', '<leader>y', '\"+y<CMD>echo "Copy to clipboard"<CR>')
--vim.keymap.set('n', '<leader>p', '\"+p<CMD>echo "Past from clipboard"<CR>')
--vim.keymap.set('v', '<leader>p', '\"_d\"+P<CMD>echo "Past from clipboard"<CR>')
vim.keymap.set('n', '<leader>c', '<CMD>%s/\\s\\+$//e<CR><CMD>%s/\r$//e<CR>')
-- :<C-f> edit in command mode
-- <C-w>H window move to the left
-- <C-w>J window move to the bottom
-- <C-w>L window move to the right
-- @@ command repeat
-- ; keymap repeat
-- , keymap reversely repeat
-- :cr[ewind] quickfix list first item
-- :cla[st] quickfix list last item
-- https://www.youtube.com/watch?v=oQB8lYUZtrY
vim.keymap.set('n', '[q', '<CMD>cp<CR>zz')
vim.keymap.set('n', ']q', '<CMD>cn<CR>zz')
vim.keymap.set('n', '[Q', '<CMD>cpf<CR>zz')
vim.keymap.set('n', ']Q', '<CMD>cnf<CR>zz')
vim.keymap.set('n', 'X', '\"_D')
vim.keymap.set('v', 'X', '\"_D')
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
vim.keymap.set('v', 'Y', '$y')
--vim.keymap.set('v','y','myy`y')
--vim.keymap.set('v','Y','myY`y')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', '\'m', '\'mzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')

--:tabm[N]

--V%= format
--cd % show current dir
--cd %:p set current dir

--ref:https://neovim.discourse.group/t/writefile-to-dev-tty-stopped-working-in-nvim-0-9/3784/7
vim.cmd[[
function! Yank(text) abort
    let escape = system('yank', a:text)
    if v:shell_error
        echoerr escape
    else
        call writefile([escape], '/proc/self/fd/1', 'b')
    endif
endfunction
vnoremap <silent> <leader>y y:<C-U>call Yank(@0)<CR>
]]
