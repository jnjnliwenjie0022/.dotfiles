local lsp = require("lsp-zero")

lsp.preset("recommended")

function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

local file = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/lua-language-server"
if file_exists(file) then
    require('lspconfig').lua_ls.setup({
        cmd = {os.getenv("HOME") .. "/.local/share/nvim/mason/bin/lua-language-server"};
        settings = {
            Lua = {
                -- Tell the language server which version of Lua you're using
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostic = {
                    global = { 'vim' }
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    library = { vim.env.VIMRUNTIME }
                }
            }
        }
    })
end

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

--vim.diagnostic.disable()
vim.diagnostic.config({
    virtual_text = true
})
