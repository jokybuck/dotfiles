-- lua_add {{{

-- }}}
-- lua_add {{{

--}}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/ddc.ts')
vim.fn['ddc#custom#load_config'](path)
-- }}}
