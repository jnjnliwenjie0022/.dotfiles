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

vim.keymap.set('n', '<leader>y', function()
    local path = vim.fn.expand('%:p')
    if path == ''  then
        vim.notify('[Warning Yank] file is nil' .. path, vim.log.levels.WARN)
        return
    end
    vim.fn.setreg('0', path)
    vim.fn.setreg('"', path)
    vim.fn.setreg('*', path)
    vim.fn.setreg('+', path)
    vim.notify('Yank: ' .. path)
end, { desc = 'Yank file path via OSC52' })

vim.keymap.set('x', '<leader>y', function()
    local path = vim.fn.expand('%:p')
    if path == ''  then
        vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)  -- 離開 visual mode
        vim.notify('[Warning Yank] file is nil' .. path, vim.log.levels.WARN)
        return
    end

    local s, e = vim.fn.line('v'), vim.fn.line('.')
    if s > e then s, e = e, s end
    if s == e then
        target = string.format('%s#L%d', path, s)
    else
        target = string.format('%s#L%d-L%d', path, s, e)
    end
    vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)  -- 離開 visual mode
    vim.fn.setreg('0', target)
    vim.fn.setreg('"', target)
    vim.fn.setreg('*', target)
    vim.fn.setreg('+', target)
    vim.notify('Yank: ' .. target)
end, { desc = 'Yank file path with line range via OSC52' })
