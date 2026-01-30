
local map = vim.keymap.set

return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("dapui").setup()

      -- Auto-open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- DAP UI keymaps
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<leader>dr", function()
        dapui.open { reset = true }
      end, { desc = "Reset DAP UI" })
      vim.keymap.set("n", "<leader>de", function()
        dapui.eval()
      end, { desc = "Evaluate expression" })
      vim.keymap.set("v", "<leader>de", function()
        dapui.eval()
      end, { desc = "Evaluate selection" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    ensure_installed = {
      "codelldb",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- Breakpoint keymaps
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end, { desc = "Set conditional breakpoint" })
      vim.keymap.set("n", "<leader>dlp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end, { desc = "Set log point" })

      -- Debug session control
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end, { desc = "Start/Continue debugging" })
      vim.keymap.set("n", "<F6>", function()
        dap.pause()
      end, { desc = "Pause debugging" })
      vim.keymap.set("n", "<F8>", function()
        dap.terminate()
      end, { desc = "Terminate debugging" })
      vim.keymap.set("n", "<F9>", function()
        dap.restart()
      end, { desc = "Restart debugging" })

      -- Step controls
      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end, { desc = "Step over" })
      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end, { desc = "Step into" })
      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end, { desc = "Step out" })

      -- Alternative step controls (common vim-style)
      vim.keymap.set("n", "<leader>dn", function()
        dap.step_over()
      end, { desc = "Step over (next)" })
      vim.keymap.set("n", "<leader>di", function()
        dap.step_into()
      end, { desc = "Step into" })
      vim.keymap.set("n", "<leader>do", function()
        dap.step_out()
      end, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, { desc = "Continue" })

      -- Debug mode only mappings (single keys)
      local debug_keymaps_set = false

      local function set_debug_keymaps()
        if not debug_keymaps_set then
          vim.keymap.set("n", "n", function()
            dap.step_over()
          end, { desc = "Debug: Step over (next)" })
          vim.keymap.set("n", "s", function()
            dap.step_into()
          end, { desc = "Debug: Step into" })
          vim.keymap.set("n", "u", function()
            dap.step_out()
          end, { desc = "Debug: Step out" })
          vim.keymap.set("n", "c", function()
            dap.continue()
          end, { desc = "Debug: Continue" })
          debug_keymaps_set = true
        end
      end

      local function clear_debug_keymaps()
        if debug_keymaps_set then
          pcall(vim.keymap.del, "n", "n")
          pcall(vim.keymap.del, "n", "s")
          pcall(vim.keymap.del, "n", "u")
          pcall(vim.keymap.del, "n", "c")
          debug_keymaps_set = false
        end
      end

      -- Set debug keymaps when session starts
      dap.listeners.after.event_initialized["debug_keymaps"] = set_debug_keymaps

      -- Clear debug keymaps when session ends
      dap.listeners.before.event_terminated["debug_keymaps"] = clear_debug_keymaps
      dap.listeners.before.event_exited["debug_keymaps"] = clear_debug_keymaps

      -- REPL and hover
      vim.keymap.set("n", "<leader>dR", function()
        dap.repl.open()
      end, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dl", function()
        dap.run_last()
      end, { desc = "Run last" })
      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Hover variables" })
      vim.keymap.set("n", "<leader>dp", function()
        require("dap.ui.widgets").preview()
      end, { desc = "Preview" })

      -- Frames and scopes
      vim.keymap.set("n", "<leader>df", function()
        local widgets = require "dap.ui.widgets"
        widgets.sidebar(widgets.frames).open()
      end, { desc = "Show frames" })
      vim.keymap.set("n", "<leader>ds", function()
        local widgets = require "dap.ui.widgets"
        widgets.sidebar(widgets.scopes).open()
      end, { desc = "Show scopes" })

      -- Clear breakpoints
      vim.keymap.set("n", "<leader>dbc", function()
        dap.clear_breakpoints()
      end, { desc = "Clear all breakpoints" })
      vim.keymap.set("n", "<leader>dbl", function()
        dap.list_breakpoints()
      end, { desc = "List breakpoints" })

      -- Set breakpoint icons
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointLine",
        numhl = "DapBreakpointNum",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "🔶",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointLine",
        numhl = "DapBreakpointNum",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "🚫",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointLine",
        numhl = "DapBreakpointNum",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = "📝",
        texthl = "DapLogPoint",
        linehl = "DapLogPointLine",
        numhl = "DapLogPointNum",
      })
      vim.fn.sign_define("DapStopped", {
        text = "▶️",
        texthl = "DapStopped",
        linehl = "DapStoppedLine",
        numhl = "DapStoppedNum",
      })
    end,
  },
}
