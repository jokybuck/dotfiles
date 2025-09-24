local M = {}

local function set_terminal_keymaps()
  local opts = { buffer = true, noremap = true, silent = true }
  vim.keymap.set("n", "<c-n>", "<cmd>call ddt#ui#do_action('nextprompt')<Cr>", opts)
  vim.keymap.set("n", "<c-p>", "<cmd>call ddt#ui#do_action('previousprompt')<Cr>", opts)
  vim.keymap.set("n", "<c-y>", "<cmd>call ddt#ui#do_action('pasteprompt')<Cr>", opts)
  vim.keymap.set("n", "<cr>", "<cmd>call ddt#ui#do_action('executeline')<Cr>", opts)
end

local function set_shell_keymaps()
  local opts = { buffer = true, noremap = true, silent = true }

  -- Normal モード
  vim.keymap.set("n", "<C-n>", "<Cmd>call ddt#ui#do_action('nextPrompt')<Cr>", opts)
  vim.keymap.set("n", "<C-p>", "<Cmd>call ddt#ui#do_action('previousPrompt')<Cr>", opts)
  vim.keymap.set("n", "<C-y>", "<Cmd>call ddt#ui#do_action('pastePrompt')<Cr>", opts)
  vim.keymap.set("n", "<Cr>", "<Cmd>call ddt#ui#do_action('executeLine')<Cr>", opts)

  -- Insert モード
  vim.keymap.set("i", "<Cr>", "<Cmd>call ddt#ui#do_action('executeLine')<Cr>", opts)
  vim.keymap.set("i", "<C-c>", "<Cmd>call ddt#ui#do_action('terminate')<Cr>", opts)
  vim.keymap.set("i", "<C-z>", "<Cmd>call ddt#ui#do_action('pushBufferStack')<Cr>", opts)
end

M.hook_add = function()
  vim.keymap.set('n', '<Space>s', function()
    vim.fn['ddt#start']({
      name = vim.g.ddt_ui_shell_last_name or ('shell-' .. vim.fn.win_getid()),
      ui = 'shell'
    })
  end, { noremap = true })

  vim.keymap.set('n', '<Space>t', function()
    vim.fn['ddt#start']({
      name = vim.g.ddt_ui_terminal_last_name or ('terminal-' .. vim.fn.win_getid()),
      ui = 'terminal'
    })
  end, { noremap = true })
end

M.hook_source = function()
  local path = vim.fn.expand('$BASE_DIR/denops/ddt.ts')
  vim.fn['ddt#custom#load_config'](path)

  vim.api.nvim_create_autocmd("filetype", {
    pattern = 'ddt-terminal',
    callback = set_terminal_keymaps,
  })

  vim.api.nvim_create_autocmd("filetype", {
    pattern = 'ddt-shell',
    callback = set_shell_keymaps,
  })
end

return M
