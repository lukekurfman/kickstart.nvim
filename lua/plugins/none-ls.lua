return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          -- Add an linting and formatting options you may want to include for certain languages
        },
      }

      vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
    end,
  },
}
