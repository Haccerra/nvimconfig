--# selene: allow(mixed_table)

return {
    {
        "nosduco/remote-sshfs.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        cmd = {
            "RemoteSSHFSConnect",
            "RemoteSSHFSDisconnect",
            "RemoteSSHFSEdit",
            "RemoteSSHFSFindFiles",
            "RemoteSSHFSLiveGrep",
        },
        opts = {
            connections = {
                ssh_configs = {
                    vim.fn.expand("$HOME") .. "/.ssh/config",
                },
            },

            mounts = {
                base_dir = vim.fn.expand("$HOME") .. "/.cache/nvim/remote-sshfs",
                unmount_on_exit = true,
            },
        },
        keys = {
            {
                "<leader>rc",
                "<cmd>RemoteSSHFSConnect<CR>",
                desc = "Remote SSH: Connect",
            },
            {
                "<leader>rd",
                "<cmd>RemoteSSHFSDisconnect<CR>",
                desc = "Remote SSH: Disconnect",
            },
            {
                "<leader>re",
                "<cmd>RemoteSSHFSEdit<CR>",
                desc = "Remote SSH: Edit file",
            },
            {
                "<leader>rf",
                "<cmd>RemoteSSHFSFindFiles<CR>",
                desc = "Remote SSH: Find files",
            },
            {
                "<leader>rg",
                "<cmd>RemoteSSHFSLiveGrep<CR>",
                desc = "Remote SSH: Live grep",
            },
        },
    },
}
