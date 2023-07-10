vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.numberwidth=4
vim.opt.relativenumber = true
vim.opt.foldmethod = "marker"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true 
vim.opt.incsearch = true

vim.opt.guicursor = "" --always has fat cursor

vim.opt.scrolloff = 8
--vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "\.vim\undodir"
--vim.opt.undofile = true

vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"

vim.cmd [[ set splitbelow splitright ]]
