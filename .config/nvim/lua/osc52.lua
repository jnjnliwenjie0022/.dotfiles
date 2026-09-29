local function osc52_copy(lines, _)
  local text = table.concat(lines, '\n')
  local r = vim.system({ vim.fn.expand('y'), '-s' }, { stdin = text }):wait()
  if r.code == 0 and r.stdout ~= '' then
    vim.api.nvim_ui_send(r.stdout)
    vim.notify('Yank')
  else
    vim.notify('OSC52 Copy Failed: ' .. (r.stderr or ''), vim.log.levels.WARN)
  end
end

local function osc52_paste()
  return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
end

vim.g.clipboard = {
  name = 'OSC52 Bash',
  copy  = { ['+'] = osc52_copy, ['*'] = osc52_copy },
  paste = { ['+'] = osc52_paste, ['*'] = osc52_paste },
}
