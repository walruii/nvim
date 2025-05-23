-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		--- File Explorer
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			-- Optional dependencies
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
			-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
			-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
			lazy = false,
		},

		--- THEME
		{
			"tiagovla/tokyodark.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd("colorscheme tokyodark")
			end,
		},

		--- AutoPair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end,
		},

		--- Color Wheel
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "*" })
			end,
		},

		--- completion
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-buffer", -- source for text in buffer
				"hrsh7th/cmp-path", -- source for file system paths
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					-- install jsregexp (optional!).
					build = "make install_jsregexp",
				},
				"rafamadriz/friendly-snippets",
				"onsails/lspkind.nvim", -- vs-code like pictograms
			},
			config = function()
				local cmp = require("cmp")
				local lspkind = require("lspkind")
				local luasnip = require("luasnip")

				require("luasnip.loaders.from_vscode").lazy_load()

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-d>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.close(),
						["<CR>"] = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					}),
				})

				vim.cmd([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
			end,
		},

		---- Mason
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
			config = function()
				require("mason").setup()

				require("mason-lspconfig").setup({
					automatic_installation = true,
					ensure_installed = {
						"cssls",
						"eslint",
						"html",
						"jsonls",
						"pyright",
						"tailwindcss",
					},
				})

				require("mason-tool-installer").setup({
					ensure_installed = {
						"prettier",
						"stylua", -- lua formatter
						"isort", -- python formatter
						"black", -- python formatter
						"pylint",
						"eslint_d",
					},
				})
			end,
		},

		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{ "folke/neodev.nvim", opts = {} },
			},
			config = function()
				local nvim_lsp = require("lspconfig")
				local mason_lspconfig = require("mason-lspconfig")

				local protocol = require("vim.lsp.protocol")

				local on_attach = function(client, bufnr)
					-- format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("Format", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end

				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				-- 		mason_lspconfig.setup_handlers({
				-- 			function(server)
				-- 				nvim_lsp[server].setup({
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["cssls"] = function()
				-- 				nvim_lsp["cssls"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["tailwindcss"] = function()
				-- 				nvim_lsp["tailwindcss"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["html"] = function()
				-- 				nvim_lsp["html"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["jsonls"] = function()
				-- 				nvim_lsp["jsonls"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["eslint"] = function()
				-- 				nvim_lsp["eslint"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 			["pyright"] = function()
				-- 				nvim_lsp["pyright"].setup({
				-- 					on_attach = on_attach,
				-- 					capabilities = capabilities,
				-- 				})
				-- 			end,
				-- 		})
			end,
		},
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				local conform = require("conform")

				conform.setup({
					formatters_by_ft = {
						javascript = { "prettier" },
						typescript = { "prettier" },
						javascriptreact = { "prettier" },
						typescriptreact = { "prettier" },
						css = { "prettier" },
						html = { "prettier" },
						json = { "prettier" },
						yaml = { "prettier" },
						markdown = { "prettier" },
						lua = { "stylua" },
						python = { "isort", "black" },
					},
					format_on_save = {
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>f", function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end, { desc = "Format file or range (in visual mode)" })
			end,
		},

		{
			"lewis6991/gitsigns.nvim",
			config = function()
				local gitsigns = require("gitsigns")
				gitsigns.setup({
					signs = {
						add = { text = "│" },
						change = { text = "│" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
						untracked = { text = "┆" },
					},
					signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
					numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
					linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
					word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
					watch_gitdir = {
						interval = 1000,
						follow_files = true,
					},
					attach_to_untracked = true,
					current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
					current_line_blame_opts = {
						virt_text = true,
						virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
						delay = 1000,
						ignore_whitespace = false,
					},
					current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
					sign_priority = 6,
					update_debounce = 100,
					status_formatter = nil, -- Use default
					max_file_length = 40000, -- Disable if file is longer than this (in lines)
					preview_config = {
						-- Options passed to nvim_open_win
						border = "single",
						style = "minimal",
						relative = "cursor",
						row = 0,
						col = 1,
					},
					-- yadm = {
					-- 	enable = false,
					-- },
				})
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- automatically check for plugin updates
	checker = { enabled = true },
})
