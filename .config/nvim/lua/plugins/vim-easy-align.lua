return {
    -- https://github.com/junegunn/vim-easy-align
    'junegunn/vim-easy-align',
    --event = {'BufRead', 'BufNewFile'},
    event = "VeryLazy",
    config = function ()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
    end
}
