return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "abbr", "menu", "kind" },
          format = function(entry, item)
            local n = entry.source.name
            if n == "nvim_lsp" then
              item.menu = "[LSP]"
            else
              item.menu = string.format("[%s]", n)
            end
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item({ behavior = "select" })
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              fallback()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-d>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
}
