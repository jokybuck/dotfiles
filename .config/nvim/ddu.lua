-- lua_add {{{
-- }}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/ddu.ts')
vim.fn['ddu#custom#load_config'](path)

vim.api.nvim_create_autocmd("FileType",{
  pattern = "ddu-ff",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set({ "n" }, "q", [[<Cmd>call ddu#ui#do_action("quit")<Cr>]], opts)
    vim.keymap.set({ "n" }, "<Cr>", [[<Cmd>call ddu#ui#do_action("itemAction")<Cr>]], opts)
    vim.keymap.set({ "n" }, "i", [[<Cmd>call ddu#ui#do_action("openFilterWindow")<Cr>]], opts)
    vim.keymap.set({ "n" }, "P", [[<Cmd>call ddu#ui#do_action("togglePreview")<Cr>]], opts)
  end,
})

vim.api.nvim_create_autocmd("FileType",{
  pattern = "ddu-ff-filter",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set({ "n", "i" }, "<Cr>", [[<Esc><Cmd>close<Cr>]], opts)
    vim.keymap.set({ "n" }, "q", [[<Cmd>call ddu#ui#do_action("quit")<Cr>]], opts)
    vim.keymap.set({ "n" }, "<Esc>", [[<Cmd>call ddu#ui#do_action("quit")<Cr>]], opts)
  end,
})

-- }}}
