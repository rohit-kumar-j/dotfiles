return {
  "rcarriga/nvim-dap-ui",
  enabled = vim.api.nvim_get_var("useNvimDAP"),
  -- enabled = true,
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<leader>du", "<cmd>lua require('dapui').toggle({ reset = false })<CR>", desc = "DapUI Toggle" }
  },
  config = function()
    require("dapui").setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    ---@Reset UI
    vim.keymap.set("n", "<leader>dUR",
      function() require("dapui").open({ reset = true }) end,
      { noremap = true, desc = "DapUI reset" }
    )

    ---@Toggle UI
    vim.keymap.set("n", "<leader>du",
      function() require("dapui").toggle({ reset = false }) end,
      { noremap = true, desc = "DapUI Toggle" }
    )
    vim.keymap.set("n", "<leader>dUu",
      function() require("dapui").toggle({ reset = false }) end,
      { noremap = true, desc = "DapUI Toggle" }
    )

    ---@Close UI
    vim.keymap.set("n", "<leader>dUC",
      function() require("dapui").close() end,
      { noremap = true, desc = "DapUI Close" }
    )


    ---@UI Widget Hover
    vim.keymap.set({ "n", "v" }, "<leader>dwh",
      function() require("dap.ui.widgets").hover() end,
      { noremap = true, silent = true, desc = "Widget Hover" }
    )

    ---@UI Widget Preview
    vim.keymap.set({ "n", "v" }, "<leader>dwp",
      function() require("dap.ui.widgets").preview() end,
      { noremap = true, silent = true, desc = "Widget Preview" }
    )

    ---@UI Widget Frames
    vim.keymap.set("n", "<leader>dwf",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      { noremap = true, silent = true, desc = "Widget Frames" }
    )

    vim.keymap.set("n", "<Leader>dws",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      { noremap = true, silent = true, desc = "Widget Scopes" }
    )
  end
}
