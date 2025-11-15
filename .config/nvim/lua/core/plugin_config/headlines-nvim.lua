return {
  "lukas-reineke/headlines.nvim",
  enabled = vim.api.nvim_get_var("useMarkdownHeadlines"),
  event = "BufReadPre",
  ft = { "markdown", "org", "norg" },
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = true,
  init = function()
    require("headlines").setup {
      markdown = {
        query = vim.treesitter.query.parse(
          "markdown",
          [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
        ),
        headline_highlights = { "Headline" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = false,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "▃",
      },
    }
  end
}
