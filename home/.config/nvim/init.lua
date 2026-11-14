vim.g.mapleader = " "
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
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

vim.cmd[[colorscheme tokyonight-night]]

