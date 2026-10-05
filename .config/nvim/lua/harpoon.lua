-- ## Harpoon
local harpoon_dir = vim.fn.expand('~/.vim/harpoon/')

local state = {
    harpoon_win = nil,
    parent_win = nil,
}

local function is_invalid(path)
    return path == '' or vim.startswith(path, harpoon_dir) or vim.fn.isdirectory(path) == 1
end

local function get_harpoon_file()
    -- create harpoon directory "~/.vim/harpoon/"
    vim.fn.mkdir(harpoon_dir, 'p')

    -- create harpoon file
    local file_path = vim.fn.getcwd()
    local file = harpoon_dir .. (file_path:gsub('/', '%%'))
    vim.fn.writefile({}, file, 'a')

    return file
end

local function is_harpoon_win()
    return state.harpoon_win ~= nil and vim.api.nvim_win_is_valid(state.harpoon_win)
end

local function close_harpoon_win()
    if is_harpoon_win() then
        vim.api.nvim_win_close(state.harpoon_win, true)
    end
    state.harpoon_win = nil
end

local function jump()
    local file = vim.trim(vim.api.nvim_get_current_line())
    if vim.fn.filereadable(file) == 0 then
        vim.notify('[Warning Harpoon] file not found: ' .. file, vim.log.levels.WARN)
        return
    end

    close_harpoon_win()
    vim.cmd.edit(file)
    -- rename file path according to the root
    vim.cmd.cd(vim.fn.getcwd())
end

local function open_harpoon_win()
    state.parent_win = vim.api.nvim_get_current_win()

    local buf = vim.fn.bufadd(get_harpoon_file())
    local width = math.floor(vim.o.columns)
    local height = math.floor(vim.o.lines)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    state.harpoon_win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = ' Harpoon ',
--        title_pos = 'center',
    })

    vim.keymap.set('n', '<CR>', jump, { buffer = buf, silent = true })
    vim.keymap.set('n', 'q', close_harpoon_win, { buffer = buf, silent = true })
    vim.keymap.set('n', '<Esc>', close_harpoon_win, { buffer = buf, silent = true })

    -- disable command line
    local o = { buffer = buf, silent = true, nowait = true }
    for _, lhs in ipairs({ ':', 'q:', 'Q', 'gQ' }) do
        vim.keymap.set({ 'n', 'x' }, lhs, '<Nop>', o)
    end

    -- auto save
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'BufLeave' }, {
        buffer = buf,
        callback = function()
            vim.cmd('silent! write')
        end,
    })
end

local function toggle()
    if is_harpoon_win() then
        close_harpoon_win()
    else
        open_harpoon_win()
    end
end

local function add()
    local file = vim.fn.expand('%:p')
    local harpoon_file = get_harpoon_file()

    if is_invalid(file) then
        vim.notify('[Warning Harpoon] invalid file', vim.log.levels.WARN)
        return
    end

    if not harpoon_file then
        vim.notify("[Warning Harpoon] can't create harpoon file", vim.log.levels.WARN)
        return
    end

    if vim.tbl_contains(vim.fn.readfile(harpoon_file), file) then
        vim.notify('[Warning Harpoon] already exists in harpoon file', vim.log.levels.WARN)
        return
    end

    vim.fn.writefile({ file }, harpoon_file, 'a')
    vim.notify('[Info Harpoon] add file: ' .. file)
end

vim.keymap.set('n', '<leader>e', toggle, { silent = true, desc = 'Harpoon toggle' })
vim.keymap.set('n', '<leader>m', add, { silent = true, desc = 'Harpoon add' })




---- ## Harpoon
--local harpoon_dir = vim.fn.expand('~/.vim/harpoon/')
--local augroup = vim.api.nvim_create_augroup('HarpoonAutoSave', { clear = true })
--
--local harpoon_win = nil
--
--local function warn(msg)
--    vim.notify('[Warning Harpoon] ' .. msg, vim.log.levels.WARN)
--end
--
--local function info(msg)
--    vim.notify('[Info Harpoon] ' .. msg, vim.log.levels.INFO)
--end
--
--local function is_invalid(path)
--    return path == '' or vim.startswith(path, harpoon_dir) or vim.fn.isdirectory(path) == 1
--end
--
---- 每個 cwd 對應一個 harpoon 檔，路徑中的 '/' 轉成 '%'
--local function get_harpoon_file()
--    vim.fn.mkdir(harpoon_dir, 'p')
--    local name = vim.fn.getcwd():gsub('/', '%%') -- 只取第一個回傳值
--    local file = harpoon_dir .. name
--    vim.fn.writefile({}, file, 'a') -- 確保檔案存在
--    return file
--end
--
--local function is_harpoon_win_open()
--    return harpoon_win ~= nil and vim.api.nvim_win_is_valid(harpoon_win)
--end
--
--local function close_harpoon_win()
--    if is_harpoon_win_open() then
--        vim.api.nvim_win_close(harpoon_win, true)
--    end
--    harpoon_win = nil
--end
--
--local function jump()
--    local file = vim.trim(vim.api.nvim_get_current_line())
--    if vim.fn.filereadable(file) == 0 then
--        return warn('file not found: ' .. file)
--    end
--
--    close_harpoon_win()
--    vim.cmd.edit(file)
--    -- rename file path according to the root
--    vim.cmd.cd(vim.fn.getcwd())
--end
--
--local function setup_buffer(buf)
--    local opts = { buffer = buf, silent = true }
--
--    vim.keymap.set('n', '<CR>', jump, opts)
--    vim.keymap.set('n', 'q', close_harpoon_win, opts)
--    vim.keymap.set('n', '<Esc>', close_harpoon_win, opts)
--
--    -- disable command line
--    local nop_opts = vim.tbl_extend('force', opts, { nowait = true })
--    for _, lhs in ipairs({ ':', 'q:', 'Q', 'gQ' }) do
--        vim.keymap.set({ 'n', 'x' }, lhs, '<Nop>', nop_opts)
--    end
--
--    -- auto save (先清除舊的，避免重複開啟時 autocmd 累積)
--    vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
--    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'BufLeave' }, {
--        group = augroup,
--        buffer = buf,
--        callback = function()
--            vim.cmd('silent! write')
--        end,
--    })
--end
--
--local function open_harpoon_win()
--    local buf = vim.fn.bufadd(get_harpoon_file())
--    vim.fn.bufload(buf)
--
--    -- 全螢幕浮動視窗
--    harpoon_win = vim.api.nvim_open_win(buf, true, {
--        relative = 'editor',
--        width = vim.o.columns,
--        height = vim.o.lines,
--        row = 0,
--        col = 0,
--        style = 'minimal',
--        border = 'rounded',
--        title = ' Harpoon ',
--        -- title_pos = 'center',
--    })
--
--    setup_buffer(buf)
--end
--
--local function toggle()
--    if is_harpoon_win_open() then
--        close_harpoon_win()
--    else
--        open_harpoon_win()
--    end
--end
--
--local function add()
--    local file = vim.fn.expand('%:p')
--    if is_invalid(file) then
--        return warn('invalid file')
--    end
--
--    local harpoon_file = get_harpoon_file()
--    if vim.tbl_contains(vim.fn.readfile(harpoon_file), file) then
--        return warn('already exists in harpoon file')
--    end
--
--    vim.fn.writefile({ file }, harpoon_file, 'a')
--    info('add file: ' .. file)
--end
--
--vim.keymap.set('n', '<leader>e', toggle, { silent = true, desc = 'Harpoon toggle' })
--vim.keymap.set('n', '<leader>m', add, { silent = true, desc = 'Harpoon add' })
