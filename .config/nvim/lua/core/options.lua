-- encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- visual
vim.opt.number = true
vim.opt.showmatch = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  trail = '⋅',
  nbsp = '␣',
  extends = '❯',
  precedes = '❮'
}

-- indent
vim.opt.expandtab = true      -- タブをスペースに変換する
vim.opt.shiftwidth = 4        -- 自動インデント時のスペース数
vim.opt.tabstop = 4           -- タブ文字が何スペース分に見えるか
vim.opt.softtabstop = 4       -- Tabキーを押したときに入るスペース数

-- clipboard
vim.opt.clipboard:append({ "unnamedplus" })

-- statusline
vim.opt.laststatus = 3

-- colorscheme
vim.opt.termguicolors = true -- 24 ビットカラーを使用

