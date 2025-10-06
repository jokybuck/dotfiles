vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'typescript',
    'javascript',
    'json',
    'lua',
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
