return {
  "j-hui/fidget.nvim",
  enabled = vim.api.nvim_get_var("useFidgetNvim"),
  tag = "legacy",
  event = "LspAttach",
  opts = {
    -- options
  },
  config = function()
    require("fidget").setup({
      window = {
        blend = 0,
      },
    })
  end
}
