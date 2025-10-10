return {
  root_dir = function(fname)
    local util = require('lspconfig.util')
    local root = util.root_pattern('deno.json', 'deno.jsonc')(fname)
    if root then
      return root
    end

    if fname:match('/denops/') then
      return util.path.dirname(fname)
    end

    return nil
  end,
  init_options = {
    lint = true,
  },
  on_attach = function(client, bufnr)
    -- 保存時自動フォーマットを有効化
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
