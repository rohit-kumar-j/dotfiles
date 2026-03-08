return {
  "mfussenegger/nvim-dap",
  enabled = vim.api.nvim_get_var("useNvimDAP"),
  -- enabled = true,
  keys = {
    { "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle BreakPoint" }
  },
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    -- "LiadOz/nvim-dap-repl-highlights",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")

    -- Use new diagnostic signs API (Neovim 0.10+)
    local icons = require("core.icons")
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        },
      },
    })

    ---
    --- @Points
    vim.fn.sign_define("DapBreakpoint",
      { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }) --🛑
    vim.fn.sign_define("DapLogPoint",
      { text = "🗨️", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }) --🗨️🗯️
    vim.fn.sign_define("DapBreakpointRejected",
      { text = "⛔", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition",
      { text = "🟡", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
    vim.fn.sign_define("DapStopped",
      { text = "👽", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

    ---@Step Back
    vim.keymap.set("n", "<leader>db", function() require("dap").step_back() end, { noremap = true, desc = "Step Back" })
    ---@Continue
    vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { noremap = true, desc = "Continue" })
    ---@Run to Cursor
    vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { noremap = true, desc = "Run To Cursor" })
    ---@Disconnect
    vim.keymap.set("n", "<leader>dD", function() require("dap").disconnect() end, { noremap = true, desc = "Disconnect" })
    ---@Session
    vim.keymap.set("n", "<leader>dg", function() require("dap").session() end, { noremap = true, desc = "Get Session" })

    ---@Step Into
    vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { noremap = true, desc = "Step Into" })
    ---@Step Over
    vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { noremap = true, desc = "Step Over" })
    ---@Step Out
    vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { noremap = true, desc = "Step Out" })
    ---@Toggle LogPoint
    vim.keymap.set("n", "<leader>dL", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { noremap = true, desc = "Log Point" })
    ---@pause
    vim.keymap.set("n", "<leader>dp", function() require("dap").pause() end, { noremap = true, desc = "Pause" })

    ---@Open Repl
    vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { noremap = true, desc = "Toggle Repl" })
    ---@Run Last
    vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { noremap = true, desc = "Run Last" })
    ---@Start
    --- NOTE: Start and Continue have same maping
    vim.keymap.set("n", "<leader>ds", function() require("dap").continue() end, { noremap = true, desc = "Start" })
    ---@Close
    vim.keymap.set("n", "<leader>dq", function() require("dap").close() end, { noremap = true, desc = "Close" })

    -- Adapters
    local dap = require("dap")
    dap.adapters.codelldb = {
      id = "codelldb",
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
        detach = false
      }
    }
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
    }
    dap.adapters.debugpy = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    
    dap.configurations.python = {
      {
        type = 'debugpy',
        request = 'launch',
        name = "launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        pythonPath = function()
          -- search for venv in project root
          local cwd = vim.fn.getcwd()
          for _, dir in ipairs({ "venv", ".venv", "env", ".env" }) do
            local path = cwd .. "/" .. dir .. "/bin/python"
            if vim.fn.executable(path) == 1 then
              return path
            end
          end
          -- fallback to system python
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
    }


    -- dap.configurations.c = {
    --   {
    --     name = "Debug J-Link",
    --     type = "cdbg",
    --     request = "launch",
    --     cwd = "${workspaceFolder}",
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     stopAtEntry = false,
    --     MIMode = "gdb",
    --     miDebuggerServerAddress = "localhost:2331",
    --     miDebuggerPath = "arm-none-eabi-gdb",
    --     serverLaunchTimeout = 5000,
    --     postRemoteConnectCommands = {
    --       {
    --         text = "monitor reset",
    --         ignoreFailures = false
    --       },
    --       {
    --         text = "load",
    --         ignoreFailures = false
    --       },
    --     },
    --   }
    -- }
    dap.configurations.rust = dap.configurations.cpp
    dap.configurations.c = dap.configurations.cpp
  end
}
