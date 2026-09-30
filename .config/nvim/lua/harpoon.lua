-- ## Harpoon
local harpoon_path = vim.fn.expand('~/.vim/harpoon/')

local state = {
  harpoon_win = nil,
  parent_win = nil,
}

local function is_invalid(path)
  return path == '' or vim.startswith(path, harpoon_path)
end

local function get_harpoon_file()
    -- create harpoon directory "~/.vim/harpoon/"
    vim.fn.mkdir(harpoon_path, 'p')

    -- create harpoon file
    local file_path = vim.fn.getcwd()
    local file = harpoon_path .. (file_path:gsub('/', '%%'))
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
    if state.parent_win and vim.api.nvim_win_is_valid(state.parent_win) then
        vim.api.nvim_set_current_win(state.parent_win)
    end
    vim.cmd.edit(file)
end

local function open_harpoon_win()
    state.parent_win = vim.api.nvim_get_current_win()

    local buf = vim.fn.bufadd(get_harpoon_file())
    vim.fn.bufload(buf)
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].swapfile = false
    vim.bo[buf].buflisted = false

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
        title_pos = 'center',
    })

    vim.keymap.set('n', '<CR>', jump, { buffer = buf, silent = true })
    vim.keymap.set('n', 'q', close_harpoon_win, { buffer = buf, silent = true })
    vim.keymap.set('n', '<Esc>', close_harpoon_win, { buffer = buf, silent = true })

    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'BufLeave' }, {
        buffer = buf,
        callback = function()
            vim.cmd('silent! write')
        end,
    })
end

function toggle()
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
        vim.notify('[Warning hdwarpoon] invalid file', vim.log.levels.WARN)
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
