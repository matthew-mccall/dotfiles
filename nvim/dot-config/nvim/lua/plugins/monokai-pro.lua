return {
    "matthew-mccall/monokai-pro.nvim",
    branch = "feature-get-macos-appearance",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("monokai-pro").setup({
            day_night = {
                enable = true,
                day_filter = "light",
                night_filter = "spectrum",
            }
        })
        -- load the colorscheme here
        vim.cmd([[colorscheme monokai-pro]])
    end,
}
