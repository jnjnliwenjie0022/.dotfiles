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
vim.keymap.set('n', '<leader>f', builtin.find_files, {}) 
--vim.keymap.set('n', '<C-p>', builtin.git_files, {}) 
vim.keymap.set('n', '<leader>/', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
