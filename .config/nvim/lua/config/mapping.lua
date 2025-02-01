local set = vim.keymap.set

-- Move cursor left/right in insert mode
set("i", "<C-h>", "<Left>", { desc = "Move cursor left in insert mode" })
set("i", "<C-l>", "<Right>", { desc = "Move cursor right in insert mode" })

-- Optionally, add similar mappings for up/down (Ctrl+j/k) if you want:
set("i", "<C-j>", "<Down>", { desc = "Move cursor down in insert mode" })
set("i", "<C-k>", "<Up>", { desc = "Move cursor up in insert mode" })

set("v", "<C-n>", ":NvimTreeToggle<CR>")
set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- Resize splits
set("n", "<M-l>", "<C-w>5>", { desc = "Move focus to the upper window" })
set("n", "<M-h>", "<C-w>5<", { desc = "Move focus to the upper window" })
set("n", "<M-+>", "<C-w>+", { desc = "Move focus to the upper window" })
set("n", "<M-->", "<C-w>-", { desc = "Move focus to the upper window" })

-- Moving selection
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stdheader
set("n", "<leader>42", ":source ~/.config/nvim/stdheader.vim<CR>:Stdheader<CR>", { desc = "42 header" })

-- Key mappings for barbar.nvim
set("n", "<Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
set("n", "<leader>x", ":bd<CR>", { noremap = true, silent = true }) --For closing tab

-- Copying to clipboard
set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y')

-- Cutting to clipboard
set("n", "<leader>d", '"+d')
set("v", "<leader>d", '"+d')
set("n", "<leader>D", '"+D')

-- Pasting from clipboard
set("n", "<leader>p", '"+p')
set("v", "<leader>p", '"+p')
set("n", "<leader>P", '"+P')
set("v", "p", '"_dP')

-- Smooth scrolling
set(
	"n",
	"<C-D>",
	"<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>",
	{ desc = "Move focus to the upper window" }
)
set(
	"n",
	"<C-U>",
	"<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>",
	{ desc = "Move focus to the upper window" }
)

-- Toggle relative numbers
set("n", "<leader>rN", function()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
		print("Relative numbers OFF")
	else
		vim.wo.relativenumber = true
		vim.wo.number = true
		print("Relative numbers ON")
	end
end, { desc = "Toggle Relative Numbers" })

set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true, silent = false })

-- Close the current buffer
set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current buffer" })

-- Close the current buffer without saving changes
set("n", "<leader>bd!", ":bdelete!<CR>", { desc = "Force close current buffer" })

-- Close all buffers except the current one
set("n", "<leader>bo", ":%bufdo if bufnr('%') != bufnr('$') | bdelete | endif<CR>", { desc = "Close other buffers" })

-- Close a specific buffer by its number
set("n", "<leader>bs", ":bdelete ", { desc = "Close specific buffer (enter buffer number)" })

-- List all buffers (to choose one to delete or switch to)
set("n", "<leader>bl", ":ls<CR>", { desc = "List all buffers" })

-- See installed colorschem
set("n", "<leader>ct", ":Telescope colorscheme<CR>", { noremap = true, silent = true })
