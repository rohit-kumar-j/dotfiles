-- Retrieve the lsp_servers variable
local isAsahiLinux = vim.api.nvim_get_var("Is_Asahi")
local useCmakeLSP = vim.api.nvim_get_var("useCmakeLSP")
local useLtexLSP = vim.api.nvim_get_var("useLatexLSP")

-- Function to remove an entry by name
function _G.remove_lsp_server_by_name(servers, name)
  for i, server in ipairs(servers) do
    if server.name == name then
      table.remove(servers, i)
      break
    end
  end
end

-- Global LSP Servers
vim.api.nvim_set_var("lsp_servers", {
  {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = "$VIMRUNTIME/lua",
        },
        diagnostics = {
          globals = {
            "vim",
            "require",
          },
          neededFileStatus = {
            ["codestyle-check"] = "Any",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
            -- '"${3rd}/luv/library"',
          },
          checkThirdParty = true,
        },
        format = {
          enable = true,
          -- Put format options here
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            quote_style = "double",
            max_line_length = "unset",
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  {
    name = "neocmake",
    cmd = { "neocmakelsp", "stdio" },
    settings = {
      CMake = {
        filetypes = { "cmake", "CMakeLists.txt", "CMakeCache.txt" },
      },
    },
  },
  {
    name = "clangd",
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
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    mason = false,
    flags = { debounce_text_changes = 150 },
    on_new_config = function(new_config, _) -- new_cwd is the 2nd arg
      local status, cmake = pcall(require, "cmake-tools")
      if status then
        cmake.clangd_on_new_config(new_config)
      end
    end,
  },
  {
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
  },
  {
    name = "jsonls", -- for json formatting
    cmd = { "vscode-json-language-server", "--stdio" },
  },
  {
    name = "pylsp",
    cmd = { "pylsp" },
    settings = {
      enable = true,
      skip_token_initialization = true, -- prevents progress reporting timeout errors
      -- trace = { server = "verbose" },
      -- commandPath = "",
      -- configurationSources = { "pycodestyle" },
      plugins = {
        -- Formatter options (more aggressive Black settings)
        black = {
          enabled = true,
          line_length = 79,
          skip_string_normalization = false,
          target_version = { "py39" },
          experimental_string_processing = true,
        },
        autopep8 = { enabled = false },
        yapf = { enabled = false },

        -- Linter options (ALL DISABLED for testing)
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = {
          enabled = false, -- Disable flake8 since using pycodestyle directly
        },

        -- Type checker
        pylsp_mypy = { enabled = true },

        -- Auto-completion options (disabled — pyright handles these)
        jedi_completion = { enabled = false },
        jedi_hover = { enabled = false },
        jedi_references = { enabled = false },
        jedi_signature_help = { enabled = false },
        jedi_symbols = { enabled = false },

        -- Import sorting
        pyls_isort = { enabled = true },

        -- Keep useful existing settings
        preload = { enabled = true },
        -- Use pydoclint for comprehensive docstring checking
        pydocstyle = {
          enabled = true,
          match = "(?!test_).*\\.py",
          matchDir = "[^\\.].*",
          convention = "google", -- or "numpy", "pep257"
        },
        rope_completion = { enabled = false }, -- pyright handles completions
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  },
  {
    name = "marksman", -- for latex, lsp
    cmd = { "marksman", "server" },
    filetypes = {
      "markdown",
      "rst",
      "text",
      "txt",
    },
  },
  -- {
  --   name = "esbonio", -- for reStructuredText lsp
  -- },
  -- {
  --   name = "lemminx", -- for xml
  -- },
  -- {
  --   name = 'grammarly', -- for plain text
  --   filetypes = {
  --     "markdown",
  --     "text",
  --     "txt"
  --   }
  -- }
})

-- Optional LSP servers: enabled eagerly via flag OR lazily via filetype autocmd
local optional_servers = {
  {
    flag = useCmakeLSP,
    server = {
      name = "cmake",
      cmd = { "cmake-language-server" },
      settings = {
        CMake = {
          filetypes = { "cmake", "CMakeLists.txt", "CMakeCache.txt" },
        },
      },
    },
    ft = { "cmake" },
  },
  {
    flag = useLtexLSP,
    server = {
      name = "texlab",
      cmd = { "texlab" },
      filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "text", "txt" },
      settings = {
        texlab = {
          build = {
            executable = "tectonic",
            args = { "-X", "compile", "%f", "--synctex", "--keep-logs" },
            onSave = true,
          },
          forwardSearch = {
            executable = "sioyek",
            args = { "--synctex-forward", "%l:1:%f", "%p" },
          },
          chktex = {
            onOpenAndSave = true,
          },
        },
      },
    },
    ft = { "tex", "bib", "plaintex" },
  },
}

local lsp_servers = vim.api.nvim_get_var("lsp_servers")
for _, entry in ipairs(optional_servers) do
  -- Always register the config so checkhealth/mason can find it
  local cfg = { settings = entry.server.settings or {} }
  if entry.server.cmd then
    cfg.cmd = entry.server.cmd
  end
  if entry.server.filetypes then
    cfg.filetypes = entry.server.filetypes
  end
  vim.lsp.config(entry.server.name, cfg)

  if entry.flag == true then
    -- Flag on: add to server list, will be enabled eagerly
    table.insert(lsp_servers, entry.server)
  else
    -- Flag off: enable lazily on matching filetype
    vim.api.nvim_create_autocmd("FileType", {
      pattern = entry.ft,
      once = true,
      callback = function()
        vim.lsp.enable(entry.server.name)
      end,
    })
  end
end
vim.api.nvim_set_var("lsp_servers", lsp_servers)

if isAsahiLinux == true then
  lsp_servers = vim.api.nvim_get_var("lsp_servers")
  remove_lsp_server_by_name(lsp_servers, "clangd")
end

-- Global LSP Linters
vim.api.nvim_set_var("lsp_linters", {
  "luacheck", -- lua
  "pylint", -- python
  "cmakelang", -- cmake
  "cpplint", -- C++
  "jsonlint", -- json
  "textlint", -- markdown
  -- No linters for xml
})

-- Global LSP DAP
vim.api.nvim_set_var("lsp_dap", {
  "debugpy", -- python
  "codelldb", -- C++
  "cpptools", -- C++
  -- No dap for json
  -- No dap for markdown
  -- No dap for reStructuredText
  -- No dap for xml
})

-- Global LSP Formatters
vim.api.nvim_set_var("lsp_formatters", {
  "stylua", -- lua
  "black", -- python
  "clang-format", -- C++, C
  "cmakelang", -- CMake
  "fixjson", --json
  "prettierd", -- markdown
  -- No formatter for reStructuredText
  "xmlformatter", -- xml
})

-- Register LSP configs early so checkhealth and mason-lspconfig can find them
local lsp_servers_list = vim.api.nvim_get_var("lsp_servers")
for _, lsp in ipairs(lsp_servers_list) do
  local config = { settings = lsp.settings or {} }
  if lsp.cmd then
    config.cmd = lsp.cmd
  end
  if lsp.filetypes then
    config.filetypes = lsp.filetypes
  end
  if lsp.root_dir then
    config.root_dir = lsp.root_dir
  end
  vim.lsp.config(lsp.name, config)
end

-- Global Treesitter Servers
vim.api.nvim_set_var("treesitter_servers", {
  "lua",
  "c",
  "cpp",
  "cmake",
  "norg",
  "markdown",
  "python",
  "latex",
  "bibtex",
  -- No treesitter server for xml
  "vim", -- This solves syntax highlighting in {.lua} files
})
