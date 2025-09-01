-- lua_add {{{

-- }}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/hooks/ddt/ddt.ts')
vim.fn['ddt#custom#load_config'](path)
-- }}}
