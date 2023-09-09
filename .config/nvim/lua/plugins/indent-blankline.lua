return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
        require("indent_blankline").setup {
            space_char_blankline = " ",
            show_current_context = true,
        }
    end
}
