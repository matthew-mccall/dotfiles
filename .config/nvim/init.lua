local Plug = vim.fn['plug#']

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.breakindent = true
vim.opt.lbr = true

vim.opt.termguicolors = true
vim.opt.exrc = true

vim.call('plug#begin')

Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

Plug('preservim/nerdtree') 
Plug('ryanoasis/vim-devicons') 

Plug('lervag/vimtex') 
Plug('micangl/cmp-vimtex') 
Plug('dense-analysis/ale') 

Plug('neovim/nvim-lspconfig') 
Plug('hrsh7th/cmp-nvim-lsp') 
Plug('hrsh7th/cmp-buffer') 
Plug('hrsh7th/cmp-path') 
Plug('hrsh7th/cmp-cmdline') 
Plug('hrsh7th/nvim-cmp') 

Plug('SirVer/ultisnips') 
Plug('quangnguyen30192/cmp-nvim-ultisnips') 
Plug('m4xshen/autoclose.nvim') 

vim.call('plug#end')

vim.g.vimtex_view_method = 'skim'

require('lualine').setup()

local bufferline = require("bufferline") 
bufferline.setup {
    options = {
        diasnostics = "nvim_lsp",
        always_show_bufferline = false
    }
}

-- Autoclose $ for inline equations for LaTeX
require("autoclose").setup({
   keys = {
      ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = { "tex" } },
   },
   options = {
       pair_spaces = true,
   }
})

local cmp = require('cmp')

cmp.setup({
    sippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'vimtex', },
    }, {
        { name = 'buffer' }
    }),
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').clangd.setup {
    capabilities = capabilities
}

