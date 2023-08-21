vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.nu = true
vim.opt.numberwidth=4
vim.opt.relativenumber = true
vim.opt.foldmethod = "marker"
vim.opt.list = true
vim.opt.listchars = 'trail:·'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.guicursor = "" --always has fat cursor
--vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
--vim.opt.undodir = os.getenv("HOME") .. "\.vim\undodir"

vim.cmd [[
    augroup preWrite
        autocmd!
        autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
    augroup END
]]

vim.cmd [[
    autocmd TermOpen * :setlocal nonumber norelativenumber
]]

--vim.opt.clipboard = "unnamedplus"
--vim.cmd [[
--    let g:clipboard = {
--            \   'name': 'local bin xsel',
--            \   'copy': {
--            \      '+': $HOME.'/.local/bin/xsel -i -b',
--            \      '*': $HOME.'/.local/bin/xsel -i -p',
--            \    },
--            \   'paste': {
--            \      '+': $HOME.'/.local/bin/xsel -o -b',
--            \      '*': $HOME.'/.local/bin/xsel -o -p',
--            \   },
--            \   'cache_enabled': 0,
--    \ }
--]]
--vim.g.clipboard = {
-- name = "xsel",
-- copy = {
--  ["+"] = "xsel -i -b",
--  ["*"] = "xsel -i -p",
-- },
-- paste = {
--  ["+"] = "xsel  -o -b",
--  ["*"] = "xsel  -o -p",
-- },
-- cache_enabled = 0,
--}
