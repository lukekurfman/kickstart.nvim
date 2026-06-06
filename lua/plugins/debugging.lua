return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- Lists this as a dependency, though I'm not sure if there's anything I need to set in the config area
    'leoluz/nvim-dap-go', -- https://www.youtube.com/watch?v=oYzZxi3SSnM&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=7
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- require('nio').setup()
    require("dapui").setup()
    require("dap-go").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set('n', '<Leader>db', function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>dc', function()
      dap.continue()
    end)
  end,
}
