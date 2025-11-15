return {
  "Pocco81/true-zen.nvim",
  enabled = vim.api.nvim_get_var("useTrueZen"),
  keys = {
    { "<leader>zn", ":TZNarrow<CR>",      desc = "TrueZen Narrow" },
    { "<leader>zn", ":'<,'>TZNarrow<CR>", desc = "TrueZen Narrow Visual" },
    { "<leader>zf", ":TZFocus<CR>",       desc = "TrueZen Focus" },
    { "<leader>zm", ":TZMinimalist<CR>",  desc = "TrueZen Minimalist" },
    { "<leader>za", ":TZAtaraxis<CR>",    desc = "TrueZen Ataraxis" },
  },
  config = function()
    require("true-zen").setup({})

    -- Key-mappigns
    vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", { noremap = true, silent = true, desc = "TrueZen Narrow" })
    vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", { noremap = true, silent = true, desc = "TrueZen Narrow Visual" })
    vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", { noremap = true, silent = true, desc = "TrueZen Focus" })
    vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", { noremap = true, silent = true, desc = "TrueZen Minimalist" })
    vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", { noremap = true, silent = true, desc = "TrueZen Ataraxis" })
  end
}
