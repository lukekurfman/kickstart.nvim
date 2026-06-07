return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
	  "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "microsoft/debugpy", -- Hopefully this works??
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")
      -- https://github.com/mfussenegger/nvim-dap/discussions/927


      -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb -- May need to comment out the adapters.gdb line...arguments
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }

      --require("debugpy").setup({})
      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
             local name = vim.fn.input('Executable name (filter): ')
             return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = '${workspaceFolder}'
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'gdb',
          request = 'attach',
          target = 'localhost:1234',
          program = function()
             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}'
        },
      }
      ---

      dap_python.setup("debugpy-adapter")

      table.insert(require('dap').configurations.python, {
      -- https://github.com/mfussenegger/nvim-dap-python: Look under custom configuration
        justMyCode = false, -- <--- insert here
        type = 'python',
        request = 'launch',
        name = 'Ideally disables justMyCode',
        -- `program` is what you'd use in `python <program>` in a shell
        -- If you need to run the equivalent of `python -m <module>`, replace
        -- `program = '${file}` entry with `module = "modulename"
        program = '${file}',
        console = "integratedTerminal",
        -- Other options:
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      })
      -- dap_python.setup("python3") -- Old version; always worked...


      --dap.configurations.python3 = { -- 10/9/2025
      --  { -- 10/9/2025
      --    justMyCode = false, -- 10/9/2025
      --  } -- 10/9/2025
      --} -- 10/9/2025

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      local opts = { noremap = true, silent = true }

      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, opts)

      -- Continue / Start
      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, opts)

      -- Step Over
      vim.keymap.set("n", "<leader>dn", function()
        dap.step_over()
      end, opts)

      -- Step Into
      vim.keymap.set("n", "<leader>ds", function()
        dap.step_into()
      end, opts)

      -- Step Out
      vim.keymap.set("n", "<leader>dr", function()
        dap.step_out()
      end, opts)
			
      -- Keymap to terminate debugging
	  vim.keymap.set("n", "<leader>dq", function()
	      require("dap").terminate()
      end, opts)

      -- Toggle DAP UI
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, opts)
    end,
  },
}

--return {
--  'mfussenegger/nvim-dap',
--  dependencies = { -- See here for a list of debuggers you can add: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation; Note that all debuggers are different and have different ways they're setup, so don't panic if things look different from one debugger to the next...
--    'rcarriga/nvim-dap-ui', -- Since nvim-dap is barebones, we want a ui for dap (debug adapter protocol); this once can help set up a bunch of panes we can use to look at our code
--    'nvim-neotest/nvim-nio', -- Lists this as a dependency, though I'm not sure if there's anything I need to set in the config area
--    'leoluz/nvim-dap-go', -- https://www.youtube.com/watch?v=oYzZxi3SSnM&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=7
--    'mfussenegger/nvim-dap-python', -- https://www.youtube.com/watch?v=tfC1i32eW3A
--  },
--  config = function()
--    local dap = require 'dap'
--    local dapui = require 'dapui'
--    local dap_python = require 'dap-python'
--    -- require('nio').setup()
--    require("dapui").setup()
--    require("dap-go").setup()
--    -- local dap_python = require 'dap-python'
--
--
--    dap_python.setup("python3") -- https://github.com/NeuralNine/config-files/blob/master/.config/nvim/lua/plugins/nvim-dap.lua; copied the config from here...
--
--    dap.listeners.before.attach.dapui_config = function()
--      dapui.open()
--    end
--    dap.listeners.before.launch.dapui_config = function()
--      dapui.open()
--    end
--    dap.listeners.before.event_terminated.dapui_config = function()
--      dapui.close()
--    end
--    dap.listeners.before.event_exited.dapui_config = function()
--      dapui.close()
--    end
--    vim.keymap.set('n', '<Leader>db', function()
--      dap.toggle_breakpoint()
--    end)
--    vim.keymap.set('n', '<Leader>dc', function()
--      dap.continue()
--    end)
--  end,
--}
