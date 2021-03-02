-- Menu
vim.cmd([[
    amenu <silent> 40.01 .ﲵ\ Console             :lua require('dap').repl.toggle()<cr>
    amenu <silent> 40.02 .\ Breakpoint          :lua require('dap').toggle_breakpoint()<cr>
    amenu <silent> 40.03 .\ Start\ /\ Continue  :lua require('dap').continue()<cr>
    amenu <silent> 40.04 .\ Step\ Over          :lua require('dap').step_over()<cr>
    amenu <silent> 40.05 .\ Step\ Into          :lua require('dap').step_into()<cr>
    amenu <silent> 40.06 .\ Step\ Out           :lua require('dap').step_out()<cr>
    amenu <silent> 40.07 .倫\ Step\ Back         :lua require('dap').step_back()<cr>
    amenu <silent> 40.08 .\ Up                  :lua require('dap').up()<cr>
    amenu <silent> 40.09 .\ Down                :lua require('dap').down()<cr>
    amenu <silent> 40.10 .\ Viewer              :lua require('dap.ui.variables').hover()<cr>
    vmenu <silent> 40.10 .\ Viewer              :lua require('dap.ui.variables').visual_hover()<cr>
    amenu <silent> 40.11 .\ Breakpoints         :lua require('dap').list_breakpoints()<cr>
]])

-- Configs
local dap = require('dap')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/usr/local/bin/php-debug/extension/out/phpDebug.js' },
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        hostname = '0.0.0.0',
        stopOnEntry = false,
        serverSourceRoot = '/project/',
        localSourceRoot = '/project/',
    },
}

dap.adapters.firefox = {
    type = 'executable',
    command = 'node',
    args = { '/usr/local/bin/vscode-firefox-debug/extension/dist/adapter.bundle.js' },
}


local webapps = {
}

local filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
local configurations = { }

for domain, root in pairs(webapps) do
    table.insert(configurations, {
        type = 'firefox',
        request = 'attach',
        name = 'Listen for '..domain,
        host = '[hostname]',
        url = 'http://'..domain..'.localhost',
        webRoot = '${workspaceFolder}',
        pathMappings = {
            { url = 'http://'..domain..'.localhost', path = '${webRoot}'..root },
            { url = 'file://', path = '${webRoot}' },
        },
    })
end

for _, filetype in ipairs(filetypes) do
    dap.configurations[filetype] = configurations
end

dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    custom_commands = {
        ['.restart'] = dap.restart,
    }
})

vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='DiffAdd', numhl='DiffAdd'})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='DiffChange', numhl='DiffChange'})