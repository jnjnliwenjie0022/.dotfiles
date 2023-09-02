--https://sbulav.github.io/vim/neovim-setting-up-luasnip/
--https://www.youtube.com/watch?v=ub0REXjhpmk&ab_channel=ziontee113-Healthy-Director-702
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

--https://www.lua.org/pil/22.1.html
local date = function() return {os.date('%m/%d/%Y %H:%M:%S')} end
local file = function() return {vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())} end

local comment_head = s("comment_head", {
    t({   "/////////////////////////////////////////////////////////////////////////////////////////////////"}),
    t({"","//"}),
    t({"","// Author: jasonli LI,WEN-JIE"}),
    t({"","//"}),
    t({"","// LastMod: "}), f(date, {}),
    t({"","//"}),
    t({"","// Source: "}), f(file, {}),
    t({"","//"}),
    t({"","// Comment: "}), i(1, "N/A"),
    t({"","//"}),
    t({"","/////////////////////////////////////////////////////////////////////////////////////////////////"}),
    t({""})
})

ls.add_snippets(nil, {
    all = {comment_head}
})
