return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = vim.api.nvim_get_var("useMason"),
  event = "UIEnter",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        PATH = "append", -- Try removing this line outside Asahi Linux
        -- PATH = "prepend", -- "skip" seems to cause the spawning error #https://github.com/williamboman/nvim-lsp-installer/discussions/509
      },
    },
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    -- LINTERS | FORMATTERS | DAP
    local lsp_linters = vim.api.nvim_get_var("lsp_linters")
    local lsp_dap = vim.api.nvim_get_var("lsp_dap")
    local lsp_formatters = vim.api.nvim_get_var("lsp_formatters")
    local all_lsp_tools = {}
    for _, lsp_tool in ipairs(lsp_linters) do
      table.insert(all_lsp_tools, lsp_tool)
    end
    for _, lsp_tool in ipairs(lsp_dap) do
      table.insert(all_lsp_tools, lsp_tool)
    end
    for _, lsp_tool in ipairs(lsp_formatters) do
      table.insert(all_lsp_tools, lsp_tool)
    end

    local isAsahiLinux = vim.api.nvim_get_var("Is_Asahi")
    if (isAsahiLinux ~= true) then
      require("mason-lspconfig").setup({
        ensure_installed = all_lsp_tools,
      })
    else
      require("mason-lspconfig").setup()
    end
  end
}
