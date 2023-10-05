---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tf"] = {
      ":lua require('custom.flags').toggle_format_on_save()<CR>",
      "toggle format on save",
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

-- more keybinds!

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
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find document symbols" },
  },
}

return M
