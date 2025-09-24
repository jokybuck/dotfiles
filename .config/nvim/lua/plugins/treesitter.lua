local M = {}

M.hook_source = function()
  require("nvim-treesitter.config").setup({
    ensure_installed = {
      "bash",
      "lua",
      "python",
      "rust",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
    },
    sync_intall = true,
    auto_install = false,
    ignore_install = { "all" },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
end

return M
