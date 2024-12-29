vim.o.scrolloff = 15;


vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:i",  -- Trigger when entering Insert mode (adjust as needed)
  callback = function()
    local cmd = "kontroll set-layer --index 0"  -- Replace with your desired shell command
    vim.fn.system(cmd)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:*",  -- Trigger when leaving Insert mode
  callback = function()
    local cmd = "kontroll set-layer --index 5"  -- Replace with your desired shell command
    vim.fn.system(cmd)
  end,
})

vim.opt.linebreak = true
-- vim.opt.breakident = true
vim.opt.formatoptions = "l"
vim.opt.lbr = true
vim.opt.showbreak = "> "

vim.g.VM_leader = ",,"

vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>a")
vim.keymap.set("n", "<C-s>", ":wa<CR>")
vim.keymap.set("n", "<leader>q", ":wqa<CR>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")

vim.api.nvim_set_keymap('n', '<C-f>', '<C-b>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-b>', '<C-f>', {noremap = true})

vim.keymap.set("n", "<leader>m", function()
  require("menu").open("default")
end, {})
vim.keymap.set("n", "<C-c>", function() 
    require("minty.shades").open()
end, {})

vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "ss", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

vim.g.suda_smart_edit = 1

return {
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        opts = {}
    },
    {
        "Aasim-A/scrollEOF.nvim",
        lazy = false,
        opts = {}
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            require("leap").add_default_mappings()
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },
    {
        "tpope/vim-surround",
        lazy = false
    },
    {
        "lambdalisue/suda.vim",
        lazy = false,
    },
    {
        "mg979/vim-visual-multi",
        lazy = false,
    },
    -- {
    --    "m4xshen/hardtime.nvim",
    --    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --    opts = {},
    --    lazy = false,
    -- },
    {
        "ziontee113/icon-picker.nvim",
        lazy = false,
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<Leader>i", "<cmd>IconPickerNormal<cr>", opts)
            require("icon-picker").setup({
              disable_legacy_commands = true
            })
        end
    },
    -- {
    --     "ziontee113/color-picker.nvim",
    --     config = function()
    --         local opts = { noremap = true, silent = true }
    --
    --         vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
    --         vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)
    --
    --         require("color-picker").setup({
    --             ["icons"] = {"", ""},
    --         })
    --         vim.cmd([[hi FloatBorder guibg=NONE]])
    --     end,
    --     lazy = false,
    -- },
    { "nvchad/volt", lazy=true},
    { "nvchad/minty", lazy=true},
    { "nvchad/menu", lazy=true},
    { "norcalli/nvim-colorizer.lua", config=function()
        require'colorizer'.setup()
    end},
    {
      'stevearc/dressing.nvim',
      lazy = false,
      opts = {},
    },
    { 'rasulomaroff/reactive.nvim',
        opts = {
            builtin = {
                cursorline = {
                    modes = {
                        i = {
                            winhl = {
                                CursorLine = { bg = "none"}
                            }
                        },
                        n = {
                            winhl = {
                                CursorLine = { bg = "none"}
                            }
                        }
                    }
                },
                cursor = true,
                modemsg = true
          }
        }
    },
    -- {
    --     'github/copilot.vim'
    -- },
    {
        'IndianBoy42/tree-sitter-just',
        otps = {},
    }
}
