local lsp_names = {
  'lua_ls',
  'denols',
}

vim.lsp.enable(lsp_names)

vim.keymap.set("n", "<leader>dq", function()
  vim.diagnostic.setqflist()
end, { desc = "Populate quickfix list with diagnostics" })
