local M = {}

local function setup_ddu_filter()
  vim.opt.cursorline = true

  local columns = vim.api.nvim_eval('&columns')
  local lines = vim.api.nvim_eval('&lines')
  local width = math.floor(columns * 2 / 3)
  vim.fn['cmdline#set_option']({
    border = 'rounded',
    col = math.floor((columns - width) / 2),
    row = math.floor((lines - (lines * 2 / 3)) / 2) - 3,
    width = width,
  })
  vim.fn['cmdline#enable']()

  vim.fn['ddu#ui#save_cmaps']({ '<C-j>', '<C-k>' })

  local opts = { noremap = true, silent = true, buffer = true }
  vim.keymap.set('c', '<C-j>', function()
    vim.fn['ddu#ui#do_action']('cursorNext')
  end, opts)
  vim.keymap.set('c', '<C-k>', function()
    vim.fn['ddu#ui#do_action']('cursorPrevious')
  end, opts)
end

local function cleanup_ddu_filter()
  vim.opt.cursorline = false

  vim.fn['cmdline#disable']()

  vim.fn['ddu#ui#restore_cmaps']()
end

M.hook_add = function()
  vim.keymap.set('n', '<Space>g', function()
    vim.fn['ddu#start']({
      name = 'search',
      resume = false,
      sources = {
        {
          name = 'rg',
          params = {
            input = vim.fn.input('Pattern: ', vim.fn.expand('<cword>')),
          },
        },
      },
      uiParams = {
        ff = {
          ignoreEmpty = true,
        },
      },
    })
  end, {})

  -- vim.api.nvim_create_autocmd('FileType', {
  --   pattern = 'ddu-filter',
  --   callback = set_filter_keymaps,
  -- })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'Ddu:uiOpenFilterWindow',
    callback = setup_ddu_filter,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'Ddu:uiCloseFilterWindow',
    callback = cleanup_ddu_filter,
  })
end

M.hook_source = function()
  local path = vim.fn.expand('$BASE_DIR/denops/ddu.ts')
  vim.fn['ddu#custom#load_config'](path)
end

return M
