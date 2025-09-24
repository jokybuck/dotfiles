return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      diagnostics = {
        globals = {
          'vim'
        }
      },
      semantic = {
        enable = false,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = function()
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if #diagnostics > 0 then
          vim.diagnostic.setqflist({ open = true })
        end
      end,
    })
  end,

}

