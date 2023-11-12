return {
    "simrat39/rust-tools.nvim",
    ft = {"rust"},
    dependencies = {"neovim/nvim-lspconfig"},
    opts = {
        server = {
            on_attach = function(_, bufnr)
                local rt = require("rust-tools")

                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

            end,

            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        enable = true,
                        command = "clippy"
                    },
                    formatOnSave = {
                        enable = true,
                    },
                    completion = {
                        callable = {
                            snippets = "none"
                        }
                    },
                    typing = {
                        autoClosingAngleBrackets = true,
                    }
                }
            }
        }
    },
}
