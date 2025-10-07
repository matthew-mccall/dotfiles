return {
    'hrsh7th/nvim-cmp',
    dependendies = {
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',

        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline'
    },
    config = function()
        local cmp = require 'cmp'
        local snippy = require 'snippy'

        local has_words_before = function ()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('snippy').expand_snippet(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snippy.can_expand_or_advance() then
                        snippy.expand_or_advance()
                    elseif has_words_before() and cmp.visible() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif snippy.can_jump(-1) then
                        snippy.previous()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<CR>'] = cmp.mapping.confirm({ select = true })
            }),
            sources = cmp.config.sources(
                { { name = 'snippy' } }, 
                { { name = 'buffer'} })
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                { { name = 'path' } }, 
                { { name = 'cmdline' } 
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
    end
}
