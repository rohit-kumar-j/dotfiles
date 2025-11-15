return {
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  event = "BufReadPre",
  config = function()
    require("Comment").setup({})
  end
}
