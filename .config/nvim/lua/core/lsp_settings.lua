-- Retrieve the lsp_servers variable
local isAsahiLinux = vim.api.nvim_get_var("Is_Asahi")

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
vim.api.nvim_set_var("lsp_servers",
  {
    {
      name = "lua_ls",
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = "$VIMRUNTIME/lua",
          },
          diagnostics = {
            globals = {
              "vim",
              "require"
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
              max_line_length = "unset"
            },
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = "Replace"
          },
        },
      },
    },
    {
      name     = "cmake",
      settings = {
        CMake = {
          filetypes = { "cmake", "CMakeLists.txt", "CMakeCache.txt" },
        },
      },
    },
    {
      name     = "neocmake",
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
      mason = false,
      flags = { debounce_text_changes = 150 },
      on_new_config = function(new_config, new_cwd)
        local status, cmake = pcall(require, "cmake-tools")
        if status then
          cmake.clangd_on_new_config(new_config)
        end
      end,
    },
    -- {
    --   name = "jedi_language_server",
    -- },
    {
      name = "jsonls", -- for json formatting
    },
    {
      name = "pylsp",
      settings = {
        enable = true,
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
            experimental_string_processing = true
          },
          autopep8 = { enabled = false },
          yapf = { enabled = false },

          -- Linter options (ALL DISABLED for testing)
          pylint = { enabled = false },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          flake8 = { enabled = false },
          mccabe = { enabled = false },
          flake8 = {
            enabled = false -- Disable flake8 since using pycodestyle directly
          },

          -- Type checker
          pylsp_mypy = { enabled = true },

          -- Auto-completion options
          jedi_completion = { enabled = true, fuzzy = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = {
            enabled = true,
            all_scopes = true
          },

          -- Import sorting
          pyls_isort = { enabled = true },

          -- Keep useful existing settings
          preload = { enabled = true },
          -- Use pydoclint for comprehensive docstring checking
          pydocstyle = {
            enabled = true,
            match = "(?!test_).*\\.py",
            matchDir = "[^\\.].*",
            convention = "google" -- or "numpy", "pep257"
          },
          rope_completion = { enabled = true }
        }
      },
      flags = {
        debounce_text_changes = 200,
      },
    },
    {
      name = "marksman", -- for latex, lsp
      filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "text",
        "txt" }
    },
    {
      name = "ltex", -- for latex, markdown lsp
      additionalRules = {
        languageModel = { "~/ngrams/" },
      },
      filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "text", "txt" },
      disabled_filetypes = { "markdown" },
    },
    {
      name = "texlab", -- for reStructuredText lsp
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
  }
)

if (isAsahiLinux == true) then
  local lsp_servers = vim.api.nvim_get_var("lsp_servers")
  remove_lsp_server_by_name(lsp_servers, "clangd")
end

-- Global LSP Linters
vim.api.nvim_set_var("lsp_linters",
  {
    "luacheck",  -- lua
    "flake8",    -- python
    "cmakelang", -- cmake
    "cpplint",   -- C++
    "jsonlint",  -- json
    "textlint",  -- markdown
    -- No linters for xml
  }
)

-- Global LSP DAP
vim.api.nvim_set_var("lsp_dap",
  {
    "debugpy",  -- python
    "codelldb", -- C++
    "cpptools", -- C++
    -- No dap for json
    -- No dap for markdown
    -- No dap for reStructuredText
    -- No dap for xml
  }
)

-- Global LSP Formatters
vim.api.nvim_set_var("lsp_formatters",
  {
    "stylua",       -- lua
    "black",        -- python
    "clang-format", -- C++, C
    "cmakelang",    -- CMake
    "fixjson",      --json
    "prettierd",    -- markdown
    -- No formatter for reStructuredText
    "xmlformatter"  -- xml
  }
)


-- Global Treesitter Servers
vim.api.nvim_set_var("treesitter_servers",
  {
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
  }
)
