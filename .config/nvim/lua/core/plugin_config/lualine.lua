return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "rohit-kumar-j/cmake-tools.nvim",
  },
  event = "BufReadPre",
  config = function()
    local lualine = require("lualine")
    local icons = require("core.icons")

    -- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local colors = {
      normal = {
        bg       = "#05070b",
        -- bg       = "#0a0e14",
        fg       = "#bbc2cf",
        yellow   = "#ECBE7B",
        cyan     = "#008080",
        darkblue = "#081633",
        green    = "#98be65",
        orange   = "#FF8800",
        y_accent = "#e6b450",
        violet   = "#a9a1e1",
        black    = "#000000",
        magenta  = "#c678dd",
        blue     = "#51afef",
        red      = "#ec5f67",
      },
      nightfly = {
        bg       = "#011627",
        fg       = "#acb4c2",
        yellow   = "#ecc48d",
        cyan     = "#7fdbca",
        darkblue = "#82aaff",
        green    = "#21c7a8",
        orange   = "#e3d18a",
        violet   = "#a9a1e1",
        y_accent = "#e6b450",
        black    = "#000000",
        magenta  = "#ae81ff",
        blue     = "#82aaff ",
        red      = "#ff5874",
      },
      catppuccin_mocha = {
        bg       = "#1E1E2E",
        fg       = "#CDD6F4",
        yellow   = "#F9E2AF",
        cyan     = "#7fdbca",
        darkblue = "#89B4FA",
        green    = "#A6E3A1",
        orange   = "#e3d18a",
        y_accent = "#e6b450",
        black    = "#000000",
        violet   = "#a9a1e1",
        magenta  = "#ae81ff",
        blue     = "#89B4FA",
        red      = "#F38BA8",
      }
    }

    colors = colors.normal;

    local mode_color = {
      n = colors.blue,
      i = colors.green,
      v = colors.y_accent,
      V = colors.y_accent,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.red,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }

    local config = {
      options = {
        icons_enabled = true,
        -- component_separators = { left = '', right = ''},
        section_separators = { left = "", right = "" },
        component_separators = "",
        -- section_separators = "",
        disabled_filetypes = { "alpha", "dashboard", "Outline" },
        always_divide_middle = true,
        -- theme = 'ayu',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = {
            a = { bg = mode_color.n, fg = colors.bg },
            b = { bg = colors.bg, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
            x = { bg = colors.bg, fg = colors.fg },
            y = { bg = colors.bg, fg = colors.fg },
            z = { bg = colors.bg, fg = colors.fg },
          },
          insert = { a = { bg = mode_color.i, fg = colors.bg } },
          command = { a = { bg = mode_color.c, fg = colors.bg } },
          replace = { a = { bg = mode_color.r, fg = colors.bg } },
          visual = { a = { bg = mode_color.v, fg = colors.bg } },
          inactive = { c = { fg = mode_color.bg, bg = colors.bg } },
          -- normal = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- lualine_a = { 'mode' ,
        -- color = function()
        --   return { bg = vim.bo.modified and '#aa3355' or '#33aa88' }
        -- end,
        -- color = function()
        --   return { bg = tostring(mode_color[vim.fn.mode()]) }
        --   -- return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
        -- end
        -- },
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- c for left
        -- lualine_c = { "%=", { 'filename', function() return require('lsp-status').status() end } },
        lualine_c = {},
        -- x for right
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = { "filename" },
        -- lualine_x = { "location" },
      },
      tabline = {},
      extensions = {},
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ins_left {
    --   function()
    --     return icons.ui.Line
    --   end,
    --   color = function()
    --     -- auto change color according to neovims mode
    --     return { fg = mode_color[vim.fn.mode()] }
    --   end,
    --   padding = { left = 0, right = 1 }, -- We don't need space before this
    -- }

    ins_left {
      -- mode component
      function()
        -- return icons.ui.CircleIcon
        return icons.ui.Target
        -- return icons.ui.Vim
      end,
      color = function()
        -- auto change color according to neovims mode
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 1, right = 1 },
    }

    ins_left {
      -- filesize component
      "filesize",
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
    }

    ins_left { "location" }

    ins_left {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        info = icons.diagnostics
            .Information
      },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    }

    if (vim.api.nvim_get_var("useCMakeTools") == true) then
      local cmake = require("cmake-tools")
      ins_left {
        function()
          local c_preset = cmake.get_configure_preset()
          return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
        end,
        icon = icons.ui.Search,
        cond = function()
          return cmake.is_cmake_project() and cmake.has_cmake_preset()
        end,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectConfigurePreset")
            end
          end
        end
      }

      ins_left {
        function()
          local type = cmake.get_build_type()
          return "CMake: [" .. (type and type or "") .. "]"
        end,
        icon = icons.ui.Search,
        cond = function()
          return cmake.is_cmake_project() and not cmake.has_cmake_preset()
        end,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectBuildType")
            end
          end
        end
      }

      ins_left {
        function()
          local kit = cmake.get_kit()
          return "[" .. (kit and kit or "X") .. "]"
        end,
        icon = icons.ui.Pencil,
        cond = function()
          return cmake.is_cmake_project() and not cmake.has_cmake_preset()
        end,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectKit")
            end
          end
        end
      }

      ins_left {
        function()
          return "Build"
        end,
        icon = icons.ui.Gear,
        cond = cmake.is_cmake_project,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeBuild")
            end
          end
        end
      }

      ins_left {
        function()
          local b_preset = cmake.get_build_preset()
          return "[" .. (b_preset and b_preset or "X") .. "]"
        end,
        icon = icons.ui.Search,
        cond = function()
          return cmake.is_cmake_project() and cmake.has_cmake_preset()
        end,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectBuildPreset")
            end
          end
        end
      }

      ins_left {
        function()
          local b_target = cmake.get_build_target()
          return "[" .. (b_target and b_target or "X") .. "]"
        end,
        cond = cmake.is_cmake_project,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectBuildTarget")
            end
          end
        end
      }

      ins_left {
        function()
          return icons.ui.Debug
        end,
        cond = cmake.is_cmake_project,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeDebug")
            end
          end
        end
      }

      ins_left {
        function()
          return icons.ui.Run
        end,
        cond = cmake.is_cmake_project,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeRun")
            end
          end
        end
      }

      ins_left {
        function()
          local l_target = cmake.get_launch_target()
          return "[" .. (l_target and l_target or "X") .. "]"
        end,
        cond = cmake.is_cmake_project,
        on_click = function(n, mouse)
          if (n == 1) then
            if (mouse == "l") then
              vim.cmd("CMakeSelectLaunchTarget")
            end
          end
        end
      }
    end
    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return "%="
      end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        local server_names = {}
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(server_names, client.name)
            -- return client.name
          end
        end
        if #server_names > 0 then
          return table.concat(server_names, ", ")
        else
          return msg
        end
      end,
      icon = " LSP:",
      color = { fg = "#ffffff", gui = "bold" },
    }

    -- Add components to right sections
    ins_right {
      "o:encoding",       -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    }

    -- ins_right {
    --   "fileformat",
    --   fmt = string.upper,
    --   icons_enabled = false,
    --   color = { fg = colors.green, gui = "bold" },
    -- }

    ins_right {
      function()
        local wc = vim.api.nvim_eval("wordcount()")
        if wc["visual_words"] then
          return wc["visual_words"]
        else
          return wc["words"]
        end
      end,
      icon = icons.ui.Page .. ":",
      color = { fg = colors.blue, gui = "bold" },
    }

    ins_right {
      "branch",
      icon = icons.git.Branch,
      color = { fg = colors.violet, gui = "bold" },
    }

    ins_right {
      "diff",
      -- Is it me or the symbol for modified us really weird
      symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function()
        return " " .. icons.ui.Time .. os.date("%H:%M") .. " "
      end,
      color = { fg = colors.violet, gui = "bold" },
    }

    ins_right {
      function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      color = { fg = colors.orange, gui = "bold" }
    }

    ins_right {
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)

    -- Windows Separators
    vim.cmd([[:highlight WinSeparator guibg=None]])
    vim.cmd([[:highlight WinSeparator guifg=#aaaaaa]])
    vim.cmd([[:set laststatus=3]])
  end
}
