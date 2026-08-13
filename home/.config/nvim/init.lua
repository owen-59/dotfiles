vim.g.mapleader = " "
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 0
vim.opt.relativenumber = true

require("config.lazy")
require("config.binds")

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        spacing = 4,
    },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dart",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
vim.cmd[[colorscheme tokyonight-night]]

