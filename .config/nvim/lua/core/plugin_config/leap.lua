return {
  url  = "https://codeberg.org/andyg/leap.nvim.git",
  enabled = vim.api.nvim_get_var("useLeap"),
  event = "BufReadPre",
  config = function()
    -- require("leap").add_default_mappings()
    require("leap").setup({
    })
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
    vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
  end
}
