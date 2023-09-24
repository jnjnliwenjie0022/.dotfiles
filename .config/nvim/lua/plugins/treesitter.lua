return {
    'nvim-treesitter/nvim-treesitter',
    --event = {'BufRead', 'BufNewFile'},
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require'nvim-treesitter.configs'.setup {
            sync_install = false,
            auto_install = false,
            --parser_install_dir = "$HOME/.local/lib/nvim/parser",
            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }
        --vim.opt.runtimepath:append("$HOME/.local/lib/nvim/parser")
    end
}
