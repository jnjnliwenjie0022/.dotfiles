local status, telescope = pcall(require, 'telescope')
if (not status) then
    print("Telescope is not installed")
    return
end

local actions = require('telescope.actions')
telescope.setup {
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close
            },
        }
    }
}

local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>f', builtin.find_files, opts) 
vim.keymap.set('n', '<leader>/', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>g', builtin.git_files, opts) 

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 100,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
