-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("user.plugins")
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

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
  noremap = true
})
--[[
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
  },
})
]]
