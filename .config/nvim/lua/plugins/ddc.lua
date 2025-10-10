local M = {}

function CommandlinePost()
  vim.keymap.del('c', '<Tab>')
  vim.keymap.del('c', '<S-Tab>')
  vim.keymap.del('c', '<C-n>')
  vim.keymap.del('c', '<C-p>')
  vim.keymap.del('c', '<C-y>')
  vim.keymap.del('c', '<C-e>')
end

function CommandlinePre()
  vim.keymap.set('c', '<Tab>', '<Cmd>call pum#map#insert_relative(+1)<CR>')
  vim.keymap.set('c', '<S-Tab>', '<Cmd>call pum#map#insert_relative(-1)<CR>')
  vim.keymap.set('c', '<C-n>', '<Cmd>call pum#map#insert_relative(+1)<CR>')
  vim.keymap.set('c', '<C-p>', '<Cmd>call pum#map#insert_relative(-1)<CR>')
  vim.keymap.set('c', '<C-y>', '<Cmd>call pum#map#confirm()<CR>')
  vim.keymap.set('c', '<C-e>', '<Cmd>call pum#map#cancel()<CR>')

  vim.api.nvim_create_autocmd('User', {
    pattern = 'DDCCmdlineLeave',
    once = true,
    callback = function()
      CommandlinePost()
    end,
  })

  -- 次のコマンドラインで補完を有効化
  vim.fn['ddc#enable_cmdline_completion']()
end

M.hook_add = function()
  -- vim.keymap.set('n', ':', '<Cmd>lua CommandlinePre()<Cr>:')
end

M.hook_source = function()
  local path = vim.fn.expand('$BASE_DIR/denops/ddc.ts')
  vim.fn['ddc#custom#load_config'](path)

  -- TAB キー
  vim.keymap.set('i', '<Tab>', function()
    if vim.fn['pum#visible']() then
      return '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>'
    elseif vim.fn.col('.') <= 1 then
      return '<Tab>'
    elseif vim.fn.getline('.'):sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1):match('%s') then
      return '<Tab>'
    else
      return vim.fn['ddc#map#manual_complete']()
    end
  end, { expr = true, noremap = true, silent = true })
  -- Shift + TAB キー
  vim.api.nvim_set_keymap(
    'i',
    '<S-Tab>',
    '<Cmd>call pum#map#insert_relative(-1)<CR>',
    { noremap = true, silent = true }
  )
  -- Ctrl + N キー
  vim.api.nvim_set_keymap('i', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>', { noremap = true, silent = true })
  -- Ctrl + P キー
  vim.api.nvim_set_keymap('i', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>', { noremap = true, silent = true })
  -- Ctrl + Y キー
  vim.api.nvim_set_keymap('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', { noremap = true, silent = true })
  -- Ctrl + E キー
  vim.api.nvim_set_keymap('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', { noremap = true, silent = true })

  -- vim.fn['ddc#enable_terminal_completion']()
  vim.fn['ddc#enable_cmdline_completion']()

  vim.fn['ddc#enable']({
    context_filetype = 'treesitter',
  })
end

return M
