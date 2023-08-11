local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", function()
    mark.add_file()
    ui.toggle_quick_menu()
    ui.toggle_quick_menu()
end)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>n", ui.nav_next)
vim.keymap.set("n", "<leader>j", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>k", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>l", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>;", function() ui.nav_file(4) end)

require('harpoon').setup({
    tabline = true,
    tabline_prefix = " ",
    tabline_suffix = " ",
})

vim.cmd [[ hi HarpoonNumberActive   guifg=#000000 guibg=#d7ff00 ]]
vim.cmd [[ hi HarpoonActive         guifg=#000000 guibg=#d7ff00 ]]
vim.cmd [[ hi HarpoonInactive       guifg=#cdd6f4 guibg=#262626 ]]
vim.cmd [[ hi HarpoonNumberInactive guifg=#cdd6f4 guibg=#262626 ]]
vim.cmd [[ hi TabLineFill           guifg=#cdd6f4 guibg=#262626 ]]
