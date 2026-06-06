return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs") -- There's a lot more ways you can configure your treesitter config for neovim, just look at the github...
    config.setup({
      auto_install = true, -- Install a new parser *if* you don't have an LSP for the language a certain file is written in
      ensure_installed = {"lua", "javascript"},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
} 
