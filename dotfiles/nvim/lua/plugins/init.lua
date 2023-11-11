return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        'glacambre/firenvim',

        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        lazy = not vim.g.started_by_firenvim,
        build = function()
            vim.fn["firenvim#install"](0)
        end,
        config = function()
            vim.api.nvim_create_autocmd({"BufEnter"}, {
                pattern = "codingame.com_*.txt",
                cmd = "set filetype=python"
            })
        end
    }
}
