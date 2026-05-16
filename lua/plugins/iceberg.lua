return {
    "cocopon/iceberg.vim",
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = "dark"
        vim.opt.cursorline = true
        vim.opt.signcolumn = "yes"
        vim.cmd.colorscheme("iceberg")
    end,
}
