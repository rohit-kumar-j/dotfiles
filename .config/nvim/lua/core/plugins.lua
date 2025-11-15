local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "core.plugin_config" },
    { import = ".plugins" },
    { import = "core.plugin_config.themes" },
  },
  {
    -- defaults {lazy = true},
    concurrency = 8,
    install = {
      -- install missing plugins on startup. This doesn't increase startup time.
      missing = true,
      -- try to load one of these colorschemes when starting an installation during startup
      colorscheme = { "ayu-dark" },
    },
    checker = { -- Check fo rupdates
      enabled = false,
    },
    change_detection = {
      enabled = false,
    },
    ui = {
      border = "rounded",
      title = "🐧 Lazy Commander Penguin 🐧",
      icons = {
        loaded     = "●",
        not_loaded = "○",
        cmd        = " ",
        config     = " ",
        event      = "",
        ft         = " ",
        init       = " ",
        keys       = " ",
        plugin     = " ",
        runtime    = " ",
        source     = " ",
        start      = "",
        task       = " ",
        lazy       = "鈴 ",
      },
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }

)

-- Lazy Bindings
vim.api.nvim_set_keymap("n", "<leader>PH", "<cmd>Lazy home<CR>", { desc = "Home" })

vim.api.nvim_set_keymap("n", "<leader>PI", "<cmd>Lazy install<CR>", { desc = "Install" })

vim.api.nvim_set_keymap("n", "<leader>PU", "<cmd>Lazy update<CR>", { desc = "Update" })

vim.api.nvim_set_keymap("n", "<leader>PS", "<cmd>Lazy sync<CR>", { desc = "Sync" })

vim.api.nvim_set_keymap("n", "<leader>PX", "<cmd>Lazy clean<CR>", { desc = "Clean" })

vim.api.nvim_set_keymap("n", "<leader>PC", "<cmd>Lazy check<CR>", { desc = "Check" })

vim.api.nvim_set_keymap("n", "<leader>PL", "<cmd>Lazy log<CR>", { desc = "Log" })

vim.api.nvim_set_keymap("n", "<leader>PR", "<cmd>Lazy restore<CR>", { desc = "Restore" })

vim.api.nvim_set_keymap("n", "<leader>PP", "<cmd>Lazy profile<CR>", { desc = "Profile" })

vim.api.nvim_set_keymap("n", "<leader>PD", "<cmd>Lazy debug<CR>", { desc = "Debug" })

vim.api.nvim_set_keymap("n", "<leader>P?", "<cmd>Lazy help<CR>", { desc = "Help" })
