return {
  "lervag/vimtex",
  ft = "tex",
  config = function()
    vim.cmd([[
      nmap <buffer> <leader>vp :LatexPreviewToggle<CR>
      nmap <buffer> <leader>v[ :PrevLatexPreviewMode<CR>
      nmap <buffer> <leader>v] :NextLatexPreviewMode<CR>

      function! ZathuraHook() dict abort
        if self.xwin_id <= 0 | return | endif

        silent call system('xdotool windowactivate ' . self.xwin_id . ' --sync')
        silent call system('xdotool windowraise ' . self.xwin_id)
      endfunction
    ]])

    local is_unix = vim.fn.has("unix")
    local is_win32 = vim.fn.has("win32")
    local is_wsl = vim.fn.has("wsl")

    if (is_unix == 1) then
      -- vim.g.vimtex_view_general_viewer = "ZathuraHook"
      vim.g.vimtex_view_method = "sioyek"
      -- vim.g.vimtex_view_sioyek_exe = vim.fn.expand("~") .. "/Applications/sioyek/sioyek"
      vim.g.vimtex_view_sioyek_exe = "/usr/local/bin/sioyek"
    end
    if (is_win32 == 1) then
      vim.g.vimtex_view_general_viewer = "SumatraPDF"
      vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
    end
    if (is_wsl == 1) then
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_exe = vim.fn.expand("~") .. "/Applications/sioyek/sioyek"
      -- vim.g.vimtex_view_general_viewer = "ZathuraHook"
    end

    vim.keymap.set("n", "<leader>vv", "<cmd>VimtexCompile<CR>", { desc = "VimtexCompile" })
    vim.keymap.set("n", "<leader>vc", "<cmd>VimtexClean<CR>", { desc = "VimtexClean" })
    vim.keymap.set("n", "<leader>vx", "<cmd>VimtexClearCache<CR>", { desc = "VimtexClearCache" })
    vim.keymap.set("n", "<leader>vs", "<cmd>VimtexStatus<CR>", { desc = "VimtexStatus" })
    vim.keymap.set("n", "<leader>vo", "<cmd>VimtexTocToggle<CR>", { desc = "VimtexTocToggle" })

    -- Global User variable initalized in `settings.lua`
    _G.User.vimtex_QF = false
    function _G.toggleVimtexQF()
      if User.vimtex_QF == true then
        User.vimtex_QF = not User.vimtex_QF
        vim.cmd([[:let g:vimtex_quickfix_mode=0]])
        print("Disabled Vimtex QuickFix")
      else
        User.vimtex_QF = not User.vimtex_QF
        vim.cmd([[:let g:vimtex_quickfix_mode=2]])
        print("Enabled Vimtex QuickFix")
      end
    end

    vim.keymap.set("n", "<leader>vq", "<cmd>lua toggleVimtexQF()<CR>", { noremap = true, silent = true, desc = "Toggle Vimtex QuickFix" })
  end
}
