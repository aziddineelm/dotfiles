-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
--:ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop
--
-- See the kickstart.nvim README for more information
return {

	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Add the following section to silence notifications during cmdline usage
			messages = {
				enabled = false,
				-- view = "mini",
				-- view_error = "mini",
				-- view_warn = "mini",
				-- view_history = "messages",
				-- view_search = false, -- Disable search notifications
			},
			notify = {
				enabled = false, -- Disable notifications entirely
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries "MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	-- Plugin to create code images using the external silicon tool.
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		main = "nvim-silicon",
		opts = {
			-- Configuration here, or leave empty to use defaults
			theme = "Dracula",
			font = "JetBrainsMono Nerd Font Mono",
			background = "#32343F",
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
}
