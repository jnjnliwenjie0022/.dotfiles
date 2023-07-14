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

--vim.keymap.set('n', '<C-p>', builtin.git_files, {}) 
