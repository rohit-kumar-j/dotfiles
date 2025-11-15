return {
  "stevearc/oil.nvim",
  enabled = vim.api.nvim_get_var("useOilNvim"),
  -- priority = 1000,
  keys = {
    { "<leader>o", "<cmd>Oil<CR>",                                    desc = "Oil" },
    { "<leader>O", [[:lua require('oil').open(vim.fn.getcwd())<CR>]], desc = "Oil CWD" }
  },
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      }
    })
    -- vim.cmd([[:Oil]]) -- only hihglight the line number
    vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Oil" })
    vim.keymap.set("n", "<leader>O", [[:lua require('oil').open(vim.fn.getcwd())<CR>]], { desc = "Oil CWD", noremap = true, silent = true })
  end
}
