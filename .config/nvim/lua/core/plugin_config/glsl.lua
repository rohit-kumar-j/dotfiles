return {
  "tikhomirov/vim-glsl",
  enabled = vim.api.nvim_get_var("useGLSLSyntaxHL"),
  event = "VeryLazy",
  ft = { "vert", "frag", "glsl" },
  config = function()
    require("glow").setup({})
  end
}
