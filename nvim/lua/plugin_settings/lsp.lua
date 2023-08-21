-- Mason
require('mason').setup();
require('mason-lspconfig').setup({
    automatic_installation = true,
})

-- Efmls Configs
local languages = require('efmls-configs.defaults').languages()

-- Lsp Zero
local lsp = require('lsp-zero')
lsp.preset({
    name = 'recommended',
    manage_nvim_cmp = { set_format = false },
})
lsp.set_sign_icons({ error = '', warn = '', hint = '', info = '' })
vim.diagnostic.config({ virtual_text = false })

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').efm.setup({ settings = { languages = languages } })

lsp.setup()

-- Glance
require('glance').setup()
