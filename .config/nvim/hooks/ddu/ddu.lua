-- lua_add {{{

vim.keymap.set('n', '<Space>g', function()
  vim.fn['ddu#start']({
    name = 'search',
    resume = false,
    sources = {
      {
        name ='rg',
        params = {
          input = vim.fn.input("Pattern: ", vim.fn.expand("<cword>")),
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

local function set_filter_keymaps()
  local opts = { noremap = true, silent = true, buffer = true }

  vim.keymap.set('i', '<Cr>', function()
    vim.cmd.stopinsert()
    vim.fn['ddu#ui#do_action']('closeFilterWindow')
  end, opts)
  vim.keymap.set('n', '<Cr>', function()
    vim.fn['ddu#ui#do_action']('closeFilterWindow')
  end, opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-filter',
  callback = set_filter_keymaps,
})

-- }}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/hooks/ddu/ddu.ts')
vim.fn['ddu#custom#load_config'](path)
-- }}}
