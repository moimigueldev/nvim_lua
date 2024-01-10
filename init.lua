--
-- ███    ███  ██████  ██ ███████     ███    ██ ██    ██ ██ ███    ███ 
-- ████  ████ ██    ██ ██ ██          ████   ██ ██    ██ ██ ████  ████ 
-- ██ ████ ██ ██    ██ ██ ███████     ██ ██  ██ ██    ██ ██ ██ ████ ██ 
-- ██  ██  ██ ██    ██ ██      ██     ██  ██ ██  ██  ██  ██ ██  ██  ██ 
-- ██      ██  ██████  ██ ███████     ██   ████   ████   ██ ██      ██ 
--                                                                     




local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end


require('packer').startup(function()
  use 'andymass/vim-matchup'
  use 'gruvbox-community/gruvbox'
  use 'honza/vim-snippets'
  use 'kaicataldo/material.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'luochen1990/rainbow'
  use 'malbertzard/inline-fold.nvim'
  use 'mattn/emmet-vim'
  use 'mg979/vim-visual-multi'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {"python", "javascript", "typescript"},  -- list of languages you want to enable
        highlight = {
          enable = true,  -- enable highlighting
        },
      }
    end,
  }
  use 'nvim-telescope/telescope.nvim'
  use 'Pocco81/Catppuccino.nvim'
  use 'preservim/nerdtree'
  use 'rhysd/vim-clang-format'
  use 'ryanoasis/vim-devicons'
  use 'sindrets/diffview.nvim'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'voldikss/vim-floaterm'
  use 'wbthomason/packer.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'Yggdroot/indentLine'
  use 'nvim-lua/plenary.nvim'
  use 'maxmellon/vim-jsx-pretty'
  use 'sbdchd/neoformat'
end)



local nvim_lsp = require('lspconfig')

-- Configure rust-analyzer as the LSP server for Rust
nvim_lsp.rust_analyzer.setup({
  -- Your configuration options for rust-analyzer here
  -- For example, you can specify custom settings:
-- Within your rust-analyzer setup in nvim_lsp
settings = {
  ["rust-analyzer"] = {
    checkOnSave = {
      command = "clippy",
    },
    rustfmt = {
      enable = false, -- Disable rust-analyzer's formatting
    },
  },
},

})

nvim_lsp.tsserver.setup{
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}
    -- You can add other configurations here as needed
}
nvim_lsp.pyright.setup{}

nvim_lsp.clangd.setup{
    on_attach = function(client, bufnr)
        -- Your `on_attach` function here if you have one
    end,
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}



vim.cmd [[
autocmd BufEnter * set foldmethod=expr foldexpr=Inline_fold#fold()
]]


-- Add CSS Language Server configuration
nvim_lsp.cssls.setup{
    cmd = {"css-languageserver", "--stdio"},
    filetypes = {"css", "scss", "less"},
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    end,
}





vim.api.nvim_set_keymap('n', '<Leader>(', '<Cmd>lua surround.surround("(", ")")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>\'', '<Cmd>lua surround.surround("\'", "\'")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>"', '<Cmd>lua surround.surround("\"", "\"")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>{', '<Cmd>lua surround.surround("{", "}")<CR>', {noremap = true, silent = true})




-- Keybinding for NERDTree
vim.api.nvim_set_keymap('n', '<C-b>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>n', ':NERDTreeFind<CR>', { noremap = true, silent = true })
vim.g.webdevicons_enable_nerdtree = 1 
-- Show hidden files in NERDTree
vim.g.NERDTreeShowHidden = 1


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
vim.cmd[[autocmd FileType javascript,javascriptreact,vue setlocal tabstop=2 shiftwidth=2 expandtab]]



-- Basic Key mappings
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':x<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>\\', ':vsp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>[', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>]', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', [[<Cmd>lua vim.api.nvim_buf_delete(0, { force = true })<CR>]], { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })




-- Buffer navigation
vim.api.nvim_set_keymap('n', '<Leader>{', ':bprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>}', ':bnext<CR>', { noremap = true })


vim.cmd('syntax enable')
vim.wo.number = true
-- Equivalent of 'set relativenumber'
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
-- Equivalent of 'set autoindent'
-- vim.bo.autoindent = true  -- Uncomment this line if you want auto-indent
vim.o.mouse = 'a'
vim.cmd('colorscheme slate')
-- vim.cmd('colorscheme gruvbox')
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




vim.g.rainbow_active = 1 -- set to 0 if you want to disable the plugin

vim.g.rainbow_conf = {
    guifgs = {'Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Purple'}, -- set your colors here
    terms = {'ctermfg=1', 'ctermfg=3', 'ctermfg=3', 'ctermfg=2', 'ctermfg=4', 'ctermfg=5'}, -- if you use terminal vim and want to set terminal colors
    operators = '_,_',
    parens = {'start=\\(/ end=\\)/ fold', 'start=\\[/ end=\\]/ fold', 'start=\\{/ end=\\}/ fold'}, -- default delimiters, you can add more
    termcolors = {1, 3, 3, 2, 4, 5}, -- terminal colors
    separately = {} -- empty to apply to all filetypes
}

-- Specify for Vue files
vim.g.rainbow_conf.separately['vue'] = {
    parens = {
        'start=\\{/ end=\\}/ fold',
        'start=\\[/ end=\\]/ fold',
        'start=\\(/ end=\\)/ fold',
        'start=<template> end=</template> fold',
        'start=<script> end=</script> fold',
        'start=<style> end=</style> fold',
    },
    -- Add or modify other settings specific to Vue as necessary
}


vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
        ['+'] = 'reattach-to-user-namespace pbcopy',
        ['*'] = 'reattach-to-user-namespace pbcopy',
    },
    paste = {
        ['+'] = 'reattach-to-user-namespace pbpaste',
        ['*'] = 'reattach-to-user-namespace pbpaste',
    },
    cache_enabled = 1,
}
vim.api.nvim_set_keymap('n', '<Leader>y', 'ggVG"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true, silent = true })


vim.g.clang_format_auto = 1
vim.g.clang_format_on_save = 1
vim.cmd[[autocmd FileType cpp,hpp setlocal tabstop=2 shiftwidth=2 expandtab]]
vim.cmd [[ autocmd BufWritePre *.cpp,*.hpp ClangFormat ]]

vim.cmd([[
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>:FloatermToggle<CR>
]])

-- Floaterm key mappings
vim.g.floaterm_keymap_toggle = '<Leader>t'
-- vim.g.floaterm_keymap_next   = '<Leader>tn'
-- vim.g.floaterm_keymap_prev   = '<Leader>tp'
-- vim.g.floaterm_keymap_new    = '<Leader>tt'
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_title='Mois Terminal'


vim.cmd [[
  autocmd BufRead,BufNewFile *.jsx,*.tsx setlocal filetype=javascriptreact
]]

_G.clear_search_highlight = function()
    vim.cmd('noh')
    -- Return the escape sequence to leave normal mode
    return vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
end
vim.api.nvim_set_keymap('n', '<Esc>', 'v:lua.clear_search_highlight()', { noremap = true, expr = true, silent = true })





-- Configure neoformat to use rustfmt for Rust
-- vim.cmd([[
--   let g:neoformat_enabled_rust = ['rustfmt']
-- ]])

vim.cmd([[
  let g:neoformat_rust_rustfmt = {
            \ 'exe': 'rustup',
            \ 'args': ['run', 'nightly', 'rustfmt', '--edition', '2021'],
            \ 'stdin': 1,
            \ }
  let g:neoformat_enabled_rust = ['rustfmt']
]])

-- Automatically run neoformat on save for Rust files
vim.cmd([[
  autocmd BufWritePre *.rs Neoformat
]])


-- vim.g.neoformat_verbose = 1


