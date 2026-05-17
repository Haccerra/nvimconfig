return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")

        -- Parsers matching your LSP list:
        -- clangd          -> c, cpp
        -- gopls           -> go
        -- rust_analyzer   -> rust
        -- jdtls           -> java
        -- pyright         -> python
        -- lua_ls          -> lua
        -- ts_ls           -> javascript, typescript, tsx
        -- asm_lsp         -> asm
        -- clojure_lsp     -> clojure
        -- perlnavigator   -> perl
        -- csharp_ls       -> c_sharp
        -- html            -> html
        -- cssls           -> css
        -- bashls          -> bash
        --
        -- Extra:
        -- markdown/markdown_inline help LSP hover docs render correctly.

        local parsers = {
            "c",
            "cpp",
            "go",
            "rust",
            "java",
            "python",
            "lua",
            "javascript",
            "typescript",
            "tsx",
            "asm",
            "clojure",
            "perl",
            "c_sharp",
            "html",
            "css",
            "bash",
            "markdown",
            "markdown_inline",
        }

        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        treesitter.install(parsers)

        -- Parser/filetype mappings where the names differ
        vim.treesitter.language.register("c_sharp", { "cs", "csharp" })
        vim.treesitter.language.register("bash", { "sh", "bash" })
        vim.treesitter.language.register("tsx", { "typescriptreact" })
        vim.treesitter.language.register("javascript", { "javascriptreact" })

        local filetypes = {
            "c",
            "cpp",
            "go",
            "rust",
            "java",
            "python",
            "lua",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "asm",
            "clojure",
            "perl",
            "cs",
            "csharp",
            "html",
            "css",
            "sh",
            "bash",
            "markdown",
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(args)
                local ok = pcall(vim.treesitter.start, args.buf)

                if ok then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
