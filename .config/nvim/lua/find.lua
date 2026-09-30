-- 取得檔案的 last-position (`"` mark),沒有就回傳 1, 1
local function last_position(file)
  if vim.fn.isdirectory(file) == 1 then
    return 1, 1
  end

  --  QuickFix 的 lnum / col 是每個 entry 各自的欄位,
  --  所以要在建立 list 時就幫每個檔案查出它的 " mark。
  --  " mark 是 buffer-local 的(存在 shada 裡),
  --  檔案必須先載入成 buffer 才讀得到,做法是 bufadd + bufload,
  --  再用 nvim_buf_get_mark
  local buf = vim.fn.bufadd(file)
  local was_loaded = vim.api.nvim_buf_is_loaded(buf)
  if not was_loaded then
    vim.fn.bufload(buf)
  end

  local ok, mark = pcall(vim.api.nvim_buf_get_mark, buf, '"')
  local line_count = vim.api.nvim_buf_line_count(buf)

  -- 只卸載我們自己載入的 buffer,不影響使用者原本開著的
  if not was_loaded then
    vim.api.nvim_buf_delete(buf, { unload = true })
  end

  if not ok or mark[1] < 1 or mark[1] > line_count then
    return 1, 1
  end
  return mark[1], mark[2] + 1 -- nvim mark 的 col 是 0-based,quickfix 是 1-based
end

local function pick_to_quickfix(cmd)
  -- 你的檔案清單來源,可以換成任何 shell pipeline
  -- 這裡用它是因為 fzf 要在終端機裡顯示互動介面,
  -- 你的 Lua 通常是用 terminal buffer(如 termopen)去跑它,
  -- stdout 不好直接抓。所以做法是:
  -- fzf --multi > tmpfile,把選取結果寫進暫存檔
  -- 程序結束後,再用 Lua 讀 tmpfile 的內容,拿到使用者選了哪些檔案
  print("cmd")
  local tmpfile = vim.fn.tempname()
  local cmd = string.format('%s > %s', cmd, tmpfile)
  print("cmd: %s", cmd)

  -- 開一個乾淨的浮動視窗當 fzf 的畫布
  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns)
  local height = math.floor(vim.o.lines)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.jobstart(cmd, {
    term = true,
    on_exit = function()
      -- 關掉浮動視窗
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end

      local ok, lines = pcall(vim.fn.readfile, tmpfile)
      vim.fn.delete(tmpfile)
      if not ok or #lines == 0 then
        return
      end

      local qf_list = vim.tbl_map(function(f)
        local lnum, col = last_position(f)
        return { filename = f, lnum = lnum, col = col }
      end, lines)

      vim.fn.setqflist(qf_list, 'r')

      if #qf_list > 1 then
        vim.cmd('copen')
      else
        vim.cmd('cfirst')
      end
    end,
  })

  vim.cmd('startinsert')
end

local function files()
    pick_to_quickfix('files')
end

local function gfiles()
    pick_to_quickfix('gfiles')
end

vim.keymap.set('n', '<leader>f', files, { desc = 'FZF find files' })
vim.keymap.set('n', '<leader>g', gfiles, { desc = 'FZF git files' })
