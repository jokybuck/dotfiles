-- lua_add {{{

local function set_ff_keymaps()
  local opts = { noremap = true, silent = true, buffer = true }
  -- UIを閉じる
  vim.keymap.set({ 'n' }, 'q', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
  vim.keymap.set({ 'n' }, '<Esc>', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
  --
  vim.keymap.set({ 'n' }, '<Cr>', "<Cmd>call ddu#ui#do_action('itemAction')<Cr>", opts)
  --
  vim.keymap.set({ 'n' }, 'i', "<Cmd>call ddu#ui#do_action('openFilterWindow')<Cr>", opts)
  -- プレビュー
  vim.keymap.set({ 'n' }, 'p', "<Cmd>call ddu#ui#do_action('togglePreview')<Cr>", opts)
end

vim.api.nvim_create_autocmd('FileType',{
  pattern = 'ddu-ff',
  callback = set_ff_keymaps,
})

local function set_ff_filter_keymaps()
  local opts = { noremap = true, silent = true, buffer = true }
  vim.keymap.set({ 'i' }, '<Cr>', function()
    vim.cmd.stopinsert()
    vim.fn['ddu#ui#do_action']('closeFilterWindow')
  end, opts)
  vim.keymap.set({ 'n' }, '<Cr>', "<Cmd>call ddu#ui#do_action('closeFilterWindow')<Cr>", opts)
end

--}}}

-- lua_source {{{
-- }}}
