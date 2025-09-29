local lsp_names = {
  'lua_ls',
  'denols',
  'rust_analyzer',
}

vim.lsp.enable(lsp_names)

-- keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Diagnostic 一覧を Quickfix に表示
keymap("n", "<Leader>df", function()
  vim.diagnostic.open_float()
end)

-- Diagnostic 一覧を Quickfix に表示
keymap("n", "<Leader>dq", function()
  vim.diagnostic.setqflist({ open = true })
end, vim.tbl_extend("force", opts, { desc = "LSP Diagnostic → Quickfix" }))

-- Diagnostic 一覧を location list にも表示したい場合
keymap("n", "<Leader>dl", function()
  vim.diagnostic.setloclist({ open = true })
end, opts)

