return {
  "ahmedkhalf/jupyter-nvim",
  enabled = vim.api.nvim_get_var("useJupyter"),
  build = ":UpdateRemotePlugins",
  event = "VeryLazy",
  config = function()
    require("jupyter-nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
