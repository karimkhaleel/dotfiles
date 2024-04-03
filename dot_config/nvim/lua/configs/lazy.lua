return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptplugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwplugin",
        "netrwsettings",
        "netrwfilehandlers",
        "matchit",
        "tar",
        "tarplugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballplugin",
        "zip",
        "zipplugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
