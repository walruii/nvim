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
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		--- File Explorer
		{
			"stevearc/oil.nvim",
			-- lazy = false,
			opts = {},
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
		},

		--- THEME
		{
			"tiagovla/tokyodark.nvim",
			-- lazy = false,
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

		--- autotags
		{
			"windwp/nvim-ts-autotag",
			-- lazy = false,
			config = function()
				require("nvim-ts-autotag").setup({})
			end,
		},

		--- Tmux Navigation
		{
			"alexghergh/nvim-tmux-navigation",
			config = function()
				local nvim_tmux_nav = require("nvim-tmux-navigation")
				nvim_tmux_nav.setup({
					disable_when_zoomed = true, -- defaults to false
				})
				vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
				vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
				vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
				vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
				vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
				vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
			end,
		},

		--- Treesitter
		{
			"https://github.com/nvim-treesitter/nvim-treesitter",
			-- lazy = false,
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
					sync_install = false,
					auto_install = true,
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
				})
			end,
		},

		--- Telescope
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
			-- lazy = false,
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>o", function()
					require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
				end, { desc = "Telescope find files (CWD)" })
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
				vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			end,
		},

		---- Mason
		{
			"mason-org/mason.nvim",
			opts = {},
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
					build = "make install_jsregexp",
				},
				"rafamadriz/friendly-snippets",
				"onsails/lspkind.nvim", -- vs-code like pictograms
			},
			-- lazy = false,
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

		--- LSPConfig
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				{ "folke/neodev.nvim", opts = {} },
			},
			-- lazy = false,
			config = function()
				local lspconfig = require("lspconfig")
				local mason_lspconfig = require("mason-lspconfig")
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				-- Setup diagnostics
				vim.diagnostic.config({
					virtual_text = false,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})

				-- On attach function for setting up buffer-local keymaps
				local on_attach = function(client, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = bufnr }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					-- Global diagnostics keymaps
					vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
					vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

					-- Format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end
				lspconfig["tailwindcss"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					init_options = {
						userLanguages = {
							typescript = "javascript",
							typescriptreact = "javascript",
						},
					},
					root_dir = lspconfig.util.root_pattern(
						"tailwind.config.js",
						"tailwind.config.ts",
						"postcss.config.js",
						"package.json"
					),
				})

				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
		},

		--- formatter
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

		--- gitsigns
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

		--- Copilot
		{
			"github/copilot.vim",
		},

		--- CopilotChat
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
				{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			},
			build = "make tiktoken", -- Only on MacOS or Linux
			opts = {
				-- See Configuration section for options
			},
			keys = {
				{
					"<leader>zc",
					":CopilotChat<CR>",
					mode = "n",
					desc = "Chat with Copilot",
				},
				{
					"<leader>ze",
					":CopilotChatExplain<CR>",
					mode = "v",
					desc = "Explain Code",
				},
				{
					"<leader>zr",
					":CopilotChatReview<CR>",
					mode = "v",
					desc = "Review Code",
				},
				{
					"<leader>zf",
					":CopilotChatFix<CR>",
					mode = "v",
					desc = "Fix Code Issues",
				},
				{
					"<leader>zo",
					":CopilotChatOptimize<CR>",
					mode = "v",
					desc = "Optimize Code",
				},
				{
					"<leader>zd",
					":CopilotChatDocs<CR>",
					mode = "v",
					desc = "Generate Docs",
				},
				{
					"<leader>zt",
					":CopilotChatTests<CR>",
					mode = "v",
					desc = "Generate Tests",
				},
				{
					"<leader>zm",
					":CopilotChatCommit<CR>",
					mode = "n",
					desc = "Generate Commit Message",
				},
				{
					"<leader>zs",
					":CopilotChatCommit<CR>",
					mode = "v",
					desc = "Generate Commit for Selection",
				},
			},
		},

		--- Obsidian
		{
			"epwalsh/obsidian.nvim",
			version = "*", -- recommended, use latest release instead of latest commit
			lazy = false,
			ft = "markdown",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Open backlinks" },
				{ "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open Obsidian Quick Switch" },
				{ "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Dailies" },
			},
			opts = {
				workspaces = {
					{
						name = "ARGUS",
						path = "/Users/walruii/Library/Mobile Documents/iCloud~md~obsidian/Documents/ARGUS",
					},
				},
				note_id_func = function(title)
					return title
				end,
			},
		},
	},

	checker = { enabled = true },
})
