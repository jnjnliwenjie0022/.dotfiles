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

vim.cmd [[
augroup prewrites
    autocmd!
    autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END
]]

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

--vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "\.vim\undodir"
--vim.opt.undofile = true
