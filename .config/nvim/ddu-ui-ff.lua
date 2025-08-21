-- lua_add {{{

--}}}

-- lua_source {{{
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
-- }}}
