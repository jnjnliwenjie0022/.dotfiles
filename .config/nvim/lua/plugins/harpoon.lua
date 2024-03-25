--return {
--    -- https://github.com/ThePrimeagen/harpoon
--    'ThePrimeagen/harpoon',
--    dependencies = {
--        'nvim-lua/plenary.nvim'
--    },
--    config = function ()
--        local mark = require("harpoon.mark")
--        local ui = require("harpoon.ui")
--
--        require('harpoon').setup({
--            tabline = false,
--            menu = {
--                width = vim.api.nvim_win_get_width(0) - 22,
--            }
--        })
--
--        vim.cmd [[ hi HarpoonNumberActive   guifg=#000000 guibg=#d7ff00 ]]
--        vim.cmd [[ hi HarpoonActive         guifg=#000000 guibg=#d7ff00 ]]
--        vim.cmd [[ hi HarpoonInactive       guifg=#cdd6f4 guibg=#262626 ]]
--        vim.cmd [[ hi HarpoonNumberInactive guifg=#cdd6f4 guibg=#262626 ]]
--        vim.cmd [[ hi TabLineFill           guifg=#cdd6f4 guibg=#262626 ]]
--
--        vim.keymap.set("n", "<leader>,", function()
--            local file_path = vim.fn.expand('%:p')
--            print("Hook on harpoon:", file_path)
--            mark.add_file()
--        end)
--        vim.keymap.set("n", "<leader>m", function()
--            require('harpoon').setup({
--                tabline = false,
--                menu = {
--                    width = vim.api.nvim_win_get_width(0) - 22,
--                }
--            })
--            ui.toggle_quick_menu()
--        end)
--        vim.keymap.set("n", "<leader>n", function() ui.nav_next() end)
--        vim.keymap.set("n", "<leader>h", function() ui.nav_file(1) end)
--        vim.keymap.set("n", "<leader>j", function() ui.nav_file(2) end)
--        vim.keymap.set("n", "<leader>k", function() ui.nav_file(3) end)
--        vim.keymap.set("n", "<leader>l", function() ui.nav_file(4) end)
--        vim.keymap.set("n", "<leader>;", function() ui.nav_file(5) end)
--    end
--}

return {
    --https://github.com/ThePrimeagen/harpoon/tree/harpoon2
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function ()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = false,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        vim.keymap.set("n", "<leader>,", function()
            local file_path = vim.fn.expand('%:p')
            harpoon:list():append()
            print("Hook on harpoon:", file_path)
        end)
        vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end)
    end
}
