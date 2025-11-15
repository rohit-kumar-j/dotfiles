return {
  "weizheheng/nvim-workbench",
  -- enabled = true,
  enabled = vim.api.nvim_get_var("useWorkBench"),
  keys = {
    { "<leader><leader>p", "<cmd>lua require('workbench').toggle_project_workbench()<CR>", desc = "Toggle Project Workbench" },
    { "<leader><leader>b", "<cmd>lua require('workbench').toggle_branch_workbench()<CR>",  desc = "Toggle Branch Workbench" },
    { "<leader><leader>a", "<Plug>WorkbenchAddCheckbox<CR>",                               desc = "Add CheckBox" },
    { "<leader><leader>t", "<Plug>WorkbenchToggleCheckbox<CR>",                            desc = "Toggle CheckBox" },
  },
  config = function()
    vim.g.workbench_border = "single"

    vim.api.nvim_set_keymap("n", "<leader><leader>p", "<cmd>lua require('workbench').toggle_project_workbench()<CR>",
      { noremap = true, silent = true, desc = "Toggle Project Workbench" })

    vim.api.nvim_set_keymap("n", "<leader><leader>b", "<cmd>lua require('workbench').toggle_branch_workbench()<CR>",
      { noremap = true, silent = true, desc = "Toggle Branch Workbench" })

    vim.api.nvim_set_keymap("n", "<leader><leader>a", "<Plug>WorkbenchAddCheckbox<CR>",
      { noremap = true, silent = true, desc = "Add CheckBox" })

    vim.api.nvim_set_keymap("n", "<leader><leader>t", "<Plug>WorkbenchToggleCheckbox<CR>",
      { noremap = true, silent = true, desc = "Toggle CheckBox" })
  end
}
