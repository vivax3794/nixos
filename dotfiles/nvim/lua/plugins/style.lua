vim.opt.number = true
vim.opt.relativenumber = true

-- hide normal status bar if not typing command
vim.opt.cmdheight = 0

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<left>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<right>', '<Cmd>BufferNext<CR>', opts)

map('n', '<leader><left>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<leader><right>', '<Cmd>BufferMoveNext<CR>', opts)

map('n', '<leader>t', '<Cmd>term<CR>', opts)
map('t', '<esc>', '<C-\\><C-n>', opts)

map('n', '<leader>bc', '<Cmd>BufferClose<CR>', opts)
map('n', '<leader>bp', '<Cmd>BufferPick<CR>', opts)

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
    },
  {'romgrk/barbar.nvim',
    dependencies = {
      -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  }
--   {
--   "folke/which-key.nvim",
--   event = "VeryLazy",
--   init = function()
--     vim.o.timeout = true
--     vim.o.timeoutlen = 300
--   end,
--   opts = {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--   }
-- }
}
