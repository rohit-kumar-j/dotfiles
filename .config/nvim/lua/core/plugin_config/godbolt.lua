return {
  "p00f/godbolt.nvim",
  enabled = vim.api.nvim_get_var("useGodBolt"),
  keys = {
    { "<leader>GG", "<cmd>Godbolt<CR>",                   desc = "GodBolt" },
    { "<leader>GC", "<cmd>GodboltCompiler telescope<CR>", desc = "GodBolt Compiler" },
  },
  config = function()
    require("godbolt").setup({})
  end
}
