-- lua_add {{{

vim.api.nvim_create_user_command('DduFiler', function()
  vim.fn['ddu#start']({
    name = 'filer',
    ui = 'filer',
    sources = {
      {
        name = 'file',
        params = {
          path = vim.fn.expand('%:p:h'),
        },
      },
    },
  })
end, {})

local function set_filer_keymaps()
  local opts = { noremap = true, silent = true, buffer = true }
  -- 展開・折りたたみ
  vim.keymap.set('n', 'o', "<Cmd>call ddu#ui#do_action('expandItem', { 'mode': 'toggle' })<Cr>", opts)
  -- open
  vim.keymap.set('n', '<Cr>', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'open' })<Cr>", opts)
  -- cd directory
  vim.keymap.set('n', 'l', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow' })<Cr>", opts)
  vim.keymap.set('n', 'h', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '..' } })<Cr>", opts)
  vim.keymap.set('n', '~', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '~'->expand() } })<Cr>", opts)
  vim.keymap.set('n', '=', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': getcwd() } })<Cr>", opts)
  -- history
  vim.keymap.set('n', 'H', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'path_history' })<Cr>", opts)
  -- 
  vim.keymap.set('n', '<Space>', "<Cmd>call ddu#ui#do_action('toggleSelectItem')<Cr>", opts)
  vim.keymap.set('n', '*', "<Cmd>call ddu#ui#do_action('toggleAllItem')<Cr>", opts)
  --
  vim.keymap.set('n', 'i', "<Cmd>call ddu#ui#do_action('openFilterWindow')<Cr>", opts)
  --
  vim.keymap.set('n', 'a', "<Cmd>call ddu#ui#do_action('chooseAction')<Cr>", opts)
  --
  vim.keymap.set('n', 'A', "<Cmd>call ddu#ui#do_action('inputAction')<Cr>", opts)
  -- preview
  vim.keymap.set('n', 'p', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'preview' })<Cr>", opts)
  -- close
  vim.keymap.set('n', 'q', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
  vim.keymap.set('n', '<Esc>', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-filer',
  callback = set_filer_keymaps,
})
-- }}}

-- lua_source {{{

-- }}}
