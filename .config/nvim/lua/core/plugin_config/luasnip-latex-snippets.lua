return {
  "iurimateus/luasnip-latex-snippets.nvim",
  -- vimtex isn't required if using treesitter
  enabled = vim.api.nvim_get_var("useLtexLSP"),
  event = "InsertEnter",
  dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  config = function()
    require("luasnip-latex-snippets").setup(
    -- { use_treesitter = true }
    )
  end,
}
