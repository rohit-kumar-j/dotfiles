return {
  "kevinhwang91/nvim-ufo",
  enabled      = vim.api.nvim_get_var("useUFO"),
  event        = "VeryLazy",
  dependencies = {
    "kevinhwang91/promise-async"
  },
  config       = function()
    vim.o.foldcolumn = "auto"
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldmethod = "syntax"
    vim.o.foldlevel = 99
    vim.o.foldnestmax = 1 -- Avoids nested folds if = 1

    -- TODO: Redo fillchars

    -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- za toggles single folds. Just using zc instead
    vim.api.nvim_set_keymap("n", "zc", "za",
      { noremap = true, silent = true }
    )

    vim.keymap.set("n", "<leader>1", ":lua require('ufo').closeFoldsWith(0)<cr>", { desc = "1st Lvl Close Fold" })
    vim.keymap.set("n", "<leader>2", ":lua require('ufo').closeFoldsWith(1)<cr>", { desc = "2nd Lvl Close Fold" })
    vim.keymap.set("n", "<leader>3", ":lua require('ufo').closeFoldsWith(2)<cr>", { desc = "3rd Lvl Close Fold" })
    vim.keymap.set("n", "<leader>4", ":lua require('ufo').closeFoldsWith(3)<cr>", { desc = "4th Lvl Close Fold" })

    vim.api.nvim_create_autocmd({ "WinNew" }, {
      group = vim.api.nvim_create_augroup("Fold", { clear = true }),
      pattern = "*",
      callback = function()
        if vim.o.filetype == "help" or vim.o.filetype == "dashboard" or vim.o.filetype == "telescope" or vim.o.filetype == "terminal" then
          return
        end
        -- print("folding............")
        -- pcall(vim.cmd, '%foldclose!') -- This closes all possible folds
        pcall(vim.cmd, "%foldclose") -- This is to close only the outer level fold
      end
    })

    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ("  ↙ %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end

    -- Option 3: treesitter as a main provider instead
    -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`

    require("ufo").setup({
      fold_virt_text_handler = handler,
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0
        },
      }
    })
  end
}
