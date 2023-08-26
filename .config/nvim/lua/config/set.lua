-- IMPROVE NEOVIM STARTUP
-- https://github.com/editorconfig/editorconfig-vim/issues/50
vim.g.loaded_python_provier = 0
vim.g.loaded_python3_provider = 0
vim.g.python_host_skip_check = 1
vim.g.python_host_prog='/bin/python2'
vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog='/bin/python3'
vim.opt.pyxversion=3
vim.g.EditorConfig_core_mode = 'external_command'
-- https://vi.stackexchange.com/a/5318/7339
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

-- Disable nvim intro
vim.opt.shortmess:append "sI"

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

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

--" 快速匹配Todo
--command TODO :call FindFile1()
--func FindFile1()
--  " 可以根据自己的开发习惯来设置管理path， 从当前项目的根目录匹配
--  let a = substitute(matchstr(expand("%:p"), 'dev/\(.*\)/'), '/src.*', '', 'g')
--  execute ':vimgrep /TODO/gj ~/Documents/'.a.'/src/** |copen'
--endfunc
--
--" 高亮显示
--hi Todo term=bold ctermfg=0 ctermbg=15 gui=none guifg=none

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
