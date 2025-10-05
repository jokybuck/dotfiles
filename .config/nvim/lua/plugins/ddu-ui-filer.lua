local M = {}

local function set_filer_keymaps()
  local opts = { noremap = true, silent = true, buffer = true }
  -- 展開・折りたたみ
  vim.keymap.set('n', 'o', "<Cmd>call ddu#ui#do_action('expandItem', { 'mode': 'toggle' })<Cr>", opts)
  -- open
  vim.keymap.set('n', '<Cr>', function()
    local item = vim.fn['ddu#ui#get_item']()
    if item and item.action then
      if item.action.isDirectory then
        vim.fn['ddu#ui#do_action']('itemAction', { name = 'narrow' })
      else
        vim.fn['ddu#ui#do_action']('itemAction', { name = 'open' })
      end
    end
  end, opts)
  vim.keymap.set('n', '<Tab>', function()
    local item = vim.fn['ddu#ui#get_item']()
    if item and item.action then
      if item.action.isDirectory then
        vim.fn['ddu#ui#do_action']('itemAction', { name = 'narrow' })
      else
        vim.fn['ddu#ui#do_action']('itemAction', {
          name = 'open',
          params = { command = 'tabedit' },
        })
      end
    end
  end, opts)

  -- cd directory
  vim.keymap.set('n', 'l', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow' })<Cr>", opts)
  vim.keymap.set(
    'n',
    'h',
    "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '..' } })<Cr>",
    opts
  )
  vim.keymap.set(
    'n',
    '~',
    "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '~'->expand() } })<Cr>",
    opts
  )
  vim.keymap.set(
    'n',
    '=',
    "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': getcwd() } })<Cr>",
    opts
  )
  -- history
  vim.keymap.set('n', 'H', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'path_history' })<Cr>", opts)
  --
  vim.keymap.set('n', '<Space>', "<Cmd>call ddu#ui#do_action('toggleSelectItem')<Cr>", opts)
  vim.keymap.set('n', '*', "<Cmd>call ddu#ui#do_action('toggleAllItems')<Cr>", opts)
  --
  vim.keymap.set('n', 'i', "<Cmd>call ddu#ui#do_action('openFilterWindow')<Cr>", opts)
  --
  vim.keymap.set('n', 'a', "<Cmd>call ddu#ui#do_action('chooseAction')<Cr>", opts)
  --
  vim.keymap.set('n', 'A', "<Cmd>call ddu#ui#do_action('inputAction')<Cr>", opts)
  -- preview
  --vim.keymap.set('n', 'p', "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'preview' })<Cr>", opts)
  vim.keymap.set('n', 'p', "<Cmd>call ddu#ui#do_action('togglePreview')<Cr>", opts)
  -- close
  vim.keymap.set('n', 'q', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
  vim.keymap.set('n', '<Esc>', "<Cmd>call ddu#ui#do_action('quit')<Cr>", opts)
  -- split
  vim.keymap.set(
    'n',
    's',
    "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'split' } })<Cr>",
    opts
  )
  -- vsplit
  vim.keymap.set(
    'n',
    'v',
    "<Cmd>call ddu#ui#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'vsplit' } })<Cr>",
    opts
  )
end

M.hook_add = function()
  vim.keymap.set('n', '<Space>e', function()
    local winid = vim.fn.win_getid()
    local cwd = vim.fn.getcwd()

    -- タブローカル変数から path を取得（あれば）
    local path = vim.t.ddu_ui_filer_path or cwd

    vim.fn['ddu#start']({
      name = 'filer-' .. winid,
      ui = 'filer',
      resume = true,
      sources = {
        {
          name = 'file',
          options = {
            path = path,
            limitPath = cwd,
            columns = { 'filename' },
          },
        },
      },
    })
  end, {})

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'ddu-filer',
    callback = set_filer_keymaps,
  })
end

return M
