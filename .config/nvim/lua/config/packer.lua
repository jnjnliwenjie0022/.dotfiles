local status, packer = pcall(require, 'packer')
if (not status) then
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

    print("Packer is not installed")
    print("Auto-install packer at " .. install_path)

    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]

    print("---------------------------------------")
    print("Following the step and restart neovim!!")
    print("In packer.lua")
    print("1. :so")
    print("2. :PackerSync")
    print("---------------------------------------")

    return
end

return packer.startup(function(use)
    -- https://github.com/wbthomason/packer.nvim
    use { 'wbthomason/packer.nvim' }
    -- https://vimcolorschemes.com/
    use { 'catppuccin/nvim' }
    -- https://github.com/nvim-telescope/telescope.nvim
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = {
            {'nvim-lua/plenary.nvim'}
        }
    }
    -- https://github.com/ThePrimeagen/harpoon
    use {
        'ThePrimeagen/harpoon',
        requires = {
            {'nvim-lua/plenary.nvim'}
        }
    }
    -- https://github.com/tpope/vim-fugitive
    use { 'tpope/vim-fugitive'}
    -- https://github.com/junegunn/vim-easy-align
    use { 'junegunn/vim-easy-align' }
    -- https://github.com/mbbill/undotree
    use {"mbbill/undotree" }
    -- https://github.com/dstein64/vim-startuptime
    use { 'dstein64/vim-startuptime' }
    -- https://github.com/ludovicchabant/vim-gutentags
    --use { 'ludovicchabant/vim-gutentags' }
    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- A collection of configurations for Neovim's built-in LSP
            {'williamboman/mason.nvim'}, -- Portable package manager for Neovim that runs everywhere Neovim runs
            {'williamboman/mason-lspconfig.nvim'}, -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim

            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- A completion engine plugin for neovim written in Lua
            {'hrsh7th/cmp-buffer'}, -- nvim-cmp source for buffer words
            {'hrsh7th/cmp-path'}, -- nvim-cmp source for path words
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'}, -- nvim-cmp source for neovim's built-in LSP
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'}, -- Snippet Engine for Neovim written in Lua
            {'rafamadriz/friendly-snippets'},
        }
    }
end)
