-- auto format on save
vim.cmd[[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.keymap.set("n", "<leader>d", vim.diagnostic.goto_next)

vim.filetype.add({
    extension = {
        fluent = "fluent"
    }
})

vim.diagnostic.config {
    update_in_insert = true,
    severity_sort = true,
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {"williamboman/mason-lspconfig.nvim"},
        config = function()
            require'lspconfig'.volar.setup{
                filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
            }
            require'lspconfig'.svelte.setup{}

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require'lspconfig'.cssls.setup {
              capabilities = capabilities,
            }
            require'lspconfig'.tailwindcss.setup{}

            vim.api.nvim_create_autocmd("LspAttach", {
              group = vim.api.nvim_create_augroup("UserLspConfig", {}),
              callback = function(args)
                vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, { buffer = bufnr })
                -- Delay execution of the callback to wait for LSP server initialization
                vim.defer_fn(function()
                  -- Check if the LSP server supports inlay hints
                  local client = vim.lsp.get_client_by_id(args.data.client_id)
                  if client.server_capabilities.inlayHintProvider then
                      vim.lsp.inlay_hint.enable(args.buf, true)
                  end
                end, 500)
              end
            })
        end
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            -- rust-analyzer doesnt install correctly with mason
            -- Use the one from the nix-shell
            PATH = "append"
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {"williamboman/mason.nvim"},
        opts = {
            ensure_installed = {
                "rust_analyzer", 
                "volar",
                "typescript",
                "svelte"
            }
        }
    },
    "hrsh7th/cmp-nvim-lsp",
    "SirVer/ultisnips",
    "quangnguyen30192/cmp-nvim-ultisnips",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {"hrsh7th/cmp-nvim-lsp", "SirVer/ultisnips", "quangnguyen30192/cmp-nvim-ultisnips"},
        lazy = false,
        config = function()
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
                    end,
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" }
                },
                mapping = cmp.mapping.preset.insert {
                    ["<CR>"] = cmp.mapping.confirm({ select = true})
                }
            }
        end
    },
    
    "SmiteshP/nvim-navic",
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      opts = {},
      lazy = false,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        lazy = false,
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local cmp = require("cmp")
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            require("nvim-autopairs").setup()

            cmp.event:on(
              'confirm_done',
              cmp_autopairs.on_confirm_done()
            )
        end
    },
    {
        "imsnif/kdl.vim",
        ft = {"kdl"}
    },
    {
        "fladson/vim-kitty",
        ft = {"kitty"}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {"rust", "lua"},

                auto_install = true,
                ignore_install = {"kdl", "html"},

                highlight = {
                    enable = true
                }
            }
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config.fluent = {
              install_info = {
                url = "~/coding/tree-sitter-fluent", -- local path or git repo
                files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
              },
              filetype = "fluent", -- if filetype does not match the parser name
            }
        end
    },
    {
        "mattn/emmet-vim",
        ft = {"html", "vue"}
    }
}
