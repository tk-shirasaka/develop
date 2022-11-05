local group = vim.api.nvim_create_augroup('rc', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    group = group,
    callback = function() vim.highlight.on_yank({ timeout = 200 }) end
})
