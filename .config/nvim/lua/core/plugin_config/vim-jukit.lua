return {
  "luk400/vim-jukit",
  enabled = vim.api.nvim_get_var("useJupyter"),
  event = "VeryLazy",
  ft = { "ipynb" },
  init = function()
    -- Basic jukit options (set BEFORE plugin loads)
    vim.g.jukit_shell_cmd = "ipython"
    vim.g.jukit_terminal = ""
    vim.g.jukit_mappings = 0
    vim.g.jukit_mappings_ext_enabled = { "ipynb" }
    vim.g.jukit_save_output = 1
    vim.g.jukit_inline_plotting = 0
  end,
  config = function()
    -- Splits (use JukitOut only once to activate conda)
    vim.keymap.set("n", "<leader>ros", "<cmd>JukitOut conda activate rlgpu<cr>", { desc = "Open Output Split (rlgpu)" })
    vim.keymap.set("n", "<leader>rts", "<cmd>call jukit#splits#term()<cr>", { desc = "Open Terminal Split" })
    vim.keymap.set("n", "<leader>rhs", "<cmd>call jukit#splits#history()<cr>", { desc = "Open History Split" })
    vim.keymap.set("n", "<leader>rohs", "<cmd>JukitOutHist conda activate rlgpu<cr>", { desc = "Open Output & History (rlgpu)" })
    vim.keymap.set("n", "<leader>rhd", "<cmd>call jukit#splits#close_history()<cr>", { desc = "Close History" })
    vim.keymap.set("n", "<leader>rod", "<cmd>call jukit#splits#close_output_split()<cr>", { desc = "Close Output" })
    vim.keymap.set("n", "<leader>rohd", "<cmd>call jukit#splits#close_output_and_history(1)<cr>", { desc = "Close Output & History" })
    vim.keymap.set("n", "<leader>rso", "<cmd>call jukit#splits#show_last_cell_output(1)<cr>", { desc = "Show Cell Output" })
    vim.keymap.set("n", "<leader>rj", "<cmd>call jukit#splits#out_hist_scroll(1)<cr>", { desc = "Scroll History Down" })
    vim.keymap.set("n", "<leader>rk", "<cmd>call jukit#splits#out_hist_scroll(0)<cr>", { desc = "Scroll History Up" })

    -- Sending code
    vim.keymap.set("n", "<leader>r<space>", "<cmd>call jukit#send#section(0)<cr>", { desc = "Send Cell" })
    vim.keymap.set("n", "<leader>rl", "<cmd>call jukit#send#line()<cr>", { desc = "Send Line" })
    vim.keymap.set("v", "<leader>rs", ":<C-U>call jukit#send#selection()<cr>", { desc = "Send Selection" })
    vim.keymap.set("n", "<leader>rcc", "<cmd>call jukit#send#until_current_section()<cr>", { desc = "Run Cells Above" })
    vim.keymap.set("n", "<leader>rall", "<cmd>call jukit#send#all()<cr>", { desc = "Run All Cells" })

    -- Cells
    vim.keymap.set("n", "<leader>rco", "<cmd>call jukit#cells#create_below(0)<cr>", { desc = "Create Cell Below" })
    vim.keymap.set("n", "<leader>rcO", "<cmd>call jukit#cells#create_above(0)<cr>", { desc = "Create Cell Above" })
    vim.keymap.set("n", "<leader>rct", "<cmd>call jukit#cells#create_below(1)<cr>", { desc = "Create Text Cell Below" })
    vim.keymap.set("n", "<leader>rcT", "<cmd>call jukit#cells#create_above(1)<cr>", { desc = "Create Text Cell Above" })
    vim.keymap.set("n", "<leader>rcd", "<cmd>call jukit#cells#delete()<cr>", { desc = "Delete Cell" })
    vim.keymap.set("n", "<leader>rcs", "<cmd>call jukit#cells#split()<cr>", { desc = "Split Cell" })
    vim.keymap.set("n", "<leader>rcM", "<cmd>call jukit#cells#merge_above()<cr>", { desc = "Merge Cell Above" })
    vim.keymap.set("n", "<leader>rcm", "<cmd>call jukit#cells#merge_below()<cr>", { desc = "Merge Cell Below" })
    vim.keymap.set("n", "<leader>rck", "<cmd>call jukit#cells#move_up()<cr>", { desc = "Move Cell Up" })
    vim.keymap.set("n", "<leader>rcj", "<cmd>call jukit#cells#move_down()<cr>", { desc = "Move Cell Down" })
    vim.keymap.set("n", "<leader>rJ", "<cmd>call jukit#cells#jump_to_next_cell()<cr>", { desc = "Jump to Next Cell" })
    vim.keymap.set("n", "<leader>rK", "<cmd>call jukit#cells#jump_to_previous_cell()<cr>", { desc = "Jump to Previous Cell" })

    -- Notebook conversion
    vim.keymap.set("n", "<leader>rnp", '<cmd>call jukit#convert#notebook_convert("jupyter-notebook")<cr>', { desc = "Convert Notebook" })
    vim.keymap.set("n", "<leader>rht", "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<cr>", { desc = "Convert to HTML" })
    vim.keymap.set("n", "<leader>rpd", "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>", { desc = "Convert to PDF" })
  end,
}
