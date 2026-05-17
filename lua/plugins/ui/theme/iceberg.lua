return {
    "cocopon/iceberg.vim",
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = "dark"
        vim.opt.cursorline = true
        vim.opt.signcolumn = "yes"

        vim.cmd.colorscheme("iceberg")

        local function set_iceberg_highlights()
            -- LSP hover/signature floating windows
            vim.api.nvim_set_hl(0, "NormalFloat", {
                bg = "#161821",
                fg = "#c6c8d1",
            })

            vim.api.nvim_set_hl(0, "FloatBorder", {
                bg = "#161821",
                fg = "#84a0c6",
            })

            vim.api.nvim_set_hl(0, "FloatTitle", {
                bg = "#161821",
                fg = "#84a0c6",
                bold = true,
            })

            -- Completion menu
            vim.api.nvim_set_hl(0, "Pmenu", {
                bg = "#161821",
                fg = "#c6c8d1",
            })

            vim.api.nvim_set_hl(0, "PmenuSel", {
                bg = "#2e313f",
                fg = "#ffffff",
                bold = true,
            })

            vim.api.nvim_set_hl(0, "PmenuSbar", {
                bg = "#1e2130",
            })

            vim.api.nvim_set_hl(0, "PmenuThumb", {
                bg = "#84a0c6",
            })
        end

        set_iceberg_highlights()

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "iceberg",
            callback = set_iceberg_highlights,
        })
    end,
}

