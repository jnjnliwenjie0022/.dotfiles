--https://github.com/agalea91/dotfiles/blob/main/nvim/lua/plugins/obsidian.lua
return {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = "VeryLazy",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "obs",
                path = "/mnt/c/obs",
            },
        },
        mappings = {
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
        },
    },
}
