vim.cmd('source ' .. vim.fn.stdpath('config') .. '/lua/init.vim')
require('osc52')
require('files')
require('harpoon')
local ok, ai = pcall(require, "ai_visual")
if ok then
  ai.setup({
    cmd = { "claude", "-p" },  -- 依你的 CLI 調整
    keymap = "<leader>av",
  })
end
