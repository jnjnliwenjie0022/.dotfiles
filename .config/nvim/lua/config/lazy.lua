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

-- https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/lazy.lua
require("lazy").setup({import = "plugins"})
