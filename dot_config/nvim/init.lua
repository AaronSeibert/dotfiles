-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("user.plugins")
require("user.nvim-tree")
require("user.keymaps")
require("user.lualine")
vim.cmd([[
	filetype plugin indent on
	set ts=2 sw=4
	set expandtab
	set smarttab
	set autoindent
	set nu rnu
	set inccommand=nosplit
	colorscheme nord
  autocmd BufNewFile,BufRead *zshrc* set filetype=zsh
]])

