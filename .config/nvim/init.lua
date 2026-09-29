-- ref: https://www.youtube.com/watch?v=otRvw9neQkg&t=1111s
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/lua/init.vim')
require('osc52')
require('find')
require('grep')
require('harpoon')
local ok, ai = pcall(require, "ai_visual")
if ok then
  ai.setup({
    cmd = { "claude", "-p" },  -- 依你的 CLI 調整
    keymap = "<leader>av",
  })
end
