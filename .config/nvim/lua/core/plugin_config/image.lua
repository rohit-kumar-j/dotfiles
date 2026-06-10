return {
  "3rd/image.nvim",
  build = false,
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
      markdown = { enabled = false },
      neorg    = { enabled = false },
      rst      = { enabled = false },
      typst    = { enabled = false },
      html     = { enabled = false },
      css      = { enabled = false },
    },
  },
  config = function(_, opts)
    require("image").setup(opts)

    local image       = require("image")
    local current_img = nil
    local float_win   = nil
    local float_buf   = nil
    local last_line   = nil  -- track line to skip horizontal redraws

    local IMG_W   = 60
    local IMG_H   = 30
    local PADDING = 2

    local img_ext = { png=true, jpg=true, jpeg=true, gif=true, webp=true, avif=true }

    local function clear_preview()
      if current_img then current_img:clear(); current_img = nil end
      if float_win and vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
      end
      float_win, float_buf = nil, nil
    end

    local function show_preview(path)
      -- guard: file must exist before handing to magick
      if vim.fn.filereadable(path) == 0 then clear_preview(); return end

      clear_preview()
      local win   = vim.api.nvim_get_current_win()
      local pos   = vim.api.nvim_win_get_position(win)
      local win_w = vim.api.nvim_win_get_width(win)
      local win_h = vim.api.nvim_win_get_height(win)
      local img_w = math.min(IMG_W, win_w - PADDING * 2)
      local img_h = math.min(IMG_H, win_h - PADDING * 2)

      float_buf = vim.api.nvim_create_buf(false, true)
      float_win = vim.api.nvim_open_win(float_buf, false, {
        relative = "editor",
        row      = pos[1] + PADDING,
        col      = pos[2] + win_w - img_w - PADDING,
        width    = img_w,
        height   = img_h,
        style    = "minimal",
        border   = "none",
        zindex   = 50,
      })

      current_img = image.from_file(path, {
        window = float_win,
        buffer = float_buf,
        x      = 0,
        y      = 0,
        width  = img_w,
        height = img_h,
      })
      if current_img then current_img:render() end
    end

    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        if vim.bo.filetype ~= "oil" then return end

        -- skip redraw if only moved horizontally
        local line = vim.fn.line(".")
        if line == last_line then return end
        last_line = line

        local entry = require("oil").get_cursor_entry()
        if not entry or entry.type ~= "file" then clear_preview(); return end

        local ext = entry.name:match("%.(%w+)$")
        if not ext or not img_ext[ext:lower()] then clear_preview(); return end

        show_preview(require("oil").get_current_dir() .. entry.name)
      end,
    })

    vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
      callback = function()
        if vim.bo.filetype == "oil" then
          clear_preview()
          last_line = nil
        end
      end,
    })
  end,
}
