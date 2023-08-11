local status, telescope = pcall(require, 'telescope')
if (not status) then return end

--keymaps: $HOME/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/mappings.lua
local actions = require('telescope.actions')
telescope.setup {
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close,
            },
        },
    },
    pickers = {
        tags = {
            only_sort_tags = true,
            fname_width = 100
        },
    },
}

local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>f', function()
    builtin.find_files({
        layout_strategy = "vertical",
        layout_config = {
            width = 0.9,
            height = 0.9,
        },
        hidden = true,
        previewer = false,
    })
end, opts)
vim.keymap.set('n', '<leader>g', function()
    builtin.git_files({
        layout_strategy = "vertical",
        layout_config = {
            width = 0.9,
            height = 0.9,
        },
        hidden = true,
        previewer = false,
    })
end, opts)
vim.keymap.set('n', '<leader>/', function()
    builtin.live_grep({
        layout_strategy = "vertical",
        layout_config = {
            width = 0.9,
            height = 0.9,
        },
        hidden = false,
        previewer = true,
    })
end, opts)
vim.keymap.set('n', '<leader>t', function()
    builtin.tags({
        layout_strategy = "vertical",
        layout_config = {
            width = 0.9,
            height = 0.9,
        },
        hidden = false,
        previewer = true,
    })
end, opts)
