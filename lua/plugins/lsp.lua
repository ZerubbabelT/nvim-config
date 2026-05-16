return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Create LSP keybindings on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
      end,
    })

    -- UI Customization
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    
    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = { border = "rounded" },
      signs = true,
    })

    -- LSP Server Setup
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "intelephense",
        "ts_ls",
        "eslint",
        "gopls",
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { library = { vim.env.VIMRUNTIME } },
              },
            },
          })
        end,
      },
    })
  end,
}
