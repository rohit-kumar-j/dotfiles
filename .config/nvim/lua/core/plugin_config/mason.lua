return {
  "williamboman/mason.nvim",
  opts = {
    PATH = "append", -- Try removing this line outside Asahi Linux
  },
  enabled = vim.api.nvim_get_var("useMason"),
  event = "VeryLazy",
  build = function()
    pcall(vim.cmd, "MasonUpdate")
  end,
  config = function()
    -- local servers = {
    --   "clangd",
    -- }
    -- Set up mason-lspconfig
    require("mason").setup({
      ui = {
        border = "rounded",
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        scrollbar = "║",
      }
    })
    vim.keymap.set("n", "<leader>MM", "<cmd>Mason<CR>", { desc = "Mason" })
    vim.keymap.set("n", "<leader>Ml", "<cmd>MasonLog<CR>", { desc = "Mason Log" })
    vim.keymap.set("n", "<leader>Mi", "<cmd>MasonToolsInstall<CR>", { desc = "Mason Tools Install" })
    vim.keymap.set("n", "<leader>Mu", "<cmd>MasonToolsUpdate<CR>", { desc = "Mason Tools Update" })
    vim.keymap.set("n", "<leader>MU", "<cmd>MasonUpdate<CR>", { desc = "Mason Update" })
  end
}
