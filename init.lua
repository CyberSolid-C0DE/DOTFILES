-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',
       			dependencies = { 'nvim-lua/plenary.nvim' }
    		},
     		
		{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
		{"norcalli/nvim-colorizer.lua"},  
		{"nvim-tree/nvim-tree.lua"},


	},
 


  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd.colorscheme "catppuccin"

vim.wo.number = true

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', "<C-m>", ":NvimTreeToggle<CR>", {})
vim.keymap.set('n', "<C-n>", ":NvimTreeOpen<CR>", {})

--treesitter config 

local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
})

require'colorizer'.setup(
{'*';},
{
RGB = true; -- #RGB hex codes
RRGGBB = true; -- #RRGGBB hex codes
names = false; -- "Name" codes like Blue
RRGGBBAA = true; -- #RRGGBBAA hex codes
rgb_fn = true; -- CSS rgb() and rgba() functions
hsl_fn = true; -- CSS hsl() and hsla() functions
css = true; -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
css_fn = true; -- Enable all CSS *functions*: rgb_fn, hsl_fn
mode = 'background'; -- Set the display mode.
})



vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})


