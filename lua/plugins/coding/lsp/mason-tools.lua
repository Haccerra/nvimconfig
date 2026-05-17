return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "mason-org/mason.nvim",
    },
    opts = {
        ensure_installed = {
            -- Python
            "ruff",
            "black",
            "isort",

            -- Lua
            "stylua",
            "selene",

            -- JS / TS / HTML / CSS
            "prettier",
            "eslint_d",
            "stylelint",
            "markuplint",

            -- Shell
            "shfmt",
            "shellcheck",

            -- Go
            "golangci-lint",
            "gomodifytags",
            "impl",

            -- Java
            "google-java-format",

            -- Clojure
            "cljfmt",
            "clj-kondo",

            -- C#
            "csharpier",

            -- Assembly
            "asmfmt",
        },

        run_on_start = true,
        auto_update = false,
    },
}

