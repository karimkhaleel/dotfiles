---@type MappingsTable
local M = {}

local copilot_on = true

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tf"] = {
      ":lua require('custom.flags').toggle_format_on_save()<CR>",
      "toggle format on save",
      opts = { nowait = true },
    },
    ["<leader>ti"] = {
      ":lua require('custom.flags').toggle_inlay_hints()<CR>",
      "toggle inlay hints",
      opts = { nowait = true },
    },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["g,"] = { "g,zvzz" },
    ["g;"] = { "g;zvzz" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
  },
}

M.disabled = {
  n = {
    ["<tab>"] = "",
    ["<S-tab>"] = "",
  },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["<leader>k"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<leader>j"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.LSP = {
  n = {
    ["<leader>lr"] = {
      "<cmd> LspRestart <CR>",
      "Restart LSP",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Run pytest on method",
    },
  },
}

M.copilot = {
  plugin = true,

  n = {
    ["<leader>lct"] = {
      function()
        if copilot_on then
          copilot_on = false
          require("copilot.command").disable()
          print "Copilot disabled"
        else
          copilot_on = true
          require("copilot.command").enable()
          print "Copilot enabled"
        end
      end,
      "Copilot toggle",
    },
    ["<leader>lp"] = {
      "<cmd> Copilot panel <CR>",
      "Copilot panel",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find document symbols" },
    ["<leader>fe"] = { "<cmd> lua MiniFiles.open() <CR>", "Open file explorer" },
  },
}

M.ufo = {
  plugin = true,

  n = {
    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close all folds",
    },
  },
}

return M
