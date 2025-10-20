return {
    { "nvim-lualine/lualine.nvim", opts = { options = { icons_enabled = false } } },
    "akinsho/bufferline.nvim",
    -- Scheme REPL integration via iron.nvim
    { import = "plugins.iron" },
    'honza/vim-snippets'
}
