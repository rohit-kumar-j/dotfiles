return {
  "akinsho/toggleterm.nvim",
  version = "*",
  enabled = vim.api.nvim_get_var("useToggleTerm"),
  keys = {
    { "<C-\\>", "<cmd>lua ToggleTerm<CR>", desc = "Toggle Term" }, -- Done
  },
  config = function()
    require("toggleterm").setup({
      -- on_create = function (require'toggleterm'.exec("cls") end),
      -- on_create = function() require 'toggleterm'.exec() end,
      open_mapping = [[<c-\>]],
      direction = "float",
      size = 40,
      float_opts = {
        border = "double",
      },
    })
  end
}
