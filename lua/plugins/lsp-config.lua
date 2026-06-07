return {
  {
    "williamboman/mason.nvim", -- Installs and manages LSPs
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim", -- Helps ensure that the LSPs are installed on the system (allegedly so you don't have to write a require statement for each require("lspconfig")[server].setup({}) for each LSP?
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "clangd" } -- This is where you can set the local LSP servers to be installed (you can also go into :Mason and install them from there under the LSP tab, but this allows you to have a written file that you can save and backup so you don't forget what you had)
      })
    end
  },
  {
    "neovim/nvim-lspconfig", -- Is what we need in order for neovim to communicate with the LSPs; probably will have to write a line to make sure each LSP is setup properly
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
--        on_attach = function (client, bufnr) -- Suggested in: https://www.youtube.com/watch?v=lsFoZIg-oDs
--          client.server_capabilities.signatureHelpProvider = false
--          on_attach(client, bufnr)
--        end,
        capabilities = capabilities,
      })
      --lspconfig.ts_ls.setup({
      --  capabilities = capabilities
      --}) -- Think this helps with javascript; based on a tutorial I found...Not sure if it even installed properly
      -- IDK, I didn't think I was supposed to use the 0.10 version, but apparently that's what works and not the 0.11 version
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set( {'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
