return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",          -- C / C++
                "gopls",           -- Go
                "rust_analyzer",   -- Rust
                "jdtls",           -- Java
                "pyright",         -- Python
                "lua_ls",          -- Lua
                "ts_ls",           -- JavaScript / TypeScript
                "asm_lsp",         -- Assembly
                "cobol_ls",        -- COBOL
                "clojure_lsp",     -- Lisp-family: Clojure
                "perlnavigator",   -- Perl
                "csharp_ls",       -- C#
                "html",            -- HTML
                "cssls",           -- CSS
                "bashls",          -- Shell / Bash / sh
            },
            automatic_enable = false,
        })
    end
}

