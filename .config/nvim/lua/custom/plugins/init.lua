-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
--:ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop
--
-- See the kickstart.nvim README for more information
return {

	-- {
	-- 	"Pocco81/auto-save.nvim",
	-- 	config = function()
	-- 		require("auto-save").setup({
	-- 			-- your config goes here
	-- 			-- or just leave it empty :)
	-- 		})
	-- 	end,
	-- },

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

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			local logo = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            {
              action = [[lua require("lazyvim.util").telescope.config_files()()]],
              desc = " Config",
              icon = " ",
              key = "c"
            },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},

	-- Setup cmdline completions
	-- require("cmp").setup.cmdline(":", {
	-- 	mapping = require("cmp").mapping.preset.cmdline(),
	-- 	sources = require("cmp").config.sources({
	-- 		{ name = "path" },
	-- 	}, {
	-- 		{
	-- 			name = "cmdline",
	-- 			option = {
	-- 				ignore_cmds = { "Man", "!" },
	-- 			},
	-- 		},
	-- 	}),
	-- }),
	--
	-- require("cmp").setup.cmdline("/", {
	-- 	mapping = require("cmp").mapping.preset.cmdline(),
	-- 	sources = {
	-- 		{ name = "buffer" },
	-- 	},
	-- }),
}
