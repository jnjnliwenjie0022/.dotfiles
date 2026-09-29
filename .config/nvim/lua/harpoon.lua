-- ## Harpoon
local harpoon_dir = vim.fn.expand('~/.vim/harpoon/')

local state = {
  session_file = nil, -- 第一次開啟的檔案決定 session (與原本行為相同)
  win = nil,          -- 浮動視窗 id
  prev_win = nil,     -- 開啟前所在的視窗
}

-- 排除 harpoon 檔案、空路徑、特殊 buffer 與目錄
local function in_harpoon_dir(path)
  return vim.startswith(path, vim.fn.fnamemodify(harpoon_dir, ':p'))
end

local function is_invalid(path)
  return path == ''
    or vim.bo.buftype ~= ''
    or vim.fn.isdirectory(path) == 1
    or in_harpoon_dir(path)
end

local function init_session()
  if state.session_file then
    return true
  end

  local anchor = vim.fn.expand('%:p')
  if is_invalid(anchor) then
    return false
  end

  vim.fn.mkdir(harpoon_dir, 'p')
  local safe_name = anchor:gsub('/', '%%') -- '%%' 是 gsub 替換字串中的字面 %
  local file = harpoon_dir .. safe_name   -- 這行是缺的

  if vim.fn.filereadable(file) == 0 then
    local ok, err = pcall(vim.fn.writefile, {}, file)
    if not ok then
      vim.notify('harpoon: ' .. tostring(err), vim.log.levels.ERROR)  -- 不要靜默吞錯
      return false
    end
  end

  state.session_file = file -- 全部成功才賦值
  return true
end

-- 用 augroup 包起來,重複 source 不會註冊兩次
vim.api.nvim_create_augroup('HarpoonInit', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = 'HarpoonInit',
  pattern = '*',
  callback = init_session,
})

local function close_float()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    -- 先存檔再關,bufhidden=wipe 會順便清掉 buffer
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

  close_float()
  if state.prev_win and vim.api.nvim_win_is_valid(state.prev_win) then
    vim.api.nvim_set_current_win(state.prev_win)
  end
  vim.cmd('edit ' .. vim.fn.fnameescape(target))
end

local function toggle()
  -- 已經開著就關閉
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    close_float()
    return
  end

  if not state.session_file then
    vim.notify("Can't open harpoon session", vim.log.levels.WARN)
    return
  end

  state.prev_win = vim.api.nvim_get_current_win()

  local buf = vim.fn.bufadd(state.session_file)
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

  -- buffer-local 設定
  vim.keymap.set('n', '<CR>', jump, { buffer = buf, silent = true })
  vim.keymap.set('n', 'q', close_float, { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', close_float, { buffer = buf, silent = true })

  -- 編輯時自動存檔
  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'BufLeave' }, {
    buffer = buf,
    callback = function()
      vim.cmd('silent! write')
    end,
  })
end
local function add()
  local current = vim.fn.expand('%:p')

  -- 1. 先判斷目前檔案能不能加入
  if is_invalid(current) then
    vim.notify('Cannot add this file to harpoon session', vim.log.levels.WARN)
    return
  end

  -- 2. session 不存在就以目前檔案建立
  if not init_session() then
    vim.notify("Can't create harpoon session", vim.log.levels.WARN)
    return
  end

  -- 3. 重複檢查
  local existing = vim.fn.readfile(state.session_file)
  if vim.tbl_contains(existing, current) then
    vim.notify('Already exists in harpoon session', vim.log.levels.WARN)
    return
  end

  -- 4. 寫入
  vim.fn.writefile({ current }, state.session_file, 'a')
  vim.notify('Add harpoon session: ' .. vim.fn.expand('%:t'))
end

vim.keymap.set('n', '<leader>e', toggle, { silent = true, desc = 'Harpoon toggle' })
vim.keymap.set('n', '<leader>m', add, { silent = true, desc = 'Harpoon add' })
