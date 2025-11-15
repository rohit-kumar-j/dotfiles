return {
  "rohit-kumar-j/cmake-tools.nvim",
  branch = "master", -- "overseer_terminal", -- env_scripts",
  enabled = vim.api.nvim_get_var("useCMakeTools"),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/overseer.nvim",
    --NVM
    "nvim-telescope/telescope-dap.nvim",
    "LiadOz/nvim-dap-repl-highlights",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake", -- path of executable
      -- cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
      -- cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      -- cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
      cmake_build_directory = "build",
      -- cmake_soft_link_compile_commands = true,
      -- cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
      -- cmake_variants_message = {
      --   short = { show = true }, -- whether to show short message
      --   long = { show = true, max_length = 40 }, -- whether to show long message
      -- },
      cmake_dap_configuration = {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },

      cmake_executor = {   -- executor to use
        name = "terminal", -- name of the executor
      },
      cmake_notifications = {
        enabled = false, -- show cmake execution progress in nvim-notify
      },
    })

    require("overseer").setup()

    -- CMake Keybindings
    vim.api.nvim_set_keymap("n", "<leader>cg", ":CMakeGenerate<CR>", { noremap = true, silent = true, desc = "Generate" })
    vim.api.nvim_set_keymap("n", "<leader>cb", ":CMakeBuild<CR>", { noremap = true, silent = true, desc = "Build" })
    vim.api.nvim_set_keymap("n", "<leader>cd", ":CMakeDebug<CR>", { noremap = true, silent = true, desc = "Debug" })
    vim.api.nvim_set_keymap("n", "<leader>cr", ":CMakeRun<CR>", { noremap = true, silent = true, desc = "Run" })
    vim.api.nvim_set_keymap("n", "<leader>cc", ":CMakeClean<CR>", { noremap = true, silent = true, desc = "Clean" })
    vim.api.nvim_set_keymap("n", "<leader>cC", ":CMakeClose<CR>", { noremap = true, silent = true, desc = "Close Console" })
    vim.api.nvim_set_keymap("n", "<leader>co", ":CMakeOpen<CR>", { noremap = true, silent = true, desc = "Open Console" })
    vim.api.nvim_set_keymap("n", "<leader>cs", ":CMakeStop<CR>", { noremap = true, silent = true, desc = "Stop" })
    vim.api.nvim_set_keymap("n", "<leader>ci", ":CMakeInstall<CR>", { noremap = true, silent = true, desc = "Install" })
    vim.api.nvim_set_keymap("n", "<leader>ca", ":CMakeLaunchArgs<CR>", { noremap = true, silent = true, desc = "Launch Args" })
    vim.api.nvim_set_keymap("n", "<leader>cl", ":CMakeSelectLaunchTarget<CR>", { noremap = true, silent = true, desc = "Select Launch Target" })

    --- CMakeQuick <...>
    vim.api.nvim_set_keymap("n", "<leader>cqb", ":CMakeQuickBuild<CR>", { noremap = true, silent = true, desc = "Quick Build" })
    vim.api.nvim_set_keymap("n", "<leader>cqd", ":CMakeQuickDebug<CR>", { noremap = true, silent = true, desc = "Quick Debug" })
    vim.api.nvim_set_keymap("n", "<leader>cqr", ":CMakeQuickRun<CR>", { noremap = true, silent = true, desc = "Quick Run" })

    --- CMakeSelect <...>
    vim.api.nvim_set_keymap("n", "<leader>cSb", ":CMakeSelectBuildTarget<CR>", { noremap = true, silent = true, desc = "Build Target" })
    vim.api.nvim_set_keymap("n", "<leader>cSt", ":CMakeSelectBuildType<CR>", { noremap = true, silent = true, desc = "Build Type" })
    vim.api.nvim_set_keymap("n", "<leader>cSp", ":CMakeSelectBuildPreset<CR>", { noremap = true, silent = true, desc = "Build Preset" })
    vim.api.nvim_set_keymap("n", "<leader>cSc", ":CMakeSelectConfigurePreset<CR>", { noremap = true, silent = true, desc = "Configure Preset" })
    vim.api.nvim_set_keymap("n", "<leader>cSl", ":CMakeSelectLaunchTarget<CR>", { noremap = true, silent = true, desc = "Launch Target" })
    vim.api.nvim_set_keymap("n", "<leader>cSw", ":CMakeSelectCwd<CR>", { noremap = true, silent = true, desc = "CWD" })
    vim.api.nvim_set_keymap("n", "<leader>cSk", ":CMakeSelectKit<CR>", { noremap = true, silent = true, desc = "Kit" })

    -- Misc
    vim.api.nvim_set_keymap("n", "<leader>cSs", ":CMakeSettings<CR>", { noremap = true, silent = true, desc = "Settings" })
    vim.api.nvim_set_keymap("n", "<leader>cST", ":CMakeShowTargetFiles<CR>", { noremap = true, silent = true, desc = "Show Target Files" })
    vim.api.nvim_set_keymap("n", "<leader>ct", ":CMakeTargetSettings<CR>", { noremap = true, silent = true, desc = "Show Target Settings" })
  end
}
