" Vim RC

set nocompatible
set guicursor=
set relativenumber
set nu
set noerrorbells
set belloff=all
set tabstop=4
set shiftwidth=4
set expandtab
set formatoptions-=cro

set mouse+=a

set noswapfile
set undofile
set undodir=~/.vim/undodir

set ignorecase
set smartcase
set incsearch
set termguicolors
set scrolloff=10
set completeopt=menuone,noinsert,noselect,preview

call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'vim-airline/vim-airline'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'justinmk/vim-sneak' " Sneak adds fast movement
Plug 'tpope/vim-commentary' " Comment lines
Plug 'ahmedkhalf/project.nvim'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'

" Media files telescope
Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
call plug#end()

"lua require'telescope'.setup { filetypes = {"png", "webp", "jpg", "jpeg"}, find_cmd = "rg" }
lua require('telescope').load_extension('media_files')

" NERDCommenter plugin
filetype plugin on

" Project plugin
lua require("project_nvim").setup {}
lua require('telescope').load_extension('projects')

" Sneak plugin
let g:sneak#label = 1

" NERDTree plugin
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeShowHidden=1

" Colorscheme
colorscheme gruvbox

" Set leader key
let g:mapleader = " "

" Telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" NERDTree keybindings
nnoremap <c-t> :NERDTreeToggle<cr>

" Switch tab
nmap <silent> <S-Tab> :tabprev<Return>
nmap <silent> <Tab> :tabnext<Return>

" Fast jk to escape
imap jk <Esc>

" Control S to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Auto reload vimrc on save
augroup reload_vimrc
    autocmd!
    autocmd! BufWritePost $MYVIMRC nested source %
augroup END

" Make help open in new tab
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
cnoreabbrev <expr> he getcmdtype() == ":" && getcmdline() == 'he' ? 'tab help' : 'he'
cnoreabbrev <expr> hel getcmdtype() == ":" && getcmdline() == 'hel' ? 'tab help' : 'hel'
cnoreabbrev <expr> help getcmdtype() == ":" && getcmdline() == 'help' ? 'tab help' : 'help'

" Search for selection
vnoremap <silent> // y:let @/='<C-R>=escape(@",'/\')<CR>'<CR>:set hlsearch<CR>

" Control D to select current word
nmap <C-d> viw//gv
vmap <silent> <C-d> //gv
nnoremap <silent> <CR> :noh<CR>

" Keybinding to insert a single character
nmap <silent> , "=nr2char(getchar())<cr>P

" Remove arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Alt keys to move lines
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

