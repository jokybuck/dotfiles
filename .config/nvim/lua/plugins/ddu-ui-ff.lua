local M = {}

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
  -- choose action
  vim.keymap.set({ 'n' }, ';', "<Cmd>call ddu#ui#do_action('chooseAction')<Cr>", opts)
  -- input action
  vim.keymap.set({ 'n' }, ':', "<Cmd>call ddu#ui#do_action('inputAction')<Cr>", opts)
  -- toggle item
  vim.keymap.set('n', '<Space>', "<Cmd>call ddu#ui#do_action('toggleSelectItem')<Cr>", opts)
  vim.keymap.set('n', '*', "<Cmd>call ddu#ui#do_action('toggleAllItems')<Cr>", opts)
end

M.hook_add = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'ddu-ff',
    callback = set_ff_keymaps,
  })
end

return M
