vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = vim.api.nvim_create_augroup("Folds", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

return {
  "nvim-telescope/telescope.nvim",
  enabled = vim.api.nvim_get_var("useTelescope"),
  event = "VeryLazy",
  tag = "0.1.8",
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- "voldikss/vim-floaterm",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" }
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup {
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        },
        layout_config = {
          prompt_position = "bottom",
        },
        selection_caret = " ",
        -- prompt_prefix = " ",
        prompt_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        normal_mode = true,
      },
      colorscheme = {
        enable_preview = true,
      },
      buffers = {
        initial_mode = "normal"
      },
      -- "","",  "󰭎",  "",  "",
      pickers = {
        find_files = {
          -- theme = "dropdown",
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--glob", "!.stack-work" },
        },
      },
    }
    require("telescope").load_extension("ui-select")
    -- require("telescope").load_extension("fzf")
    -- require("telescope").load_extension("dap")
    -- local extensions = {
    --   ["ui-select"] = {
    require("telescope.themes").get_dropdown {
      -- even more opts
      width = 0.8,
      previewer = true,
      prompt_title = false,
      borderchars = {
        { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
    }
    --   },
    -- }

    -- Set Explicit keymaps
    vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })
    vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Telescope Buffers" })

    -- Set Menu keymaps
    vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
    vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>tr", "<cmd>Telescope resume<cr>", { desc = "Resume" })
    vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
    vim.keymap.set("n", "<leader>tc", "<cmd>Telescope colorscheme preview=true<cr>", { desc = "ColorScheme" })

    --- Repeated from LSP keymaps
    vim.keymap.set("n", "<leader>te", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>le", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
    vim.keymap.set("n", "<leader>tS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
    vim.keymap.set("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })

    vim.keymap.set("n", "<leader>go", "<cmd>Telescope git_status<cr>", { desc = "Open Chaned File" })
    vim.keymap.set("n", "<leader>gB", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
    vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", { desc = "Checkout commit" })
    vim.keymap.set("n", "<leader>gA", "<cmd>Telescope git_bcommits<cr>", { desc = "Checkout commit(for current branch)" })

    --- SEARCH CONFIG FILES
    -- TODO: Make a common global OS variable in the os_config
    local is_macunix = vim.fn.has("macunix")
    local is_win32 = vim.fn.has("win32")
    local is_wsl = vim.fn.has("wsl")
    local is_linux = vim.fn.has("linux")

    local conf_dir
    if (is_macunix == 1) then
      conf_dir = os.getenv("HOME") .. "/.config/nvim"
    elseif
      (is_win32 == 1) then
      conf_dir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim" -- IN windows, it is called "USERPROFILE"
    elseif
      (is_wsl == 1 or is_linux == 1) then
      conf_dir = os.getenv("HOME") .. "/.config/nvim"
    end

    -- print("Conf dir : " .. conf_dir)

    function _G.searchDir() --dir_path)
      require("telescope.builtin").find_files {
        border = true,
        cwd = conf_dir
      }
    end
    function _G.grepDir() --dir_path)
      require("telescope.builtin").live_grep {
        border = true,
        cwd = conf_dir
      }
    end

    vim.cmd("command! -nargs=1 SearchDir lua searchDir(<f-args>)")
    vim.keymap.set("n", "<leader>C", "<cmd>lua searchDir()<CR>", { desc = "Telescope Config Files" })
    vim.cmd("command! -nargs=1 SearchDir lua grepDir(<f-args>)")
    vim.keymap.set("n", "<leader>G", "<cmd>lua grepDir()<CR>", { desc = "Telescope Grep Config Files" })
  end
}
