return {
  "hrsh7th/cmp-nvim-lsp",
  -- enabled = true,
  enabled = vim.api.nvim_get_var("useCMP"),
  event = "InsertEnter",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    -- LSP SETUP
    local on_attach = function(client, bufnr)
      -- Using default Keymaps
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave",
              "CursorMoved",
              "InsertEnter",
              "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })
    end
  end
}
