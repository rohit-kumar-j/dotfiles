return {
  "neovim/nvim-lspconfig",
  enabled = vim.api.nvim_get_var("useLSP"),
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- {
    --   "SmiteshP/nvim-navbuddy",
    --   dependencies = {
    --     "SmiteshP/nvim-navic",
    --     "MunifTanjim/nui.nvim",
    --     "numToStr/Comment.nvim",        -- Optional
    --     "nvim-telescope/telescope.nvim" -- Optional
    --   },
    --   opts = { lsp = { auto_attach = true } }
    -- }
  },
  opts = {
    servers = {
      clangd = {
        mason = true,
      },
    },
  },
  config = function()
    -- LINTERS | FORMATTERS | DAP
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
      if (vim.api.nvim_get_var("useNavbuddy") == true) then
        local navbuddy = require("nvim-navbuddy")
        navbuddy.attach(client, bufnr)
      end
    end

    -- icons / text used for a diagnostic
    local signs = { Error = "", Warn = "", Hint = "", Info = "", Other = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end


    local border = {
      -- "╭", "─", "╮", "│", "╯", "─", "╰", "│"
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    -- LSP settings (for overriding per client)
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    local lsp_servers = vim.api.nvim_get_var("lsp_servers")

    local isAsahiLinux = vim.api.nvim_get_var("Is_Asahi")
    if (isAsahiLinux == true) then
      require("lspconfig").clangd.setup {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          -- "-style=file:.clang-format", -- Only use this to sepcify non-standard ft
          "--suggest-missing-includes",
          "--completion-style=bundled",
          "--cross-file-rename",
          "--header-insertion=iwyu",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        flags = { debounce_text_changes = 150 },
        on_new_config = function(new_config, new_cwd)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,
        filetypes = { "c", "cc", "cxx", "cpp", "Objc", "objcpp" },
        on_attach = on_attach,
        capabilities = capabilities,
        handlers = handlers,
        root_dir = function(fname)
          local filename = vim.loop.cwd()
          return vim.fn.fnamemodify(filename, ":p:h")
          -- local filename = vim.loop.cwd() .. '/' .. fname
          -- return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(filename) or util.path.dirname(filename)
        end,
      }
    end

    for _, lsp in ipairs(lsp_servers) do
      require("lspconfig")[lsp.name].setup {
        settings = lsp.settings,
        on_attach = on_attach,
        on_new_config = lsp.on_new_config,
        capabilities = capabilities,
        handlers = handlers,
      }
    end

    ---Keymaps
    vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
    vim.keymap.set("n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature Help" })
    vim.keymap.set("n", "<leader>lK", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Commands" })
    vim.keymap.set("n", "<leader>lw", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
      { desc = "Add Workspace Folder" })
    vim.keymap.set("n", "<leader>lW", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
      { desc = "Remove Workspace Folder" })
    vim.keymap.set("n", "<leader>lL", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
      { desc = "List Workspace Folders" })
    vim.keymap.set("n", "<leader>lc", "<cmd>lua vim.lsp.codelens.run()<CR>", { desc = "CodeLens Run" })
    vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type Definition" })
    vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go To Definition" })
    vim.keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go To Declaration" })
    vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>",
      { desc = "References" })
    vim.keymap.set("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
    vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Quickfix" })

    vim.keymap.set("n", "<leader>lE", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Buffer Diagnostics" })
    vim.keymap.set("n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
    vim.keymap.set("n", "<leader>lN", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous Diagnostic" })

    vim.keymap.set("n", "<leader>Li", "<cmd>LspInfo<CR>", { desc = "LspInfo" })
    vim.keymap.set("n", "<leader>LI", "<cmd>LspInstall<CR>", { desc = "LspInstall" })
    vim.keymap.set("n", "<leader>LL", "<cmd>LspLog<CR>", { desc = "LspLog" })
    vim.keymap.set("n", "<leader>Ls", "<cmd>LspStart<CR>", { desc = "LspStart" })
    vim.keymap.set("n", "<leader>LS", "<cmd>LspStop<CR>", { desc = "LspStop" })
    vim.keymap.set("n", "<leader>Lr", "<cmd>LspRestart<CR>", { desc = "LspRestart" })
    vim.keymap.set("n", "<leader>Lu", "<cmd>LspUninstall<CR>", { desc = "LspUninstall" })

    if (vim.api.nvim_get_var("useNavbuddy") == true) then
      vim.keymap.set("n", "<leader>n", "<cmd>Navbuddy<CR>", { desc = "NavBuddy" })
    end
  end
}
