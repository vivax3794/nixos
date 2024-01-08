vim.opt.number = true
vim.opt.relativenumber = true

-- hide normal status bar if not typing command
vim.opt.cmdheight = 0


return {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
        require("tokyonight").setup()
        vim.cmd[[colorscheme tokyonight-night]]
      end
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        opts = {
            options = {
                theme = "tokyonight"
            },
            sections = {
                -- Dont like that progress thing
                lualine_y = {}
            },
            refresh = {
                statusline = 100
            }
        }
    },
    -- "arkav/lualine-lsp-progress",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
      "j-hui/fidget.nvim",
      opts = {
        -- options
      },
    }
}
