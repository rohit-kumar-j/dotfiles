return {
  "akinsho/bufferline.nvim",
  enabled = vim.api.nvim_get_var("useBufferLineAndNvimTree"),
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require("bufferline")
    require("bufferline").setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        separator = "slant",
        style_preset = { bufferline.style_preset.minimal },
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" })
          }
        },
        diagnostics = "nvim_lsp",
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "underline",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text_align = "center",
            separator = true
          }
        }
      }
    })

    -- Keybindings
    vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<CR>", { desc = "Jump" })
    vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous" })
    vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Next" })
    vim.keymap.set("n", "<leader>be", "<cmd>BufferLinePickClose<CR>", { desc = "Pick Which Buffer to Close" })
    vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all to the left" })
    vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all to the right" })
    vim.keymap.set("n", "<leader>bD", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort By Directory" })
    vim.keymap.set("n", "<leader>bL", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort By Language" })
  end
}
