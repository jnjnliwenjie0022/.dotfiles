return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function ()
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
                    i = {
                        ["<C-j>"] = actions.select_default,
                    },
                },
            },

            pickers = {
                tags = {
                    show_line = true,
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
        vim.keymap.set('n', '<leader>q', function()
            builtin.quickfix({
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.9,
                    height = 0.9,
                },
                hidden = false,
                previewer = true,
            })
        end, opts)
        --https://github.com/CallumHoward/dotfiles/blob/aa82542ca240405022d8e3c636da3674282d4db8/.config/nvim/lua/plugins/telescope_config.lua#L8
        --https://www.youtube.com/watch?v=2LSGlOgI9Cg
        --https://github.com/isak102/telescope-git-file-history.nvim/blob/master/lua/telescope/_extensions/git_file_history.lua#L121
        --https://github.com/isak102/telescope-git-file-history.nvim/blob/master/lua/telescope/_extensions/git_file_history.lua#L93
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")
        local previewers = require("telescope.previewers")
        local changed_on_branch = function()
          pickers
            .new({
              results_title = "Modified on current branch",
              --finder = finders.new_oneshot_job({
              --  "git",
              --  "diff",
              --  "--name-only",
              --  "--relative",
              --  "master",
              --}),
              finder = finders.new_oneshot_job({
                "git",
                "ls",
              }),
              sorter = sorters.get_fuzzy_file(),
              previewer = previewers.new_termopen_previewer({
                get_command = function(entry, status)
                  --return { "git", "diff", "--relative", "master", entry.value }
                  --return {entry.value}
                    return { 'echo', entry.value }
                end,
              }),
            })
            :find()
        end
        vim.api.nvim_create_user_command("MB", changed_on_branch, {})
        vim.keymap.set("n", "<leader>d", changed_on_branch)
    end
}
