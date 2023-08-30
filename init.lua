local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end



require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- Add your plugins here
end)



-- Keybinding for NERDTree
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })




-- Basic Key mappings
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':x<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>\\', ':vsp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>[', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>]', '<C-w>l', { noremap = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<Leader>{', ':bprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>}', ':bnext<CR>', { noremap = true })


vim.cmd('syntax enable')
vim.wo.number = true
-- Equivalent of 'set relativenumber'
-- vim.wo.relativenumber = true  -- Uncomment this line if you want relative numbers
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
-- Equivalent of 'set autoindent'
-- vim.bo.autoindent = true  -- Uncomment this line if you want auto-indent
vim.o.mouse = 'a'
-- Equivalent of 'colorscheme gruvbox'
vim.cmd('colorscheme slate')
-- vim.cmd('colorscheme gruvbox')
vim.cmd('filetype plugin indent on')

