-- lua_add {{{
-- }}}

-- lua_source {{{
-- call ddu#custom#load_configko('$BASE_DIR/ddu.ts'->expand())
local path = vim.fn.expand('$BASE_DIR/ddu.ts')
vim.fn['ddu#custom#load_config'](path)

vim.api.nvim_create_autocmd("FileType",{
  pattern = "ddu-ff",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set({ "n" }, "q", [[<Cmd>call ddu#ui#ff#do_action("quit")<CR>]], opts)
    vim.keymap.set({ "n" }, "<Cr>", [[<Cmd>call ddu#ui#ff#do_action("itemAction")<CR>]], opts)
  end,
})

-- }}}
