-- Configurar friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	-- Mejorar rendimiento del fuzzy matching
	fuzzy = {
		implementation = "lua",
		frecency = {
			enabled = true,
		},
		use_proximity = true,
	},

	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},

	-- Configuración optimizada de snippets
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
		active = function(filter)
			if filter and filter.direction then
				return require("luasnip").jumpable(filter.direction)
			end
			return require("luasnip").in_snippet()
		end,
		jump = function(direction)
			require("luasnip").jump(direction)
		end,
	},

	completion = {
		accept = { 
			auto_brackets = { enabled = true },
		},

		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100, -- Reducir delay para documentación
			treesitter_highlighting = true,
			window = { border = "rounded" },
		},

		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
			max_items = 15, -- Limitar items para mejor rendimiento
		},

		menu = {
			border = "rounded",
			auto_show = true, -- Mostrar automáticamente
			
			cmdline_position = function()
				if vim.g.ui_cmdline_pos ~= nil then
					local pos = vim.g.ui_cmdline_pos
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

	-- Keymaps optimizados para mejor experiencia
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		
		-- Tab para aceptar sugerencias (principal método)
		["<Tab>"] = { 
			function(cmp)
				if cmp.is_visible() and cmp.get_selected_item() then
					return cmp.accept()
				else
					return cmp.fallback()
				end
			end,
			"snippet_forward",
			"fallback"
		},
		
		-- Enter SOLO acepta si hay algo específicamente seleccionado
		["<CR>"] = { 
			function(cmp)
				if cmp.is_visible() and cmp.get_selected_item() then
					return cmp.accept()
				else
					return cmp.fallback() -- Permite salto de línea normal
				end
			end,
			"fallback"
		},
		
		-- Ctrl+y para forzar aceptar la primera sugerencia
		["<C-y>"] = { "accept", "fallback" },
		
		-- Navegación mejorada
		["<S-Tab>"] = { 
			function(cmp)
				if cmp.is_visible() then
					return cmp.select_prev()
				else
					return cmp.snippet_backward() or cmp.fallback()
				end
			end,
			"snippet_backward",
			"fallback"
		},
		
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-up>"] = { "scroll_documentation_up", "fallback" },
		["<C-down>"] = { "scroll_documentation_down", "fallback" },
	},

	signature = {
		enabled = true,
		window = { border = "rounded" },
	},

	-- Configuración optimizada de fuentes
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = {
				min_keyword_length = 1, -- Reducir a 1 para LSP
				score_offset = 100, -- Priorizar LSP
			},
			path = {
				min_keyword_length = 0,
				score_offset = 50,
			},
			snippets = {
				min_keyword_length = 1, -- Reducir para snippets
				score_offset = 80, -- Alta prioridad para snippets
			},
			buffer = {
				min_keyword_length = 2, -- Reducir para mejor respuesta
				max_items = 8,
				score_offset = 10, -- Baja prioridad para buffer
			},
			cmdline = {
				min_keyword_length = 0,
				max_items = 15,
			},
		},
	},

	cmdline = {
		enabled = true,
		sources = function()
			local type = vim.fn.getcmdtype()
			if type == ":" then
				return { "cmdline" }
			end
			if type == "/" or type == "?" then
				return { "buffer" }
			end
			return {}
		end,
		keymap = {
			["<Tab>"] = { "accept", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
		},
	},
})
