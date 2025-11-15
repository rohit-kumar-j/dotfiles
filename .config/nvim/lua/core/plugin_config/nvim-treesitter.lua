return {
  "nvim-treesitter/nvim-treesitter",
  enabled = vim.api.nvim_get_var("useTreesitter"),
  event = "BufReadPre",
  config = function()
    require("nvim-treesitter.configs").setup(
      {
        ensure_installed = vim.api.nvim_get_var("treesitter_servers"),
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            -- ["foo.bar"] = "Identifier",
          },
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
