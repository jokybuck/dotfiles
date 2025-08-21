-- lua_add {{{
vim.api.nvim_create_user_command('DduFiler', function()
  vim.fn['ddu#start']({
    name = 'filer',
    ui = 'filer',
    sources = {
      {
        name = 'file',
        params = {
          path = vim.fn.expand('%:p:h'),
        },
      },
    },
  })
end, {})

-- }}}

-- lua_source {{{
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
