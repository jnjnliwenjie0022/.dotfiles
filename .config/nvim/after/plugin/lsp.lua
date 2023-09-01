local lsp = require("lsp-zero")

lsp.preset("recommended")
--need into install lua-language-server
--lsp.nvim_workspace() -- Fix Undefined global 'vim'

require('lspconfig').lua_ls.setup({
    cmd = {"/home/jnjn0022/.local/share/nvim/mason/bin/lua-language-server"};
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
})


lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    preselect = true,
    completion = {
        completeopt = 'menu,menuone,noinsert' -- highlighted the first completion item automatically
    },
})

vim.cmd [[set signcolumn=no]]
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
--vim.diagnostic.disable()

local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

--ls.add_snippets(nil, {
--    all = {
--        snip({
--            trig = "date",
--            namr = "Date",
--            dscr = "Date in the form of YYYY-MM-DD",
--        }, {
--            func(date, {}),
--        }),
--    },
--})

ls.add_snippets(nil, {
    all = {
snip({
    trig = "meta",
    namr = "Metadata",
    dscr = "Yaml metadata format for markdown"
},
{
    text({"---",
    "title: "}), insert(1, "note_title"), text({"",
    "author: "}), insert(2, "author"), text({"",
    "date: "}), func(date, {}), text({"",
    "categories: ["}), insert(3, ""), text({"]",
    "lastmod: "}), func(date, {}), text({"",
    "tags: ["}), insert(4), text({"]",
    "comments: true",
    "---", ""}),
    insert(0)
  }),
    },
})
