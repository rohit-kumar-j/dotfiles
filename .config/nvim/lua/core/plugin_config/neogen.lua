return {
  "danymat/neogen",
  enabled = vim.api.nvim_get_var("useNeogen"),
  keys = {
    { "<leader>N", ":lua require('neogen').generate()<CR>", desc = "Generate Doc String" }
  },
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
    vim.api.nvim_set_keymap("n", "<Leader>N", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true, desc = "Generate Doc String" })
  end,
}
