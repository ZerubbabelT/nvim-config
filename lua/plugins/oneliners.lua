return {
    "wakatime/vim-wakatime",
    lazy = false,
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "black" }, -- or "autopep8"
                    lua = { "stylua" },
                    go = { "gofmt" },
                },
                format_on_save = {
                    lsp_fallback = true,
                },
            })
        end,
    },
}
