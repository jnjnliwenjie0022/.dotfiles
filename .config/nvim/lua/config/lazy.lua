local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then

    print("Lazy is not installed")
    print("Auto-install Lazy at: " .. path)
    print("Wait for installing")

    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        path,
    })
end

vim.opt.rtp:prepend(path)

local plugins = {
    -- https://github.com/dstein64/vim-startuptime
    { 'dstein64/vim-startuptime'},
    -- https://vimcolorschemes.com/
    { 'catppuccin/nvim' },
    -- https://github.com/nvim-telescope/telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
    },
    -- https://github.com/ThePrimeagen/harpoon
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            {'nvim-lua/plenary.nvim'}
        },
    },
    -- https://github.com/tpope/vim-fugitive
    { 'tpope/vim-fugitive'},
    -- https://github.com/junegunn/vim-easy-align
    { 'junegunn/vim-easy-align', event = {'BufRead', 'BufNewFile'}},
    -- https://github.com/ludovicchabant/vim-gutentags
    --{ 'ludovicchabant/vim-gutentags' }
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        --run = function()
        --    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        --    ts_update()
        --end,
        event = {'BufRead', 'BufNewFile'}
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- LSP configurations "Engine" (Required)
            {'williamboman/mason.nvim'}, -- Portable package manager for Neovim that runs everywhere Neovim runs
            {'williamboman/mason-lspconfig.nvim'}, -- Extension to mason.nvim that makes it easier to lspconfig with mason.nvim

            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Completion "Engine" (Required)
            {'hrsh7th/cmp-nvim-lsp'}, -- nvim-cmp source plugin for auto-completion from lsp (Required)
            {'hrsh7th/cmp-nvim-lua'}, -- nvim-cmp source plugin for auto-completion form lua
            {'hrsh7th/cmp-buffer'}, -- nvim-cmp source plugin for auto-completion from buffer
            {'hrsh7th/cmp-cmdline'}, -- nvim-cmp source plugin for auto-completion from buffer
            {'hrsh7th/cmp-path'}, -- nvim-cmp source plugin for auto-completion from path
            {'saadparwaiz1/cmp_luasnip'}, -- nvim-cmp plugin for auto-completion from snip

            -- Snippets
            {'L3MON4D3/LuaSnip'}, -- Snippet "Engine" (Required)
            {'rafamadriz/friendly-snippets'}, -- a bunch of snippets to use
        }
    },

}

local opts = {};

require("lazy").setup(plugins, opts)
