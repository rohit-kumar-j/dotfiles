return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  enabled = vim.api.nvim_get_var("useCMP"),
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    {"hrsh7th/cmp-buffer", build = "make install_jsregexp"},
    {"hrsh7th/cmp-nvim-lua", build = "make install_jsregexp" },
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "chrisgrieser/cmp-nerdfont",
    "ray-x/cmp-treesitter",
    {"L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local vim                     = vim
    local lspkind                 = require("lspkind")

    local cmp                     = require("cmp")
    local types                   = require("cmp.types")
    local str                     = require("cmp.utils.str")

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end

    luasnip.config.set_config({
      history = true,                            --keep around last snippet local to jump back
      updateevents = "TextChanged,TextChangedI", --update changes as you type
      enable_autosnippets = true,
    })

    -- Load friendly-snippets (VSCode format) into LuaSnip
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Load honza/vim-snippets (SnipMate format) into LuaSnip
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- Custom snippets
    local s = luasnip.snippet
    local t = luasnip.text_node
    local i = luasnip.insert_node
    luasnip.add_snippets("python", {
      s("defmain", {
        t("def main(argc, argv):"),
        t({"", "\t"}), i(1, "pass"),
      }),
    })

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local neogen_ok, neogen = pcall(require, "neogen")

    local compare = require("cmp.config.compare")
    local lsp = require("cmp.types").lsp

    -- Deprioritize Keywords and Text below real completions (Class, Function, Variable, Snippet, etc.)
    local lspkind_comparator = function(entry1, entry2)
      local kind1 = entry1:get_kind()
      local kind2 = entry2:get_kind()
      local deprioritized = { [lsp.CompletionItemKind.Keyword] = true, [lsp.CompletionItemKind.Text] = true }
      local dep1 = deprioritized[kind1] or false
      local dep2 = deprioritized[kind2] or false
      if dep1 ~= dep2 then
        return not dep1
      end
      return nil
    end

    -- Among snippets, prefer longer/more verbose ones (classi~ > class~)
    local snippet_verbosity = function(entry1, entry2)
      local kind1 = entry1:get_kind()
      local kind2 = entry2:get_kind()
      if kind1 == lsp.CompletionItemKind.Snippet and kind2 == lsp.CompletionItemKind.Snippet then
        local word1 = entry1:get_completion_item().insertText or entry1:get_completion_item().label or ""
        local word2 = entry2:get_completion_item().insertText or entry2:get_completion_item().label or ""
        if #word1 ~= #word2 then
          return #word1 > #word2
        end
      end
      return nil
    end

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          lspkind_comparator,
          snippet_verbosity,
          compare.recently_used,
          compare.locality,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),
        ["<C-j>"] = cmp.mapping(
          cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          { "i", "s", "c" }
        ),
        ["<C-k>"] = cmp.mapping(
          cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          { "i", "s", "c" }
        ),
        ["<C-space>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          { "i", "c" }
        ),
        -- Super Tabs!! If there are args of functions, then we can jump between them to insert args!
        ["<C-N>"] = cmp.mapping(function(fallback) -- ["<Tab>"]
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
        ["<C-P>"] = cmp.mapping(function(fallback) -- ["<S-Tab>"]
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(("<Plug>luasnip-expand-or-jump"), "")
          elseif neogen_ok and neogen.jumpable() then
            vim.fn.feedkeys(("<cmd>lua require('neogen').jump_next()<CR>"), "")
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            vim.fn.feedkeys(("<Plug>luasnip-jump-prev"), "")
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "luasnip",  group_index = 1 },
        { name = "buffer",   group_index = 2 },
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      experimental = {
        ghost_text = true,
        native_menu = false,
      },
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp    = "[neovim/nvim-lspconfig]",
              luasnip     = "[L3MON4D3/LuaSnip]",
              buffer      = "[hrsh7th/cmp-buffer]",
              path        = "[hrsh7th/cmp-path]",
              nvim_lua    = "[hrsh7th/cmp-nvim-lua]",
              treesitter  = "[ray-x/cmp-treesitter]",
              emoji       = "[hrsh7th/cmp-emoji]",
              nerdfont    = "[chrisgrieser/cmp-nerdfont]",
            })[entry.source.name]
            return vim_item
          end,
        }
      }
    })
  end
}
