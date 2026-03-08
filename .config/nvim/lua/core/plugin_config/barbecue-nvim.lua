return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = "BufReadPre",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      opts = {
        lsp = {
          auto_attach = true,
          -- Only attach to one client per buffer to avoid "already attached" errors
          preference = { "pyright", "lua_ls", "clangd", "texlab" },
        },
      },
    },
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    attach_navic = false, -- let nvim-navic handle attachment via auto_attach + preference
  },
}
