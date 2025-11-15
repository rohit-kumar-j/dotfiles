return {
  "nvim-tree/nvim-tree.lua",
  enabled = vim.api.nvim_get_var("useBufferLineAndNvimTree"),
  event = "VeryLazy",
  config = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    function _G.toggle_nvimtree()
      if vim.fn.bufname():match "NvimTree_" then
        vim.cmd.wincmd "p"
      else
        -- require('nvim-tree.api').tree.find_file()
        -- require('nvim-tree.api').tree.toggle()
        vim.cmd("NvimTreeFindFile") -- Find currently open file and set Focus
        vim.cmd("NvimTreeFocus")    -- Focus on the Opened tree
      end
    end

    -- empty setup using defaults
    require("nvim-tree").setup({
      view = {
        side = "left",
        width = 30,
        preserve_window_proportions = true,
        -- auto_resize = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    })

    --- Keymaps
    vim.keymap.set("n", "<leader>e", "<cmd>lua toggle_nvimtree()<CR>", { desc = "Explorer Toggle" })
    vim.keymap.set("n", "<leader>r", "<cmd>lua require('nvim-tree.api').tree.toggle(false, true)<CR>",
      { desc = "Explorer Peek" })
  end
}
