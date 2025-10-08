-- Variable global para rastrear si el usuario navegó manualmente
local user_navigated = false

return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 250,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },

            list = {
                selection = function(ctx)
                    return ctx.mode == "cmdline" and "auto_insert" or "manual"
                end,
            },

            menu = {
                border = "rounded",

                cmdline_position = function()
                    if vim.g.ui_cmdline_pos ~= nil then
                        local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                        return { pos[1] - 1, pos[2] }
                    end
                    local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                    return { vim.o.lines - height, 0 }
                end,

                draw = {
                    columns = {
                        { "kind_icon", "label", gap = 1 },
                        { "kind" },
                    },
                    components = {
                        kind_icon = {
                            text = function(item)
                                local kind = require("lspkind").symbol_map[item.kind] or ""
                                return kind .. " "
                            end,
                            highlight = "CmpItemKind",
                        },
                        label = {
                            text = function(item)
                                return item.label
                            end,
                            highlight = "CmpItemAbbr",
                        },
                        kind = {
                            text = function(item)
                                return item.kind
                            end,
                            highlight = "CmpItemKind",
                        },
                    },
                },
            },
        },

        keymap = {
            ["<C-space>"] = { 
                function(cmp) 
                    user_navigated = false
                    return cmp.show()
                end,
                "show_documentation", 
                "hide_documentation" 
            },
            ["<C-e>"] = { 
                function(cmp)
                    user_navigated = false
                    return cmp.hide()
                end,
                "fallback" 
            },
            
            -- Enter: solo acepta si el usuario navegó manualmente
            ["<CR>"] = { 
                function(cmp)
                    if cmp.is_visible() and user_navigated and cmp.get_selected_item() then
                        return cmp.accept()
                    else
                        user_navigated = false
                        return cmp.fallback() -- Permite salto de línea normal
                    end
                end,
                "fallback"
            },

            -- Tab completamente libre para Copilot
            ["<Tab>"] = { "fallback" },
            ["<S-Tab>"] = { "fallback" },

            -- Flechas: marcan que el usuario navegó manualmente
            ["<Up>"] = { 
                function(cmp)
                    if cmp.is_visible() then
                        user_navigated = true
                        return cmp.select_prev()
                    end
                    return cmp.fallback()
                end,
                "fallback" 
            },
            ["<Down>"] = { 
                function(cmp)
                    if cmp.is_visible() then
                        user_navigated = true
                        return cmp.select_next()
                    end
                    return cmp.fallback()
                end,
                "fallback" 
            },
            
            -- Ctrl+p/n: también marcan navegación manual
            ["<C-p>"] = { 
                function(cmp)
                    if cmp.is_visible() then
                        user_navigated = true
                        return cmp.select_prev()
                    end
                    return cmp.fallback()
                end,
                "fallback" 
            },
            ["<C-n>"] = { 
                function(cmp)
                    if cmp.is_visible() then
                        user_navigated = true
                        return cmp.select_next()
                    end
                    return cmp.fallback()
                end,
                "fallback" 
            },
            
            ["<C-up>"] = { "scroll_documentation_up", "fallback" },
            ["<C-down>"] = { "scroll_documentation_down", "fallback" },
        },

        -- Experimental signature help support
        signature = {
            enabled = true,
            window = { border = "rounded" },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            cmdline = {}, -- Disable sources for command-line mode
            providers = {
                lsp = {
                    min_keyword_length = 2, -- Number of characters to trigger porvider
                    score_offset = 0, -- Boost/penalize the score of the items
                },
                path = {
                    min_keyword_length = 0,
                },
                snippets = {
                    min_keyword_length = 2,
                },
                buffer = {
                    min_keyword_length = 5,
                    max_items = 5,
                },
            },
        },
    },
}