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

return require('packer').startup(function(use)
    -- https://github.com/wbthomason/packer.nvim
    use { 'wbthomason/packer.nvim' }
    -- https://vimcolorschemes.com/
    use { 'catppuccin/nvim' }
    -- https://github.com/ThePrimeagen/harpoon
    use {
        'ThePrimeagen/harpoon',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- https://github.com/nvim-telescope/telescope.nvim
    use {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- https://github.com/junegunn/vim-easy-align
    use { 'junegunn/vim-easy-align' }
    -- https://github.com/tpope/vim-fugitive
    use { 'tpope/vim-fugitive'}
    -- https://github.com/dstein64/vim-startuptime
    use { 'dstein64/vim-startuptime' }
end)
