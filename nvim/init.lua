vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("~/.vim/undodar")
vim.opt.undofile = true
vim.opt.scrolloff = 8

vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161A1D", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#D4D4D4", fg = "#161A1D" })

vim.api.nvim_set_hl(0, "StatusLine", {
	bg = "#161A1D",
	fg = "#D4D4D4",
})

vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#6B7078", bg = "NONE" })

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.smartindent = true

vim.opt.updatetime = 50

vim.opt.statusline = "%f%h%m%r%w%=  %y %l,%c | %P | %{strftime('%H:%M')}"

vim.opt.shortmess:append("c")
vim.opt.completeopt = { "popup", "menuone", "noinsert" }

vim.opt.path = { ".", "**" }
vim.opt.wildignore:append({
	"**/node_modules/**",
	"**/dist/**",
	"**/build/**",
	"**/.git/**",
	"**/.next/**",
	"**/.turbo/**",
	"**/.cache/**",
	"**/coverage/**",
	"**/out/**",
})

vim.g.mapleader = " "
vim.opt.wrap = false

local highlightGroup = vim.api.nvim_create_augroup("highlight-yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Hightlight when yanking (copying) text",
	group = highlightGroup,
	callback = function()
		vim.highlight.on_yank({ timeout = 80 })
	end,
})

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the top window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the bottom window" })

vim.keymap.set("n", "n", "nzzzv", { desc = "center after next search match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "center after previous search match" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "center after half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "center after half page up" })

vim.keymap.set("n", "<leader>fd", ":find ", { desc = "Find file" })
vim.keymap.set("n", "<leader>e", ":edit ", { desc = "Edit file" })
vim.keymap.set("n", "<leader>g", ":grep ", { desc = "Grep" })
vim.keymap.set("n", "<leader>b", ":buffer ", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>d", ":bd ", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>l", ":ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>nl", ":nohl<CR>", { desc = "List buffers" })

require("config.lazy")

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

vim.lsp.enable({ "lua_ls", "ts_ls", "gopls" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLSPConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local keymap = vim.keymap

		opts.desc = "Go to definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Go to implementation"
		keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		opts.desc = "Go To Reference"
		keymap.set("n", "gr", vim.lsp.buf.references, opts)

		opts.desc = "Rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Diagnostics"
		keymap.set("n", "<leader>ed", vim.diagnostic.open_float, opts)

		opts.desc = "Hover"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

		opts.desc = "Workspace Symbol"
		keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)

		opts.desc = "Code Actions"
		keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.path = { ".", "**" }
	end,
})
