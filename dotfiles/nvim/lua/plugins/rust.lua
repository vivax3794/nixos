local on_attach = function(_, bufnr)
  -- Hover actions
  vim.keymap.set("n", "<C-space>", function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end, { buffer = bufnr })
  
  -- Code action groups
  vim.keymap.set("n", "<Leader>a", function()
    vim.cmd.RustLsp('codeAction') 
  end, { buffer = bufnr })

  vim.keymap.set("n", "<Leader>e", function()
    vim.cmd.RustLsp('renderDiagnostic') 
  end, { buffer = bufnr })
end

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- LSP configuration
        server = {
          on_attach = on_attach,
          settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
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
              },
              cargo = {
                  features = "all"
              }
            },
          },
        },
      }
    end
  }
}
