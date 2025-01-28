return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive", -- Sort files and directories
				view = {
					adaptive_size = true,
					side = "left",
					width = 30, -- Adjust as needed
				},
				renderer = {
					icons = {
						webdev_colors = true,
						git_placement = "before",
						modified_placement = "after",
						symlink_arrow = " ➛ ",
						padding = "  ",
					},
				},
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				filters = {
					dotfiles = false, -- Show dotfiles by default
				},
			})

			-- Automatically update the tree when changing the directory
			local function on_dir_changed()
				local api = require("nvim-tree.api")
				api.tree.change_root(vim.fn.getcwd())
			end

			vim.api.nvim_create_autocmd("DirChanged", {
				callback = on_dir_changed,
			})
		end,
	},
}
