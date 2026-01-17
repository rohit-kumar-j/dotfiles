return {
  "nvim-treesitter/nvim-treesitter",
  enabled = vim.api.nvim_get_var("useTreesitter"),
  event = "BufReadPre",
  branch = "master",
  config = function()

    -- see https://www.reddit.com/r/neovim/comments/144ypfi/dap_repl_parser_not_found/ 
    require('nvim-dap-repl-highlights').setup()

    require("nvim-treesitter.configs").setup(
      {
        ensure_installed = vim.api.nvim_get_var("treesitter_servers"),
        sync_install = true,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          -- custom_captures = {
          --   -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
          --   -- ["foo.bar"] = "Identifier",
          -- },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        }
      }
    )
  end
}
