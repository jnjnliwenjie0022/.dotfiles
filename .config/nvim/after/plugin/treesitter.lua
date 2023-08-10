local config = require('nvim-treesitter.configs')
config.setup {
    sync_install = false,
    auto_install = false,
    parser_install_dir = "$HOME/.config/nvim/parser",
    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
vim.opt.runtimepath:append("$HOME/.config/nvim/parser")

-- FIXED WARNING:
-- OK `tree-sitter` found 0.20.8 (d4c1bf7ce78051b7f4a381d1508d68928512ed5f) (parser generator, only needed for :TSInstallFromGrammar)
-- OK `node` found v12.22.9 (only needed for :TSInstallFromGrammar)
-- sudo apt-get install npm
-- sudo npm install -g tree-sitter-cli
