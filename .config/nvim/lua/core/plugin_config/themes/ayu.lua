local user_ayu = {}
--- Example visual select colors
--  make sure you set vim.o.backgorund='light' in your init.lua
function user_ayu.get_visual_bg()
  if vim.o.background == "dark" then
    return { bg = "#666666" }
  else
    return { bg = "#000000" }
  end
end

local transparent = true
local my_overrides = {}

if transparent then
  my_overrides = {
    Normal = { bg = "None" },
    NormalFloat = { bg = "None" },
    ColorColumn = { bg = "None" },
    SignColumn = { bg = "None" },
    Folded = {
      bg = "None",
      -- bg = "#333333",
    },
    FoldColumn = { bg = "None", fg = "#AAAAAA" },
    CursorLine = { bg = "None" },
    Comment = { fg = "#AAAAAA" },
    CursorColumn = { bg = "None" },
    Search = { fg = "#FFFFFF", bg = "#235347" },
    Visual = user_ayu.get_visual_bg(),
    LineNr = { fg = "#AAAAAA" }, -- This is for transparency
    WhichKeyFloat = { bg = "None" },
    VertSplit = { bg = "None" },
    -- EndOfBuffer = { fg = "blue" },
    -- NonText = { bg = "blue" },
    -- vim.cmd([[:hi EndOfBuffer ctermfg=blue ctermbg=None]])
    -- vim.cmd([[:hi NonText ctermfg=12 guibg=bule]])
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "lightblue" })
    -- vim.opt.fillchars = { eob = "~" }

  }
else
  my_overrides = nil
end

return {
  "Shatur/neovim-ayu",
  priority = 1000,
  config = function()
    require("ayu").setup({
      overrides = my_overrides,
      -- overrides = { Normal = { bg = "#1d2021" } }
    })

    -- vim.cmd([[colorscheme ayu-mirage]])
  end,
}
