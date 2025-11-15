-- cppman
return {
  "madskjeldgaard/cppman.nvim",
  enabled = not vim.fn.has("win32") and vim.api.nvim_get_var("useCppMan"),
  keys = {
    { "<leader>cm", "<cmd>lua require('cppman').open_cppman_for(vim.fn.expand('<cword>'))<CR>", desc = "CppMan" }, -- Done
  },
  dependencies = {
    { "MunifTanjim/nui.nvim" }
  },
  config = function()
    local cppman = require("cppman").setup({})

    -- function _G.cppmap_open()
    --     cppman.open_cppman_for(vim.fn.expand("<cword>"))
    -- end

    -- Make a keymap to open the word under cursor in CPPman
    vim.keymap.set("n", "<leader>cm", function()
      cppman.open_cppman_for(vim.fn.expand("<cword>"))
    end, { desc = "CppMan", noremap = true, silent = true })

    -- Open search box
    -- vim.keymap.set("n", "<leader>cc", function()
    -- 	cppman.input()
    -- end)
  end
}
