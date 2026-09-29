-- ## Harpoon
local harpoon_path = vim.fn.expand('~/.vim/harpoon/')

local state = {
  win = nil,      -- 浮動視窗 id
  prev_win = nil, -- 開啟前所在的視窗
}

local function is_invalid(path)
  return path == '' or vim.startswith(path, harpoon_path)
end

local function session_file()
    -- create harpoon directory "~/.vim/harpoon/"
    vim.fn.mkdir(harpoon_path, 'p')

    -- create harpoon file
    local file_path = vim.fn.getcwd()
    local file = harpoon_path .. (file_path:gsub('/', '%%'))
    vim.fn.writefile({}, file, 'a')

    return file
end

local function close_window()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.cmd('silent! write')
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
end

local function jump()
  local target = vim.trim(vim.api.nvim_get_current_line())
  if target == '' then
    return
  end

  close_window()
  if state.prev_win and vim.api.nvim_win_is_valid(state.prev_win) then
    vim.api.nvim_set_current_win(state.prev_win)
  end
  vim.cmd('edit ' .. vim.fn.fnameescape(target))
end

local function toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    close_window()
    return
  end

  local file = session_file()
  if not file then
    vim.notify("Can't open harpoon session", vim.log.levels.WARN)
    return
  end

  state.prev_win = vim.api.nvim_get_current_win()

  local buf = vim.fn.bufadd(file)
  vim.fn.bufload(buf)
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].buflisted = false

  local width = math.floor(vim.o.columns)
  local height = math.floor(vim.o.lines)
  state.win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Harpoon ',
    title_pos = 'center',
  })

  vim.keymap.set('n', '<CR>', jump, { buffer = buf, silent = true })
  vim.keymap.set('n', 'q', close_window, { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', close_window, { buffer = buf, silent = true })

  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'BufLeave' }, {
    buffer = buf,
    callback = function()
      vim.cmd('silent! write')
    end,
  })
end

local function add()
  local current = vim.fn.expand('%:p')

  if is_invalid(current) then
    vim.notify('[Warning] harpoon: invalid file', vim.log.levels.WARN)
    return
  end

  local file = session_file()
  if not file then
    vim.notify("Can't create harpoon session", vim.log.levels.WARN)
    return
  end

  local existing = vim.fn.readfile(file)
  if vim.tbl_contains(existing, current) then
    vim.notify('Already exists in harpoon session', vim.log.levels.WARN)
    return
  end

  vim.fn.writefile({ current }, file, 'a')
  vim.notify('Add harpoon session: ' .. vim.fn.expand('%:t'))
end

vim.keymap.set('n', '<leader>e', toggle, { silent = true, desc = 'Harpoon toggle' })
vim.keymap.set('n', '<leader>m', add, { silent = true, desc = 'Harpoon add' })
