return {
  "stevearc/oil.nvim",
  enabled = vim.api.nvim_get_var("useOilNvim"),
  -- priority = 1000,
  keys = {
    { "<leader>o", "<cmd>Oil<CR>",                                     desc = "Oil" },
    { "<leader>O", [[:lua require('oil').open(vim.fn.getcwd())<CR>]],  desc = "Oil CWD" },
    { "<leader>B", function() require('oil').open(vim.g.trash_path) end, desc = "Open Trash Bin" },
  },
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      delete_to_trash = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        natural_order = true,
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
