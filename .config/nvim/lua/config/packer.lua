local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

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
    --https://github.com/junegunn/vim-easy-align
    use { 'junegunn/vim-easy-align' }
    --https://github.com/tpope/vim-fugitive
    use { 'tpope/vim-fugitive'}
    -- https://github.com/mbbill/undotree
    use { 'mbbill/undotree'}
end)
