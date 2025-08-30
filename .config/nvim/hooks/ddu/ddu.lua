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

end
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-filter',
  callback = set_filter_keymaps,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "Ddu:uiDone",
--   nested = true,
--   callback = function()
--     vim.fn["ddu#ui#async_action"]("openFilterWindow")
--   end,
-- })

-}}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/ddu.ts')
vim.fn['ddu#custom#load_config'](path)
-- }}}
