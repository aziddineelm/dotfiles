vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	horizontal = {
		buf = -1,
		win = -1,
	},
}

local function create_horizontal_terminal(opts)
	opts = opts or {}
	local height = opts.height or 12
	local tree_width = 0

	-- Check if nvim-tree is open and get its width
	local tree_view = require("nvim-tree.view")
	if tree_view.is_visible() then
		tree_width = tree_view.View.width
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = vim.o.columns - tree_width,
		height = height,
		col = tree_width,
		row = vim.o.lines - height,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
		focusable = true,
	}

	-- Reuse the existing buffer if valid; otherwise, create a new one
	local buf = state.horizontal.buf
	if not vim.api.nvim_buf_is_valid(buf) then
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
		state.horizontal.buf = buf
	end

	-- Create the horizontal window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	-- Configure the window
	vim.api.nvim_win_set_option(win, "winfixheight", true)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	-- Check if the terminal is already open
	if vim.api.nvim_win_is_valid(state.horizontal.win) then
		-- Close the terminal
		vim.api.nvim_win_hide(state.horizontal.win)
		state.horizontal.win = -1
	else
		-- Open or reuse the terminal
		state.horizontal = create_horizontal_terminal({ buf = state.horizontal.buf })

		-- Check if the buffer is already a terminal; if not, make it a terminal
		if vim.bo[state.horizontal.buf].buftype ~= "terminal" then
			vim.cmd("term") -- Turn the buffer into a terminal
		end

		-- Enter insert mode automatically
		vim.cmd("startinsert")
	end
end

-- Automatically set options for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-settings", {}),
	callback = function()
		local set = vim.opt_local
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0
		vim.bo.filetype = "terminal"
	end,
})

-- Example usage:
vim.api.nvim_create_user_command("ToggleTerminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>ty", toggle_terminal)

return {}
