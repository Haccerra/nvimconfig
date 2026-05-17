return {
    "neovim/nvim-lspconfig",

    config = function()
        local servers = {
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
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
            },
        })

        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                    },
                    check = {
                        command = "clippy",
                    },
                },
            },
        })

        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my-lsp-keymaps", { clear = true }),
            callback = function(event)
                local bufnr = event.buf

                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        silent = true,
                        desc = desc,
                    })
                end

                -- Hover documentation
                map("n", "K", function()
                    vim.lsp.buf.hover({
                        border = "rounded",
                        max_width = 80,
                        max_height = 20,
                    })
                end, "LSP Hover")

                -- Signature help
                map("n", "<C-k>", function()
                    vim.lsp.buf.signature_help({
                        border = "rounded",
                        max_width = 80,
                        max_height = 15,
                    })
                end, "LSP Signature Help")

                -- Navigation
                map("n", "gd", vim.lsp.buf.definition, "LSP Go to Definition")
                map("n", "gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
                map("n", "gi", vim.lsp.buf.implementation, "LSP Go to Implementation")
                map("n", "gt", vim.lsp.buf.type_definition, "LSP Go to Type Definition")

                -- Rename
                map("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")

                -- Code actions
                map({ "n", "v" }, "<leader>ca", function()
                    local clients = vim.lsp.get_clients({
                        bufnr = bufnr,
                        method = "textDocument/codeAction",
                    })

                    if #clients == 0 then
                        vim.notify(
                            "No attached LSP client supports code actions",
                            vim.log.levels.WARN
                        )
                        return
                    end

                    vim.lsp.buf.code_action()
                end, "LSP Code Action")

                -- References
                map("n", "gr", vim.lsp.buf.references, "LSP References")

                -- Format
                map("n", "<leader>f", function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        async = true,
                    })
                end, "LSP Format")

                -- Show diagnostics under cursor
                map("n", "<leader>d", function()
                    vim.diagnostic.open_float({
                        border = "rounded",
                        max_width = 80,
                    })
                end, "Show Line Diagnostics")
            end,
        })

        vim.lsp.enable(servers)
    end,
}

