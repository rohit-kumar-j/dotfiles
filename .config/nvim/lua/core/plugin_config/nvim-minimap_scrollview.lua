--stylua: ignore start
H = {}
H.block_symbols = {}

H.block_symbols["1x2"] = { " ", "▌", "▐", "█", resolution = { row = 1, col = 2 } }

H.block_symbols["2x1"] = { " ", "▀", "▄", "█", resolution = { row = 2, col = 1 } }

H.block_symbols["2x2"] = {
  " ", "▘", "▝", "▀", "▖", "▌", "▞", "▛", "▗", "▚", "▐", "▜", "▄", "▙", "▟", "█",
  resolution = { row = 2, col = 2 },
}

H.block_symbols["3x2"] = {
  " ", "🬀", "🬁", "🬂", "🬃", "🬄", "🬅", "🬆", "🬇", "🬈", "🬉", "🬊", "🬋", "🬌", "🬍", "🬎",
  "🬏", "🬐", "🬑", "🬒", "🬓", "▌", "🬔", "🬕", "🬖", "🬗", "🬘", "🬙", "🬚", "🬛", "🬜", "🬝",
  "🬞", "🬟", "🬠", "🬡", "🬢", "🬣", "🬤", "🬥", "🬦", "🬧", "▐", "🬨", "🬩", "🬪", "🬫", "🬬",
  "🬭", "🬮", "🬯", "🬰", "🬱", "🬲", "🬳", "🬴", "🬵", "🬶", "🬷", "🬸", "🬹", "🬺", "🬻", "█",
  resolution = { row = 3, col = 2 },
}

H.dot_symbols = {}

H.dot_symbols["4x2"] = {
  "⠀", "⠁", "⠈", "⠉", "⠂", "⠃", "⠊", "⠋", "⠐", "⠑", "⠘", "⠙", "⠒", "⠓", "⠚", "⠛",
  "⠄", "⠅", "⠌", "⠍", "⠆", "⠇", "⠎", "⠏", "⠔", "⠕", "⠜", "⠝", "⠖", "⠗", "⠞", "⠟",
  "⠠", "⠡", "⠨", "⠩", "⠢", "⠣", "⠪", "⠫", "⠰", "⠱", "⠸", "⠹", "⠲", "⠳", "⠺", "⠻",
  "⠤", "⠥", "⠬", "⠭", "⠦", "⠧", "⠮", "⠯", "⠴", "⠵", "⠼", "⠽", "⠶", "⠷", "⠾", "⠿",
  "⡀", "⡁", "⡈", "⡉", "⡂", "⡃", "⡊", "⡋", "⡐", "⡑", "⡘", "⡙", "⡒", "⡓", "⡚", "⡛",
  "⡄", "⡅", "⡌", "⡍", "⡆", "⡇", "⡎", "⡏", "⡔", "⡕", "⡜", "⡝", "⡖", "⡗", "⡞", "⡟",
  "⡠", "⡡", "⡨", "⡩", "⡢", "⡣", "⡪", "⡫", "⡰", "⡱", "⡸", "⡹", "⡲", "⡳", "⡺", "⡻",
  "⡤", "⡥", "⡬", "⡭", "⡦", "⡧", "⡮", "⡯", "⡴", "⡵", "⡼", "⡽", "⡶", "⡷", "⡾", "⡿",
  "⢀", "⢁", "⢈", "⢉", "⢂", "⢃", "⢊", "⢋", "⢐", "⢑", "⢘", "⢙", "⢒", "⢓", "⢚", "⢛",
  "⢄", "⢅", "⢌", "⢍", "⢆", "⢇", "⢎", "⢏", "⢔", "⢕", "⢜", "⢝", "⢖", "⢗", "⢞", "⢟",
  "⢠", "⢡", "⢨", "⢩", "⢢", "⢣", "⢪", "⢫", "⢰", "⢱", "⢸", "⢹", "⢲", "⢳", "⢺", "⢻",
  "⢤", "⢥", "⢬", "⢭", "⢦", "⢧", "⢮", "⢯", "⢴", "⢵", "⢼", "⢽", "⢶", "⢷", "⢾", "⢿",
  "⣀", "⣁", "⣈", "⣉", "⣂", "⣃", "⣊", "⣋", "⣐", "⣑", "⣘", "⣙", "⣒", "⣓", "⣚", "⣛",
  "⣄", "⣅", "⣌", "⣍", "⣆", "⣇", "⣎", "⣏", "⣔", "⣕", "⣜", "⣝", "⣖", "⣗", "⣞", "⣟",
  "⣠", "⣡", "⣨", "⣩", "⣢", "⣣", "⣪", "⣫", "⣰", "⣱", "⣸", "⣹", "⣲", "⣳", "⣺", "⣻",
  "⣤", "⣥", "⣬", "⣭", "⣦", "⣧", "⣮", "⣯", "⣴", "⣵", "⣼", "⣽", "⣶", "⣷", "⣾", "⣿",
  resolution = { row = 4, col = 2 },
}
--stylua: ignore end
return {
  "echasnovski/mini.map",
  enabled = vim.api.nvim_get_var("useMiniMap"),
  version = false,
  -- event = "BufReadPost",
  keys = {
    { "<leader>mm", "<cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap Toggle" }
  },
  dependencies = {
    "dstein64/nvim-scrollview",
  },
  config = function()
    local map = require("mini.map")
    local diagnostic_integration = map.gen_integration.diagnostic({
      error = "DiagnosticFloatingError",
      warn  = "DiagnosticFloatingWarn",
      info  = "DiagnosticFloatingInfo",
      hint  = "DiagnosticFloatingHint",
    })
    -- Use dots in `st` terminal because it can render them as blocks
    require("mini.map").setup({
      integrations = { diagnostic_integration },
      symbols = { encode = H.dot_symbols["4x2"] },
      window = {
        -- Whether window is focusable in normal way (with `wincmd` or mouse)
        focusable = true,

        -- Side to stick ("left" or "right")
        side = "right",

        -- Whether to show count of multiple integration highlights
        show_integration_count = true,

        -- Total width
        width = 15,

        -- Value of "winblend" option
        winblend = 25,
      },
    })
    vim.keymap.set("n", "<leader>mm", "<cmd>lua MiniMap.toggle()<CR>", { desc = "MiniMap Toggle" })
    vim.keymap.set("n", "<leader>ml", "<cmd>lua MiniMap.toggle_focus()<CR>", { desc = "MiniMap Toggle Focus" })
    vim.keymap.set("n", "<leader>mr", "<cmd>lua MiniMap.refresh()<CR>", { desc = "MiniMap Toggle" })
  end
}
-- TODO: New

-- return {
--   "petertriho/nvim-scrollbar",
--   enabled  = true,
--   event = "BufReadPre",
--   config = function ()
--     require("scrollbar").setup()
--   end
-- }
