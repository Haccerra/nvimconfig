return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
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
    },
}

