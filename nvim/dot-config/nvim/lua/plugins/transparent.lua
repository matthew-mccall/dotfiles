return { 
    "xiyaowong/transparent.nvim", 
    opts = { 
        extra_groups = { "NormalFloat" } 
    },
    config = 
        function()
            vim.cmd([[TransparentEnable]])
        end
}
