return {
  "williamboman/mason-lspconfig.nvim",
  enabled = vim.api.nvim_get_var("useMason"),
  event = "VeryLazy",
  dependancies = {
    {
      "williamboman/mason.nvim",
      opts = {
        PATH = "append", -- Try removing this line outside Asahi Linux
      },
    }
  },
  config = function()
    -- NOTE: This is mentioned in the init.lua
    local lsp_servers = vim.api.nvim_get_var("lsp_servers")
    -- Convert lsp_servers to a table of strings
    local server_names = {}
    for _, server in ipairs(lsp_servers) do
      table.insert(server_names, server.name)
    end

    local isAsahiLinux = vim.api.nvim_get_var("Is_Asahi")
    if (isAsahiLinux ~= true) then
      require("mason-lspconfig").setup({
        ensure_installed = server_names,
      })
    else
      require("mason-lspconfig").setup()
    end
  end
}
