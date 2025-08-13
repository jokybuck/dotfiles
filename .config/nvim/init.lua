-- encoding
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- visual
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.showmatch = true

--
-- vim.o.clipboard = "unnamedplus"

local dppSrc = "~/.cache/dpp/repos/github.com/Shougo/dpp.vim"
local denopsSrc = "~/.cache/dpp/repos/github.com/vim-denops/denops.vim"
local dppConfig = "~/.config/nvim/dpp.ts"

local extGit = "~/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git"
local extInstaller = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer"
local extLazy = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local extLocal = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-local"
local extToml = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml"

vim.opt.runtimepath:prepend(dppSrc) 
local dpp = require("dpp")

-- denops shared serverの設定
-- vim.g.denops_server_addr = "127.0.0.1:34141"

vim.g["dpp#_log_level"] = "debug"

local dppBase = "~/.cache/dpp/"
if dpp.load_state(dppBase) then
  vim.opt.runtimepath:prepend(denopsSrc)
  vim.opt.runtimepath:prepend(extGit)
  vim.opt.runtimepath:prepend(extInstaller)
  vim.opt.runtimepath:prepend(extLazy)
  vim.opt.runtimepath:prepend(extLocal)
  vim.opt.runtimepath:prepend(extToml)

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
