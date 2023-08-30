-- [[
--
-- ███    ███  ██████  ██ ███████     ███    ██ ██    ██ ██ ███    ███ 
-- ████  ████ ██    ██ ██ ██          ████   ██ ██    ██ ██ ████  ████ 
-- ██ ████ ██ ██    ██ ██ ███████     ██ ██  ██ ██    ██ ██ ██ ████ ██ 
-- ██  ██  ██ ██    ██ ██      ██     ██  ██ ██  ██  ██  ██ ██  ██  ██ 
-- ██      ██  ██████  ██ ███████     ██   ████   ████   ██ ██      ██ 
--                                                                     
-- ]]




local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end



require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdtree'
  use 'gruvbox-community/gruvbox'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'tpope/vim-fugitive'
  use 'honza/vim-snippets'
  use 'Yggdroot/indentLine'
  use 'kyazdani42/nvim-web-devicons'
  use 'sindrets/diffview.nvim'
  use 'mg979/vim-visual-multi'
  use 'tomtom/tcomment_vim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'mattn/emmet-vim'
  use 'ryanoasis/vim-devicons'
end)



-- Keybinding for NERDTree
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>n', ':NERDTreeFind<CR>', { noremap = true, silent = true })
vim.g.webdevicons_enable_nerdtree = 1 

-- Airline Configuration
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g.airline_theme = 'base16'

-- Key Mapping for Telescope
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope live_grep<CR>', { noremap = true, silent = true })



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
vim.bo.autoindent = true  -- Uncomment this line if you want auto-indent
vim.o.mouse = 'a'
vim.cmd('colorscheme slate')
vim.cmd('colorscheme gruvbox')
vim.cmd('filetype plugin indent on')


function toggle_diffview()
    if vim.g.DiffviewIsOpen == 1 then
        vim.cmd("DiffviewClose")
        vim.g.DiffviewIsOpen = 0
    else
        vim.cmd("DiffviewOpen")
        vim.g.DiffviewIsOpen = 1
    end
end

vim.api.nvim_set_keymap('n', '<leader>dt', [[<Cmd>lua toggle_diffview()<CR>]], { noremap = true, silent = true })

vim.g.diffview_use_icons = true

