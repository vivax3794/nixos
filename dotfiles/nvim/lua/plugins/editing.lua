vim.o.scrolloff = 15;


vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.linebreak = true
-- vim.opt.breakident = true
vim.opt.formatoptions = "l"
vim.opt.lbr = true
vim.opt.showbreak = "> "

vim.g.VM_leader = ",,"

vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>a")
vim.keymap.set("n", "<C-s>", ":wa<CR><CR>")
vim.keymap.set("n", "<leader>q", ":wqa<CR>")
vim.keymap.set("n", "<leader>h", ":noh<CR>")

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
    {
       "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       opts = {},
       lazy = false,
    },
}
