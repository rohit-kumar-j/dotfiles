return {
  "puremourning/vimspector",
  enabled = vim.api.nvim_get_var("useVimspector"),
  event = "VeryLazy",
  -- cmd={"VimspectorInstall", "VimspectorUpdate"},
  -- fn={"vimspector#Launch()", "vimspector#ToggleBreakpoint",  "vimspector#Continue"},
  config = function()
    -- require("core.plugin_config.vimspector").setup(
    -- vim.g.vimspector_enable_mappings="HUMAN"
    -- vim.cmd([[
    --   nmap <F5> <cmd>call vimspector#Launch()<cr>
    --   nmap <F8> <cmd>call vimspector#Reset()<cr>
    --   nmap <F9> <cmd>call vimspector#Continue()<cr>
    --   nmap <F10> <cmd>call vimspector#StepOver()<cr>
    -- ]])
    --
    -- vim.api.nvim_set_keymap('n', "bp", ":call vimspector#ToggleBreakpoint()<cr>")
    --
    vim.cmd([[
    let g:vimspector_sidebar_width = 32
    let g:vimspector_bottombar_height = 15
    let g:vimspector_terminal_maxwidth = 30
    let g:vimspector_terminal_minwidth = 35
    ]])
    -- )
  -- vim.g.vimspector_enable_mappings="HUMAN"
  vim.keymap.set("n", "<leader>dl", ":call vimspector#Launch()<CR>", { desc="Launch", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>dr", ":call vimspector#Reset()<CR>", { desc="Reset", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>db", ":call vimspector#ToggleBreakpoint()<CR>", { desc="ToggleBreakpoint", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>dc", ":call vimspector#Continue()<CR>", { desc="Continue", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>di", ":call vimspector#StepInto()<CR>", { desc="StepInto", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>do", ":call vimspector#StepOut()<CR>", { desc="StepOut", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>dO", ":call vimspector#StepOver()<CR>", { desc="StepOver", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>de", ":call vimspector#BalloonEval()<CR>", { desc="BalloonEval", noremap = true, silent = true })
  vim.keymap.set("n", "<leader>dD", ":VimspectorDisassemble<CR>", { desc="Disassemble", noremap = true, silent = true })
  vim.api.nvim_command([[let g:vimspector_base_dir = expand('$HOME/vimspector')]])
  end,
}
