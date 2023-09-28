-- http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html
-- https://dev.to/voyeg3r/my-lazy-neovim-config-3h6o

-- write event
vim.api.nvim_create_autocmd({ "BufWrite" }, {
    pattern = '*',
    callback = function()
        local cursor_pos = vim.fn.getpos('.')  -- get current cursor position
        vim.cmd('%s/\\s\\+$//e')
        vim.cmd('%s/\r$//e')
        vim.fn.setpos('.', cursor_pos) -- cursor go to the position which you describe
    end,
})

-- yank event
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern  = '*',
    callback = function()
        --vim.fn.setreg('+', vim.fn.getreg('"')) -- pass '"' register to '+' register
        --vim.fn.setreg('*', vim.fn.getreg('"')) -- pass '"' register to '*' register
        vim.highlight.on_yank {
            higroup = 'IncSearch',
            timeout = '60'
        }
    end
})

-- terminal event
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = '*',
    callback = function ()
        vim.cmd('setlocal nonumber norelativenumber')
        vim.cmd('startinsert')
    end
})

-- read event
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern  = '*',
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos('.', vim.fn.getpos("'\""))
            vim.cmd('silent! foldopen')
        end
    end
})

-- insert event
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    pattern  = '*',
    callback = function()
        vim.cmd('hi CursorLine   gui=NONE               guibg=#000000')
        vim.cmd('hi CursorLineNr gui=NONE guifg=#cdd6f4 guibg=#000000')
    end
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern  = '*',
    callback = function()
        vim.cmd('hi CursorLine   gui=NONE               guibg=#262626')
        vim.cmd('hi CursorLineNr gui=NONE guifg=#cdd6f4 guibg=#262626')
    end
})

-- comment event
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

-- save event
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wall",
    nested = true,
})

--https://gitlab.com/simonced/dotfiles/blob/master/vim/plugin/ced.vim#L62
vim.cmd [[
if has('autocmd') && v:version > 701
    augroup todo
        autocmd!
        autocmd Syntax * call matchadd(
                    \ 'Todo',
                    \ '\v\W\zs<(WARNING|INFO|TODO|FIXME|CHANGED)>'
                    \ )
    augroup END
endif
]]

--vim.api.nvim_create_user_command("MakeDirectory", function()
--    ---@diagnostic disable-next-line: missing-parameter
--    local path = vim.fn.expand("%")
--    local dir = vim.fn.fnamemodify(path, ":p:h")
--    if vim.fn.isdirectory(dir) == 0 then
--        vim.fn.mkdir(dir, "p")
--    else
--        vim.notify("Directory already exists", "WARN", { title = "Nvim" })
--    end
--end, { desc = "Create directory if it doesn't exist" })

--" 快速匹配Todo
--command TODO :call FindFile1()
--func FindFile1()
--  " 可以根据自己的开发习惯来设置管理path， 从当前项目的根目录匹配
--  let a = substitute(matchstr(expand("%:p"), 'dev/\(.*\)/'), '/src.*', '', 'g')
--  execute ':vimgrep /TODO/gj ~/Documents/'.a.'/src/** |copen'
--endfunc
--
--
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
