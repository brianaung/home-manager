return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	},
	event = 'InsertEnter',
	opts = function()
		local cmp = require('cmp')
		local ls = require('luasnip')
		return {
			mapping = {
				['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
				['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
				['<C-u>'] = cmp.mapping.scroll_docs(4),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-e>'] = cmp.mapping.abort(),
				['<tab>'] = cmp.config.disable,
				['<C-space>'] = cmp.mapping { i = cmp.mapping.complete() },
				['<C-y>'] = cmp.mapping(
					cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
					{ 'i', 'c' }
				),
				['<C-k>'] = cmp.mapping(function()
					if ls.expand_or_jumpable() then ls.expand_or_jump() end
				end, { 'i', 's' }),
				['<C-j>'] = cmp.mapping(function()
					if ls.jumpable(-1) then ls.jump(-1) end
				end, { 'i', 's' }),
				['<C-l>'] = cmp.mapping(function()
					if ls.choice_active() then ls.change_choice(1) end
				end),
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			snippet = {
				expand = function(args) require('luasnip').lsp_expand(args.body) end,
			},
		}
	end,
}
