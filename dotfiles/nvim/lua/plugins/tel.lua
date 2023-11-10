return {
    {
        "nvim-telescope/telescope.nvim",
        keys = "<leader>f",
        config = function(_, _)
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { bufnr = nil })
            vim.keymap.set("n", "<leader>fa", builtin.builtin, {})
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {"nvim-telescope/telescope.nvim"},
        keys = "<leader>ft",
        config = function(_, _)
            require("telescope").load_extension "file_browser"
            local file_browser = require("telescope").extensions.file_browser.file_browser
            vim.keymap.set("n", "<leader>ft", file_browser, {})
        end
    },
}
