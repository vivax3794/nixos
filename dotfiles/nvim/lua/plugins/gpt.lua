return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup {
            api_key_cmd = "echo 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"
        }
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
