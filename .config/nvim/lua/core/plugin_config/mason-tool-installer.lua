return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = vim.api.nvim_get_var("useMason"),
  event = "UIEnter",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        -- PATH = "append", -- Try removing this line outside Asahi Linux
        PATH = "prepend", -- "skip" seems to cause the spawning error #https://github.com/williamboman/nvim-lsp-installer/discussions/509
      },
    },
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true, -- Install missing servers
      handlers = {}, -- Empty handlers = no auto-setup
    },
  },
  config = function()
    -- Ensure Mason binaries are in PATH
    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

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
    require("mason-tool-installer").setup({
      ensure_installed = all_lsp_tools,
      auto_update = true,
      run_on_start = true,
    })

    local lsp_servers = vim.api.nvim_get_var("lsp_servers")
    local lsp_server_names = {}
    for _, lsp in ipairs(lsp_servers) do
      table.insert(lsp_server_names, lsp.name)
    end
    require("mason-lspconfig").setup({
      ensure_installed = lsp_server_names,
      automatic_installation = true,
      handlers = {}, -- Prevent auto-setup
    })
  end,
}
