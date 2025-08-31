-- lua_add {{{
function CommandlinePre(mode)
  -- b:prev_buffer_config を保存
  local prev_buffer_config = vim.b.prev_buffer_config

  -- モードが ':' の場合
  if mode == ':' then
    -- ddc の設定を更新
    vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
      _ = {
        keywordPattern = '[0-9a-zA-Z_:#*/.-]*',
      }
    })

    -- ':!' で始まるコマンドラインの場合、特別なソースを追加
    if string.find(vim.fn.getcmdline(), '^!') then
      vim.fn["ddc#custom#set_context_buffer"](function()
        return {
          -- cmdlineSources = { 'shell_native', 'cmdline', 'cmdline_history', 'around' },
          cmdlineSources = { 'cmdline', 'cmdline_history', 'around' },
        }
      end)
    end
  end

  -- `MyAutoCmd` イベントにリスナーを追加して、コマンドライン終了時に `CommandlinePost` を呼び出し
  vim.cmd("autocmd MyAutoCmd User DDCCmdlineLeave ++once lua CommandlinePost()")

  -- コマンドライン補完を有効にする
  vim.fn["ddc#enable_cmdline_completion"]()
end

function CommandlinePost()
  -- b:prev_buffer_config が存在すれば設定を復元
  if vim.b.prev_buffer_config then
    vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  end
end

--vim.keymap.set('n', ':', function()
--  vim.cmd("call CommandlinePre(':')")
--  return ':'
--end, { noremap = true, silent = true })

--vim.keymap.set('n', '?', function()
--  vim.cmd("call CommandlinePre('/')")
--  return '?'
--end, { noremap = true, silent = true })

--vim.keymap.set('x', ':', function()
--  vim.cmd("call CommandlinePre(':')")
--  return ':'
--end, { noremap = true, silent = true })

--vim.keymap.set('n', ';;', function()
--  vim.cmd("call cmdline#enable()")
--  vim.cmd("call CommandlinePre(':')")
--  return ';;'
--end, { noremap = true, silent = true })
--vim.keymap.set('n', ';', '<Nop>', { noremap = true, silent = true })

-- }}}

-- lua_source {{{
local path = vim.fn.expand('$BASE_DIR/hooks/ddc/ddc.ts')
vim.fn['ddc#custom#load_config'](path)

-- TAB キー
vim.api.nvim_set_keymap('i', '<TAB>', [[pum#visible() == 1 and '<Cmd>call pum#map#insert_relative(+1)<CR>' or (col('.') <= 1 or getline('.')[col('.') - 2]:match('%s')) and '<TAB>' or ddc#map#manual_complete()]], { noremap = true, expr = true, silent = true })
-- Shift + TAB キー
vim.api.nvim_set_keymap('i', '<S-Tab>', '<Cmd>call pum#map#insert_relative(-1)<CR>', { noremap = true, silent = true })
-- Ctrl + N キー
vim.api.nvim_set_keymap('i', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>', { noremap = true, silent = true })
-- Ctrl + P キー
vim.api.nvim_set_keymap('i', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>', { noremap = true, silent = true })
-- Ctrl + Y キー
vim.api.nvim_set_keymap('i', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', { noremap = true, silent = true })
-- Ctrl + E キー
vim.api.nvim_set_keymap('i', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', { noremap = true, silent = true })

vim.fn['ddc#enable_terminal_completion']()

vim.fn['ddc#enable']({
  context_filetype = "treesitter",
})

-- }}}
