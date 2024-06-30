local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

--- Plugins via Packer
return require('packer').startup(function(use)
  use {'zsh-users/zsh-syntax-highlighting'}
  use {'wbthomason/packer.nvim'}
	use {'ctrlpvim/ctrlp.vim'}
	use {'kana/vim-textobj-user'}
	use {'nelstrom/vim-textobj-rubyblock'}
	use {'slim-template/vim-slim'}
	use {'fholgado/minibufexpl.vim'}
	use {'kchmck/vim-coffee-script'}
	use {'romkatv/powerlevel10k'}
	use {'arcticicestudio/nord-vim'}
	use {'qpkorr/vim-bufkill'}
	use {'hashivim/vim-terraform'}
  --  use {'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }
  use {'nvim-lualine/lualine.nvim'}

  -- LSP
  use { "neovim/nvim-lspconfig"} -- enable LSP
  use { "williamboman/mason.nvim"} -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim"}
	use { "jose-elias-alvarez/null-ls.nvim"} -- for formatters and linters
  use { "RRethy/vim-illuminate"}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

end)
