---- lazy.nvim setup from their Github page ----

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Suggested the following variables in this tutorial...https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn ... though apparently the require("lazy").setup portion needs the spec table instead of the plugins area
-- local plugins = {}
-- local opts = {}

-- Setup lazy.nvim
--require("lazy").setup("spec")

require("lazy").setup("plugins") -- In short, Lazy will look up for the lua files/modules in .config/nvim/lua/plugins.lua OR .config/nvim/lua/plugins/filename.lua 
require("vim-config") -- Should look for a vim-config.lua file

--- single file setup I used previously...
--require("lazy").setup({
--  spec = {
--    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
--    {
--    'nvim-telescope/telescope.nvim', tag = '0.1.8',
---- or                              , branch = '0.1.x',
--      dependencies = { 'nvim-lua/plenary.nvim' }
--    },
--    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
--    {
--      "nvim-neo-tree/neo-tree.nvim",
--      branch = "v3.x",
--      dependencies = {
--        "nvim-lua/plenary.nvim",
--        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended; look up a nerd font to go along with this...Could use the Jet Brains nerd font...
--        "MunifTanjim/nui.nvim",
--        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
--      },
--      lazy = false, -- neo-tree will lazily load itself
--      ---@module "neo-tree"
--      ---@type neotree.Config?
--      opts = {
--        -- fill any relevant options here
--      },
--    }
--
--    -- add our plugins hereG
--  },
--  -- Configure any other settings here. See the documentation for more details.
--  -- colorscheme that will be used when installing plugins.
--  install = { colorscheme = { "habamax" } },
--  -- automatically check for plugin updates
--  checker = { enabled = true },
--})

---- end of lazy.nvim setup from their Github page ----
