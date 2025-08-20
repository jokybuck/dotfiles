-- encoding
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- visual
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.showmatch = true

--
-- vim.o.clipboard = "unnamedplus"

-- cache ディレクトリの準備
local cache = vim.fn.expand("~/.cache")
if vim.fn.isdirectory(cache) == 0 then
  vim.fn.mkdir(cache, "p")
end

local function dpp_init_plugin(plugin)
  -- Search from $CACHE directory
  local dir = vim.fn.expand(cache .. "/dpp/repos/github.com/" .. plugin)
  if vim.fn.isdirectory(dir) == 0 then
    -- Install plugin automatically
    local cmd = string.format("!git clone https://github.com/%s %s", plugin, dir)
    vim.cmd(cmd)
  end

  -- Add plugin to runtimepath
  vim.opt.runtimepath:prepend(dir)
end

local dppConfig = vim.fn.expand("~/.config/nvim/dpp.ts")

vim.env.BASE_DIR = vim.fn.expand('<script>:h')

dpp_init_plugin("Shougo/dpp.vim")
local dpp = require("dpp")

-- denops shared serverの設定
-- vim.g.denops_server_addr = "127.0.0.1:34141"

-- vim.g["dpp#_log_level"] = "debug"

local dppBase = vim.fn.expand("~/.cache/dpp/")
if dpp.load_state(dppBase) then
  dpp_init_plugin("vim-denops/denops.vim")
  dpp_init_plugin("Shougo/dpp-ext-installer")
  dpp_init_plugin("Shougo/dpp-ext-lazy")
  dpp_init_plugin("Shougo/dpp-ext-local")
  dpp_init_plugin("Shougo/dpp-ext-toml")
  dpp_init_plugin("Shougo/dpp-protocol-git")

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function ()
      vim.notify("vim load_state is failed")
      dpp.make_state(dppBase, dppConfig)
    end
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Dpp:makeStatePost",
  callback = function ()
    vim.notify("dpp make_state() is done")
  end
})

