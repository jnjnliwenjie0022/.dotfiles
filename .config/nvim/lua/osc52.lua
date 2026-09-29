local function osc52_copy(lines, _)
    local text = table.concat(lines, '\n')
    local r = vim.system({ vim.fn.expand('y'), '-s' }, { stdin = text }):wait()
    if r.code == 0 and r.stdout ~= '' then
        vim.api.nvim_ui_send(r.stdout)
        vim.notify('Yank')
    else
        vim.notify('[Error] osc52: ' .. (r.stderr or ''), vim.log.levels.WARN)
    end
end

local function osc52_paste()
    vim.notify('[Warning] osc52: past not provide', vim.log.levels.WARN)
    return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
end

vim.g.clipboard = {
    name = 'OSC52 Bash',
    copy  = { ['+'] = osc52_copy, ['*'] = osc52_copy },
    paste = { ['+'] = osc52_paste, ['*'] = osc52_paste },
}

--nnoremap <leader>y :let @0 = expand("%:p")<CR>:let @" = @0<CR>:call Yank(@0)<CR>:echo "Yank: " . getreg('@0')<CR>
--vnoremap <leader>y :<C-U>let @0 = expand("%:p") . ":" . line("'<") . "-" . line("'>")<CR>:let @" = @0<CR>:call Yank(@0)<CR>:echo "Yank: " . getreg('@0')<CR>
--vnoremap "*y y:<C-U>call Yank(@0)<CR>:echo "Yank"<CR>
