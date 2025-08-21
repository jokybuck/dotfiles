-- lua_add {{{

-- }}}
-- lua_add {{{

--}}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/ddu.ts')
vim.fn['ddu#custom#load_config'](path)
-- }}}
