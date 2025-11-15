return {
  "vigoux/ltex-ls.nvim",
  enabled = vim.api.nvim_get_var("useLtexLSP"),
  event = "InsertEnter",
  opts = {
    disabled_filetypes = { "markdown" },
  },
  dependencies = "neovim/nvim-lspconfig"
}
