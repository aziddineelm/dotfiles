-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
--:ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop
--
-- See the kickstart.nvim README for more information
return {

	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false, -- Ensure it loads automatically
	-- },

	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		main = "nvim-silicon",
		opts = {
			-- Configuration here, or leave empty to use defaults
			line_offset = function(args)
				return args.line1
			end,
		},
	},

	-- barbra for the tabs when you open a buffer or something like that
	{
		"romgrk/barbar.nvim",
		dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
		init = function()
			vim.g.barbar_auto_setup = false -- Good to disable auto setup
		end,
		opts = {
			animation = true, -- Enable animation for smoother transitions
			insert_at_start = true, -- Insert new tabs at the beginning
			-- Hide inactive buffers (cleaner look)
			hide = { extensions = { "alpha" } }, -- Example: Hide alpha.nvim start screen
			-- Add a close button
			close_on_del = true,
			-- More customization options:
			-- clickable = true, -- Make tabs clickable
			-- auto_hide = false, -- Only hide when there's only one tab
			maximum_tabs = 10, -- Limit the number of tabs displayed
			-- tab_name = { -- Customize how tab names are displayed
			--   function(buffer)
			--     return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t")
			--   end,
			-- },
		},
		version = "^1.0.0",
	},

	-- autopairs to pair special character like ("{", "[", ...)
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {
				map = "<C-e>", -- Example: Use Ctrl+e for fast wrapping
				chars = { "{", "[", "(", '"', "'" },
			},
			disable_filetype = { "TelescopePrompt", "vim", "cmp_docs" }, -- Add cmp_docs
			check_ts = true, -- Enable tree-sitter integration for more accurate pairing
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- Setup cmp for autopairs (improved)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map = true })) -- Map the function
		end,
	},
}
