local status, n = pcall(require, "plenary")
if (not status) then
    print("Plenary is not installed, Harpoon can't work")
    return 
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>v", mark.add_file)
vim.keymap.set("n", "<leader>b", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>n", ui.nav_next)
vim.keymap.set("n", "<leader>N", ui.nav_prev)
--vim.keymap.set("n", "<C-e>", Telescope harpoon marks<CR>)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
