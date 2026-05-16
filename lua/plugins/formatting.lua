return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      python = { "black" },
      lua = { "stylua" },
      go = { "gofmt" },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
