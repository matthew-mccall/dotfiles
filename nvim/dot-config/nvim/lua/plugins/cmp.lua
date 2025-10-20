return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',

        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'micangl/cmp-vimtex'
    },
    config = function()
        local cmp = require 'cmp'
        local snippy = require 'snippy'

        local has_words_before = function()
            local unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local default_sources = cmp.config.sources(
            { { name = 'snippy' } },
            { { name = 'buffer' } }
        )

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
                    elseif has_words_before() then
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
            sources = default_sources
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

        -- Filetype-specific completion sources (scalable dictionary)
        -- Each value can be either a table of sources or a function that
        -- returns a composed sources table (useful to combine with defaults).
        local filetype_sources = {
            tex = cmp.config.sources({ { name = 'vimtex' } }, default_sources),
        }

        for ft, sources in pairs(filetype_sources) do
            if sources then
                cmp.setup.filetype(ft, { sources = sources })
            end
        end
    end
}
