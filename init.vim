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
Plug 'https://github.com/neoclide/coc.nvim',{'do': 'yarn install --frozen-lockfile'} " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'justinmk/vim-sneak' " Sneak adds fast movement
Plug 'tpope/vim-commentary' " Comment lines
Plug 'ahmedkhalf/project.nvim'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'voldikss/vim-floaterm'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'chiel92/vim-autoformat'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

" COC plugin following tutorial from https://www.chrisatmachine.com/blog/category/neovim/04-vim-coc
source $HOME/.config/nvim/plug-config/coc.vim

" NERDCommenter plugin
filetype plugin on

" Gitsigns plugin
lua << EOF
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '+', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    }
}
EOF

" Project plugin
lua require("project_nvim").setup {}
lua require('telescope').load_extension('projects')

" Sneak plugin
let g:sneak#label = 1

" Autoformat plugin
let g:formatdef_my_custom_py = '"black --line-length 120 -"'
"let g:formatdef_my_custom_py = '"python3 /home/per/Documents/personal-coding/pygamelib/examples/main.py %"" '
let g:formatters_python = ['my_custom_py']
augroup format_on_save
    autocmd!
    autocmd! BufWrite *.py :Autoformat
augroup END

" NERDTree plugin
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeShowHidden=1

" Colorscheme
if 0 || (strftime("%H") < 6 && strftime("%H") > 17)
    colorscheme sonokai
else
    set background=light
    if 0
        colorscheme gruvbox
    else
        colorscheme everforest
    endif
endif
" Make background transparent for Windows terminal
if $TERM == "xterm-256color"
    set background=dark
    colorscheme sonokai
    hi Normal guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    hi NonText guibg=NONE ctermbg=NONE
endif

" Set leader key
let g:mapleader = " "

" Telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>

" NERDTree keybindings
nnoremap <leader>n :NERDTreeToggle<cr>

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
vnoremap <silent> // y:let @/='<C-R>=escape(@",'/\[]')<CR>'<CR>:set hlsearch<CR>

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
nnoremap <Leader>o mao<Esc>`a
nnoremap <Leader>O maO<Esc>`a

" Alt keys to move lines
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" VimRC keybind
nnoremap <Leader>, :tabe $VIMCONFIG<CR>G

" Float terminal
nnoremap <silent> <C-t> :update<CR>:FloatermToggle<CR>
tnoremap <silent> <C-t> <Esc><C-\><C-n>:FloatermToggle<CR>

" Quick close
nnoremap <Leader>q :q<CR>

" Catch control space which the terminal interprets as C-@
inoremap <C-Space> <Nop>

" Quick repeat last terminal command. This is semi-hacky
nmap <silent> <Leader>b :update<CR>:FloatermNew --wintype=split --autoclose=0 ./%<CR>

" Paste while in insert mode
imap <silent> <C-p> <Esc>Pi

" Git keybinds
nnoremap <Leader>vYYY :Gitsigns XXX<CR>
nnoremap <Leader>vsh :Gitsigns stage_hunk<CR>
nnoremap <Leader>vuh :Gitsigns undo_stage_hunk<CR>
nnoremap <Leader>vph :Gitsigns preview_hunk<CR>
nnoremap <Leader>vtd :Gitsigns toggle_word_diff<CR>
nnoremap <Leader>vc :!git commit -m "

