return {
  "folke/which-key.nvim",
  enabled = vim.api.nvim_get_var("useWhichKey"),
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local my_mappings = {}
    if vim.api.nvim_get_var("useCMakeTools") then
      table.insert(my_mappings, {
        { "<leader>c",  group = "CMake" },
        { "<leader>cq", group = "CMake Quick" },
        { "<leader>cS", group = "CMake Select" }
      }
      )
    end
    if vim.api.nvim_get_var("useLSP") then
      table.insert(my_mappings,
        { "<leader>l", group = "Buffers" }
      )
    end

    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    -- local mappings = {
    --   b = { group = "Buffers" },
    --   d = { group = "DAP" },
    --   M = { group = "Mason" },
    --   m = { group = "Mini Map" },
    --   L = { group = "Lsp..." },
    --   G = { group = "GodBolt" },
    --   g = { group = "Git" },
    --   t = { group = "Telescope" },
    --   T = { group = "TableMode" },
    --   h = { group = "Harpoon" },
    --   H = { group = "Hex Editor" },
    --   P = { group = "Lazy" },
    --   v = { group = "VimTex" },
    --   ["<space>"] = { name = "Workbench" },
    --   z = { name = "Zen" },
    -- }
    local opts = { prefix = vim.g.mapleader }
    -- wk.register(mappings, opts)
    local mappings = {
      { "<leader>b",        group = "Buffers" },
      { "<leader>d",        group = "DAP" },
      { "<leader>M",        group = "Mason" },
      { "<leader>m",        group = "Mini Map" },
      { "<leader>L",        group = "Lsp..." },
      { "<leader>G",        group = "GodBolt" },
      { "<leader>g",        group = "Git" },
      { "<leader>t",        group = "Telescope" },
      { "<leader>T",        group = "TableMode" },
      { "<leader>h",        group = "Harpoon" },
      { "<leader>H",        group = "Hex Editor" },
      { "<leader>P",        group = "Lazy" },
      { "<leader>v",        group = "VimTex" },
      { "<leader><leader>", name = "Workbench" },
      { "<leader>z",        group = "Zen" },
    }
    wk.add(mappings)
    wk.add(my_mappings)
  end
}
