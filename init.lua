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
  use { 'junegunn/goyo.vim' }
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {"python", "javascript"},  -- list of languages you want to enable
      highlight = {
        enable = true,  -- enable highlighting
      },
    }
  end,
} 
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


-- Use <TAB> and <Shift-TAB> to navigate the completion menu:
vim.api.nvim_set_keymap('i', '<TAB>', [[pumvisible() ? "\<C-n>" : "\<TAB>"]], {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<S-TAB>"]], {expr = true, noremap = true})

-- Use <Enter> to confirm completion, `<C-g>u` means break undo chain at current position:
vim.api.nvim_set_keymap('i', '<CR>', [[pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]], {expr = true, noremap = true})



-- Set Tabs Spacing
vim.cmd[[autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab]]


-- Basic Key mappings
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':x<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>\\', ':vsp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>[', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>]', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', [[<Cmd>lua vim.api.nvim_buf_delete(0, { force = true })<CR>]], { noremap = true, silent = true })





-- Buffer navigation
vim.api.nvim_set_keymap('n', '<Leader>{', ':bprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>}', ':bnext<CR>', { noremap = true })


vim.cmd('syntax enable')
vim.wo.number = true
-- Equivalent of 'set relativenumber'
-- vim.wo.relativenumber = true  -- Uncomment this line if you want relative numbers
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
-- Equivalent of 'set autoindent'
-- vim.bo.autoindent = true  -- Uncomment this line if you want auto-indent
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

vim.api.nvim_set_keymap('n', '<leader>g', [[<Cmd>Goyo<CR>]], { noremap = true, silent = true })
vim.api.nvim_exec([[
  function! s:goyo_enter()
    set number
  endfunction

  function! s:goyo_leave()
    set nonumber
  endfunction

  autocmd! User GoyoEnter nested call s:goyo_enter()
  autocmd! User GoyoLeave nested call s:goyo_leave()
]], false)



